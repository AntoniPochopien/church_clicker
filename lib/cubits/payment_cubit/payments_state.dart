part of 'payments_cubit.dart';

class PaymentsState {
  bool pending;
  bool avaliable;
  List<ProductDetails> products;
  List<PurchaseDetails> purchases;

  PaymentsState({
    required this.pending,
    required this.avaliable,
    required this.products,
    required this.purchases,
  });

  PaymentsState copyWith({
    bool? pending,
    bool? avaliable,
    List<ProductDetails>? products,
    List<PurchaseDetails>? purchases,
  }) =>
      PaymentsState(
          pending: pending ?? this.pending,
          avaliable: avaliable ?? this.avaliable,
          products: products ?? this.products,
          purchases: purchases ?? this.purchases);
}
