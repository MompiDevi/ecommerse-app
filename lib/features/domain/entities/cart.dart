// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'package:ecommerse_app/features/domain/entities/cart_product.dart';

class Cart extends Equatable {
  final int? id;
  final int userId;
  final DateTime date;
  final List<CartProduct> products;

  Cart({
     this.id,
    required this.userId,
    required this.date,
    required this.products,
  });
  
  @override
  List<Object?> get props => [id, userId, date, products];

  Cart copyWith({
    int? id,
    int? userId,
    DateTime? date,
    List<CartProduct>? products,
  }) {
    return Cart(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      date: date ?? this.date,
      products: products ?? this.products,
    );
  }
}
