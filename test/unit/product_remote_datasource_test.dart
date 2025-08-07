import 'dart:convert';
import 'package:ecommerse_app/core/services/network_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:dio/dio.dart';
import 'package:mockito/mockito.dart';
import 'package:ecommerse_app/features/data/datasource/product_remote_datasource.dart';
import 'package:ecommerse_app/features/data/models/product_model.dart';
import 'package:ecommerse_app/di/injector.dart';
import 'package:mockito/annotations.dart';
import 'package:ecommerse_app/core/services/network_service.dart';
import 'package:ecommerse_app/core/api_endpoints.dart';
import 'product_remote_datasource_test.mocks.dart';

@GenerateMocks([NetworkService])
void main() {
  group('ProductRemoteDataSource', () {
    late ProductRemoteDataSource dataSource;
    late MockNetworkService mockNetworkService;

    setUp(() {
      mockNetworkService = MockNetworkService();
      if (sl.isRegistered<NetworkService>()) {
        sl.unregister<NetworkService>();
      }
      sl.registerLazySingleton<NetworkService>(() => mockNetworkService);
      dataSource = ProductRemoteDataSource(networkService: sl<NetworkService>());
    });

    test('getAllProducts returns list on 200', () async {
      print('Test started');
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
      final response = Response(
        data: productsJson,
        statusCode: 200,
        requestOptions: RequestOptions(path: ''),
      );
      when(mockNetworkService.get(
        ApiEndpoints.products,
        queryParameters: anyNamed('queryParameters'),
        options: anyNamed('options'),
        cancelToken: anyNamed('cancelToken'),
        onReceiveProgress: anyNamed('onReceiveProgress'),
      )).thenAnswer((_) async => response);

      final result = await dataSource.getAllProducts();
      expect(result, isA<List<ProductModel>>());
      expect(result.first.id, 1);
    });
  });
}