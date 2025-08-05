import 'dart:convert';

import 'package:ecommerse_app/features/data/models/cart_product_model.dart';
import 'package:ecommerse_app/features/domain/entities/cart.dart';

class CartModel extends Cart{
   CartModel({
     int? id,
    required int userId,
    required DateTime date,
    required List<CartProductModel> products,
  }) : super(id: id, userId: userId, date: date, products: products);

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'userId': userId,
      'date': date.millisecondsSinceEpoch,
      'products': products.map((x) => x).toList(),
    };
  }
  factory CartModel.fromEntity(Cart cart) {
    return CartModel(
      date: cart.date,
      products: cart.products.map((e) => CartProductModel.fromEntity(e)).toList()  ,
      userId: cart.userId,
      id: cart.id
    );
  }
  factory CartModel.fromMap(Map<String, dynamic> map) {
    return CartModel(
      id: map['id'] as int,
      userId: map['userId'] as int,
      date: DateTime.parse(map['date'] as String),
      products: List<CartProductModel>.from((map['products'] as List<dynamic>).map<CartProductModel>((x) => CartProductModel.fromMap(x),),),
    );
  }

  String toJson() => json.encode(toMap());

  factory CartModel.fromJson(String source) => CartModel.fromMap(json.decode(source) as Map<String, dynamic>);
}