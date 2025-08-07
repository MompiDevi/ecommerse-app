import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:ecommerse_app/core/constants.dart';
import 'package:ecommerse_app/core/api_endpoints.dart';
import 'package:ecommerse_app/core/services/network_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

class StripePaymentDataSource {
  final NetworkService networkService;
  StripePaymentDataSource({required this.networkService});

  Future<Map<String, dynamic>?> createPaymentIntent({
    required double amount,
    required String currency,
  }) async {
    final response = await networkService.post(
      ApiEndpoints.stripePaymentIntent,
      data: {
        'amount': '${amount.toInt() * 100}',
        'currency': currency,
      },
      options: Options(
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
          'Authorization': 'Bearer $stripeSecretKey',
        },
      ),
    );
    if (response.statusCode == 200) {
      return response.data is Map<String, dynamic>
          ? response.data
          : jsonDecode(response.data) as Map<String, dynamic>;
    } else {
      throw Exception('Failed to create PaymentIntent: ${response.data}');
    }
  }

  Future<String> confirmPayment({
    required double amount,
    required String currency,
    required String merchantDisplayName,
  }) async {
    try {
      final paymentIntentData =
          await createPaymentIntent(amount: amount, currency: currency);
      if (paymentIntentData == null) {
        throw Exception('Failed to create PaymentIntent');
      }

      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: paymentIntentData['client_secret'],
          merchantDisplayName: merchantDisplayName,
          style: ThemeMode.system,
        ),
      );

      await Stripe.instance.presentPaymentSheet();
      debugPrint('Payment successful!');
      return 'Success';
    } on StripeException catch (e) {
      throw Exception('Stripe Exception: ${e.error.localizedMessage}');
    } on PlatformException catch (e) {
      throw Exception('Stripe PlatformException: ${e.message}');
    } catch (e) {
      throw Exception('Payment processing error: $e');
    }
  }
}
