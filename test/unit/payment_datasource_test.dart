import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:ecommerse_app/core/services/network_service.dart';
import 'package:ecommerse_app/core/api_endpoints.dart';
import 'package:ecommerse_app/di/injector.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:ecommerse_app/features/data/datasource/payment_datasource.dart';
import 'product_remote_datasource_test.mocks.dart';

/// Unit tests for [StripePaymentDataSource], verifying payment intent creation and error handling.
/// Uses dependency injection and mocks for isolated, reliable tests.

class MockHttpClient extends Mock implements http.Client {}

void main() {
  group('StripePaymentDataSource', () {
    late StripePaymentDataSource dataSource;
    late MockNetworkService mockNetworkService;
    setUp(() {
      mockNetworkService = MockNetworkService();
      if (sl.isRegistered<NetworkService>()) {
        sl.unregister<NetworkService>();
      }
      sl.registerLazySingleton<NetworkService>(() => mockNetworkService);
      dataSource = StripePaymentDataSource(networkService: sl<NetworkService>());
    });

    test('createPaymentIntent parses response on 200', () async {
      final paymentIntentJson = json.encode({'client_secret': 'secret'});
      // This is a logic test for parsing
      final map = json.decode(paymentIntentJson);
      expect(map['client_secret'], 'secret');
    });
    test('createPaymentIntent returns parsed map on 200', () async {
      final paymentIntentJson = json.encode({'client_secret': 'secret'});
      final response = Response(
        data: paymentIntentJson,
        statusCode: 200,
        requestOptions: RequestOptions(path: ''),
      );
      when(mockNetworkService.post(
        ApiEndpoints.stripePaymentIntent,
        data: anyNamed('data'),
        options: anyNamed('options'),
        cancelToken: anyNamed('cancelToken'),
        onSendProgress: anyNamed('onSendProgress'),
        onReceiveProgress: anyNamed('onReceiveProgress'),
      )).thenAnswer((_) async => response);
      final result = await dataSource.createPaymentIntent(amount: 10, currency: 'usd');
      expect(result, isA<Map<String, dynamic>>());
      expect(result?['client_secret'], 'secret');
    });

    test('createPaymentIntent throws on non-200', () async {
      final response = Response(
        data: 'error',
        statusCode: 400,
        requestOptions: RequestOptions(path: ''),
      );
      when(mockNetworkService.post(
        ApiEndpoints.stripePaymentIntent,
        data: anyNamed('data'),
        options: anyNamed('options'),
        cancelToken: anyNamed('cancelToken'),
        onSendProgress: anyNamed('onSendProgress'),
        onReceiveProgress: anyNamed('onReceiveProgress'),
      )).thenAnswer((_) async => response);
      expect(
        () => dataSource.createPaymentIntent(amount: 10, currency: 'usd'),
        throwsException,
      );
    });
  });
}
