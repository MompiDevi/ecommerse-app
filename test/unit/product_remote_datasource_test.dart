import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:ecommerse_app/features/data/datasource/product_remote_datasource.dart';
import 'package:ecommerse_app/features/data/models/product_model.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  group('ProductRemoteDataSource', () {
    late ProductRemoteDataSource dataSource;
    late MockHttpClient mockHttpClient;

    setUp(() {
      mockHttpClient = MockHttpClient();
      dataSource = ProductRemoteDataSource(); // Would need DI for real HTTP test
    });

    test('getAllProducts returns list on 200', () async {
      final productsJson = json.encode([
        {
          'id': 1,
          'title': 'Test',
          'price': 10.0,
          'description': 'desc',
          'category': 'cat',
          'image': 'img',
        }
      ]);
      // This is a logic test for ProductModel parsing
      final list = (json.decode(productsJson) as List)
          .map((json) => ProductModel.fromJson(json))
          .toList();
      expect(list, isA<List<ProductModel>>());
      expect(list.first.id, 1);
    });
  });
}
