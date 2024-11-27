import 'package:flutter_braintree/flutter_braintree.dart';

class PaymentServices {
  static submitPayment() async {
    try {
      final request = BraintreeDropInRequest(
        clientToken: 'sandbox_d5fdtgp3_dw75gy8mp2dhgk88',
        collectDeviceData: true,
        googlePaymentRequest: BraintreeGooglePaymentRequest(
          totalPrice: '1',
          currencyCode: 'USD',
          billingAddressRequired: false,
        ),
        paypalRequest: BraintreePayPalRequest(
          amount: '1',
          displayName: 'Example company',
        ),
      );
      var result = await BraintreeDropIn.start(request);
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
