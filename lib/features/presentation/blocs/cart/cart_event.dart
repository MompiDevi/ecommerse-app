part of 'cart_bloc.dart';

@immutable
sealed class CartEvent {}

class LoadCart extends CartEvent{
  final int userId;

  LoadCart({required this.userId});
}

class AddToCartEvent extends CartEvent{
  final Cart cart;

  AddToCartEvent({required this.cart});
}

class RemoveFromCart extends CartEvent {
  final int productId;
   RemoveFromCart(this.productId);
}

class UpdateCartItemQuantity extends CartEvent {
  final int userId;
  final int productId;
  final int newQuantity;

   UpdateCartItemQuantity({
    required this.userId,
    required this.productId,
    required this.newQuantity,
  });
}