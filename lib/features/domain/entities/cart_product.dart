// Domain entity representing a product in the cart, used in business logic and state.
// Immutable and equatable for safe comparison and state updates.
// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class CartProduct extends Equatable {
  final int productID;
  final int quantity;

  CartProduct({required this.productID, required this.quantity});
  
  @override
  List<Object?> get props => [productID, quantity];

  CartProduct copyWith({
    int? productID,
    int? quantity,
  }) {
    return CartProduct(
      productID: productID ?? this.productID,
      quantity: quantity ?? this.quantity,
    );
  }
}
