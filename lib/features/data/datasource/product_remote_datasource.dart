import 'dart:convert';
import 'package:ecommerse_app/core/services/network_service.dart';
import 'package:ecommerse_app/core/api_endpoints.dart';
import '../models/product_model.dart';

class ProductRemoteDataSource {
  final NetworkService networkService;
  ProductRemoteDataSource({required this.networkService});

  Future<List<ProductModel>> getAllProducts() async {
    final response = await networkService.get(ApiEndpoints.products);
    if (response.statusCode == 200) {
      return (response.data as List).map((json) => ProductModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }
}
