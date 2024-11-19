import 'dart:convert';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;

class StripeService {
  static const String _secretKey = 'sk_test_...';
  static const String _publishableKey = 'pk_test_...';
  
  static Future<void> initialize() async {
    Stripe.publishableKey = _publishableKey;
    await Stripe.instance.applySettings();
  }

  static Future<Map<String, dynamic>> createPaymentIntent(
    int amount,
    String currency,
  ) async {
    try {
      Map<String, dynamic> body = {
        'amount': amount.toString(),
        'currency': currency,
        'payment_method_types[]': 'card',
        'description': 'IronFit Premium Subscription',
      };

      var response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        headers: {
          'Authorization': 'Bearer $_secretKey',
          'Content-Type': 'application/x-www-form-urlencoded'
        },
        body: body,
      );
      return json.decode(response.body);
    } catch (err) {
      throw Exception(err.toString());
    }
  }
} 