import 'package:flutter_braintree/flutter_braintree.dart';

class PaymentServices {
  static submitPayment() async {
    try {
      final request = BraintreeDropInRequest(
        clientToken: 'sandbox_rzxp79vs_w7m3b89fk4mdh8z7',
        collectDeviceData: true,
        googlePaymentRequest: BraintreeGooglePaymentRequest(
          totalPrice: '0.20',
          currencyCode: 'USD',
          billingAddressRequired: false,
        ),
        paypalRequest: BraintreePayPalRequest(
          amount: '0.20',
          displayName: 'Example company',
        ),
      );
      BraintreeDropInResult? result = await BraintreeDropIn.start(request);
      if (result != null) {
        print('Nonce: ${result.paymentMethodNonce.nonce}');
      } else {
        print('Selection was canceled.');
      }
    } catch (e) {
      print('Error: $e');
    }
  }
}
