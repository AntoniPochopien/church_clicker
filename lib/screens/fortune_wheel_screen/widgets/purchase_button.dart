import 'package:church_clicker/cubits/payment_cubit/payments_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:in_app_purchase/in_app_purchase.dart';

class PurchaseButton extends StatelessWidget {
  final int spinsAmount;
  final String productId;
  final ProductDetails productDetails;
  const PurchaseButton(
      {super.key,
      required this.spinsAmount,
      required this.productDetails,
      required this.productId});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: BeveledRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      onPressed: () {
        BlocProvider.of<PaymentsCubit>(context)
            .buyProduct(productId: productId);
      },
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                spinsAmount.toString(),
                style: const TextStyle(color: Color(0xFFE10032), fontSize: 30),
              ),
              SizedBox(
                height: 22,
                width: 28,
                child: SvgPicture.asset(
                  'assets/images/svg/general/gold.svg',
                ),
              ),
            ],
          ),
          Text(
            productDetails.price,
            style: const TextStyle(color: Colors.black, fontSize: 22),
          )
        ],
      ),
    );
  }
}
