import 'package:ecommerse_app/features/domain/entities/cart.dart';

abstract class CartRepository{
  Future<Cart> getCartById(int id);
  Future<void> addToCart(Cart model);
  Future<Cart> removeItemFromCart(int productId);
  Future<void> updateCartItemQuantity(int productId, int quantity);
}