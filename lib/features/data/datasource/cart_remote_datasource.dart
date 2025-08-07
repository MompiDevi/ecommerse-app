// Data source for all remote cart operations, abstracting network logic for cart CRUD actions.
// Enables testability and separation of concerns by depending on NetworkService.
import 'dart:convert';
import 'package:ecommerse_app/core/services/network_service.dart';
import 'package:ecommerse_app/core/api_endpoints.dart';
import 'package:ecommerse_app/features/data/models/cart_model.dart';

/// Handles remote cart data operations (fetch, add, remove, update).
/// Uses [NetworkService] for HTTP requests, making it easy to mock in tests.
class CartRemoteDataSource {
  final NetworkService networkService;
  CartRemoteDataSource({required this.networkService});

  /// Fetches a cart by its ID. Throws if network or parsing fails.
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

  /// Adds a new cart or item to the cart. Throws if the operation fails.
  Future<void> addToCart(CartModel model) async {
    final response = await networkService.post(ApiEndpoints.carts, data: model.toJson());
    if (response.statusCode != 201) {
      throw Exception(response.statusMessage);
    }
  }

  /// Removes an item from the cart by productId. Returns updated cart or throws on error.
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

  /// Updates the quantity of a cart item. Throws if the update fails.
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