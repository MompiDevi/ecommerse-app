part of 'cart_bloc.dart';

@immutable
sealed class CartState {}

final class CartInitial extends CartState {}

final class CartLoading extends CartState {}

final class CartLoaded extends CartState {
  final Cart? cart;
  
  CartLoaded({required this.cart});
}
final class ItemAddedToCart extends CartState {}

final class CartError extends CartState {
  final String message;

  CartError({required this.message});
  
}
