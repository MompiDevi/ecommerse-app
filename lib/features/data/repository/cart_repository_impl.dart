import 'package:ecommerse_app/features/data/datasource/cart_remote_datasource.dart';
import 'package:ecommerse_app/features/data/models/cart_model.dart';
import 'package:ecommerse_app/features/domain/entities/cart.dart';
import 'package:ecommerse_app/features/domain/repositories/cart_repository.dart';

class CartRepositoryImpl implements CartRepository{
  final CartRemoteDataSource datasource;

  CartRepositoryImpl({required this.datasource});

  @override
  Future<void> addToCart(Cart cart) async {
    return await datasource.addToCart(CartModel.fromEntity(cart));
  }

  @override
  Future<Cart> getCartById(int id) async {
    return await datasource.getCartById(id);
  }
  
  @override
  Future<Cart> removeItemFromCart(int productId) async {
    return await datasource.removeItemFromCart(productId);
  }
  
  @override
  Future<void> updateCartItemQuantity(int productId, int quantity)async {
    return await datasource.updateCartItemQuantity(productId, quantity);
  }

}