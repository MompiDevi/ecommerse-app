// Model for a product in the cart, bridging domain entity and serialization logic.
// Used for mapping between API data and domain layer.
import 'dart:convert';

import 'package:ecommerse_app/features/domain/entities/cart_product.dart';

class CartProductModel extends CartProduct{
  CartProductModel({required super.productID, required super.quantity});

  /// Creates a model from a domain entity for persistence or network transfer.
  factory CartProductModel.fromEntity(CartProduct cartProduct){
    return CartProductModel(productID:cartProduct.productID, quantity: cartProduct.quantity );
  }
   Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'productId': productID,
      'quantity': quantity,
    };
  }

  /// Constructs a model from a map (e.g., API response).
  factory CartProductModel.fromMap(Map<String, dynamic> map) {
    return CartProductModel(
      productID: map['productId'] as int,
      quantity: map['quantity'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory CartProductModel.fromJson(String source) => CartProductModel.fromMap(json.decode(source) as Map<String, dynamic>);
}