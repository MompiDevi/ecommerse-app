import 'dart:convert';
import 'package:ecommerse_app/core/services/network_service.dart';
import 'package:ecommerse_app/core/api_endpoints.dart';
import 'package:ecommerse_app/features/data/models/cart_model.dart';

class CartRemoteDataSource {
  final NetworkService networkService;
  CartRemoteDataSource({required this.networkService});

  Future<CartModel> getCartById(int id) async {
    final response = await networkService.get('${ApiEndpoints.carts}/$id');
    if (response.statusCode == 200) {
      try {
        return CartModel.fromMap(response.data);
      } catch (e) {
        throw Exception(e.toString());
      }
    } else {
      throw Exception(response.statusMessage);
    }
  }

  Future<void> addToCart(CartModel model) async {
    final response = await networkService.post(ApiEndpoints.carts, data: model.toJson());
    if (response.statusCode != 201) {
      throw Exception(response.statusMessage);
    }
  }

  Future<CartModel> removeItemFromCart(int productId) async {
    final response = await networkService.delete('${ApiEndpoints.carts}/1',
      data: jsonEncode({'productId': productId}),
      options: null,
    );
    if (response.statusCode == 200) {
      try {
        return CartModel.fromMap(response.data);
      } catch (e) {
        throw Exception(e.toString());
      }
    } else {
      throw Exception(response.statusMessage);
    }
  }

  Future<void> updateCartItemQuantity(int productId, int quantity) async {
    final response = await networkService.put('${ApiEndpoints.carts}/1',
      data: jsonEncode({'productId': productId, 'quantity': quantity}),
      options: null,
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to update quantity');
    }
  }
}