import 'dart:convert';
import 'package:ecommerse_app/core/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;

class StripePaymentDataSource {

  Future<Map<String, dynamic>?> createPaymentIntent({
    required double amount,
    required String currency,
  }) async {
    final url = Uri.parse('https://api.stripe.com/v1/payment_intents');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
        'Authorization': 'Bearer $stripeSecretKey'
      },
      body: {
        'amount': '${amount.toInt() * 100}',
        'currency': currency,
      },
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to create PaymentIntent: ${response.body}');
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
