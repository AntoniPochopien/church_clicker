import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:flutter/material.dart';

import '../hive_cubit/hive_cubit.dart';

part 'payments_state.dart';

class PaymentsCubit extends Cubit<PaymentsState> {
  PaymentsCubit()
      : super(PaymentsState(
          pending: false,
          avaliable: false,
          products: [],
          purchases: [],
        ));

  late final HiveCubit hiveCubit;
  late StreamSubscription subscription;
  late InAppPurchase iap;

  void start(BuildContext context) {
    hiveCubit = context.read<HiveCubit>();
  }

  void startPurchases() async {
    iap = InAppPurchase.instance;
    final isAvaliable = await iap.isAvailable();
    emit(state.copyWith(avaliable: isAvaliable));
    if (state.avaliable) {
      subscription = iap.purchaseStream.listen(
        (purchaseDetailsList) {
          purchaseDetailsList.forEach(
            (element) async {
              if (element.pendingCompletePurchase) {
                print('GIVING PRODUCT TO USER');
                await iap.completePurchase(element);
              }
            },
          );
          listenToPurchaseUpdated(purchaseDetailsList);
        },
        onDone: () => subscription.cancel(),
        onError: (error) => print(error),
      );
      await getProducts();
    }
  }

  Future<void> getProducts() async {
    // Set<String> ids = {
    //   'pl.netigen.newmetaldetector.noads',
    //   'pl.netigen.newmetaldetector.noadspromotion'
    // };
    // ProductDetailsResponse response = await iap.queryProductDetails(ids);
    // emit(state.copyWith(products: response.productDetails));
  }

  void buyProduct() async {
    final avaliable = await iap.isAvailable();
    emit(state.copyWith(avaliable: avaliable));
    if (state.avaliable) {
      final PurchaseParam purchaseParam = PurchaseParam(
        productDetails: state.products.firstWhere((element) =>
            element.id == 'pl.netigen.newmetaldetector.noadspromotion'),
      );
      await InAppPurchase.instance
          .buyConsumable(purchaseParam: purchaseParam, autoConsume: true);
    }
  }

  void listenToPurchaseUpdated(List<PurchaseDetails> purchaseDetailsList) {
    purchaseDetailsList.forEach(
      (element) {
        print('produkt: ${element.productID}');
        if (element.status == PurchaseStatus.pending) {
          print('produkt pending: ${element.productID}');
          //handle situation when user pressed button to start purchase, (on iOS it takes more time, android have almost immediately response) maybe show some loading spinners
        } else if (element.status == PurchaseStatus.error) {
        } else if (element.status == PurchaseStatus.canceled) {
          print('produkt canceled: ${element.productID}');
          //handle situation when user canceled payment
        } else if (element.status == PurchaseStatus.purchased ||
            element.status == PurchaseStatus.restored) {
          //if purchase or restored, make sure to give users what they payed for
          //Do not override _purchases list if it is not empty! just make sure to add new products to existing list
          //NOT TO DO: _purchases = [elements];
          //DO: _purchases.add(element);
          state.purchases.add(element);
          print('GIVING PRODUCT TO USER');
          iap.completePurchase(element);
        }
      },
    );
  }
}
