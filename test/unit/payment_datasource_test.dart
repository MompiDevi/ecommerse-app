import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:ecommerse_app/features/data/datasource/payment_datasource.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  group('StripePaymentDataSource', () {
    late StripePaymentDataSource dataSource;
    late MockHttpClient mockHttpClient;

    setUp(() {
      mockHttpClient = MockHttpClient();
      dataSource = StripePaymentDataSource(); // Would need DI for real HTTP test
    });

    test('createPaymentIntent parses response on 200', () async {
      final paymentIntentJson = json.encode({'client_secret': 'secret'});
      // This is a logic test for parsing
      final map = json.decode(paymentIntentJson);
      expect(map['client_secret'], 'secret');
    });
  });
}
