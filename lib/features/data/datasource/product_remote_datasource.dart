// Data source responsible for fetching product data from remote APIs via the NetworkService abstraction.
// Keeps network logic decoupled from business logic and enables easy mocking/testing.

import 'package:ecommerse_app/core/services/network_service.dart';
import 'package:ecommerse_app/core/api_endpoints.dart';
import '../models/product_model.dart';

/// Handles all remote product-related data operations.
/// Depends on [NetworkService] for HTTP requests, allowing for DI and testability.
class ProductRemoteDataSource {
  final NetworkService networkService;
  ProductRemoteDataSource({required this.networkService});

  /// Fetches all products from the backend.
  /// Throws [Exception] if the network call fails or returns a non-200 status.
  /// Returns a list of [ProductModel] on success.
  Future<List<ProductModel>> getAllProducts() async {
    final response = await networkService.get(ApiEndpoints.products);
    if (response.statusCode == 200) {
      return (response.data as List).map((json) => ProductModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }
}
