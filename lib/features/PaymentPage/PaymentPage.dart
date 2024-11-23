/*
 Copyright 2018 Square Inc.
 
 Licensed under the Apache License, Version 2.0 (the "License");
 you may not use this file except in compliance with the License.
 You may obtain a copy of the License at
 
 http://www.apache.org/licenses/LICENSE-2.0
 
 Unless required by applicable law or agreed to in writing, software
 distributed under the License is distributed on an "AS IS" BASIS,
 WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 See the License for the specific language governing permissions and
 limitations under the License.
*/
import 'dart:async';
import 'dart:io' show Platform;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ironfit/core/presentation/style/palette.dart';
import 'package:ironfit/core/presentation/widgets/Styles.dart';
import 'package:ironfit/core/presentation/widgets/localization_service.dart';
import 'package:ironfit/features/PaymentPage/BuySheet.dart';
import 'package:square_in_app_payments/google_pay_constants.dart'
    as google_pay_constants;
import 'package:square_in_app_payments/in_app_payments.dart';
import 'package:square_in_app_payments/models.dart';

class PaymentPage extends StatefulWidget {
  PaymentPageState createState() => PaymentPageState();
}

class PaymentPageState extends State<PaymentPage> {
  bool isLoading = true;
  bool applePayEnabled = false;
  bool googlePayEnabled = false;

  static final GlobalKey<ScaffoldState> scaffoldKey =
      GlobalKey<ScaffoldState>();
  final squareLocationId = 'sandbox-sq0idb-dLnDnBS1yKAWplVX8PZErg';

  @override
  void initState() {
    super.initState();
    _initSquarePayment();

    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  }

  Future<void> _initSquarePayment() async {
    await InAppPayments.setSquareApplicationId(squareLocationId);

    var canUseApplePay = false;
    var canUseGooglePay = false;
    if (Platform.isAndroid) {
      await InAppPayments.initializeGooglePay(
          squareLocationId, google_pay_constants.environmentTest);
      canUseGooglePay = await InAppPayments.canUseGooglePay;
    }
    //  else if (Platform.isIOS) {
    //   await _setIOSCardEntryTheme();
    //   await InAppPayments.initializeApplePay(applePayMerchantId);
    //   canUseApplePay = await InAppPayments.canUseApplePay;
    // }

    setState(() {
      isLoading = false;
      applePayEnabled = canUseApplePay;
      googlePayEnabled = canUseGooglePay;
    });
  }

  Future _setIOSCardEntryTheme() async {
    var themeConfiguationBuilder = IOSThemeBuilder();
    themeConfiguationBuilder.saveButtonTitle = 'Pay';
    themeConfiguationBuilder.errorColor = RGBAColorBuilder()
      ..r = 255
      ..g = 0
      ..b = 0;
    themeConfiguationBuilder.tintColor = RGBAColorBuilder()
      ..r = 36
      ..g = 152
      ..b = 141;
    themeConfiguationBuilder.keyboardAppearance = KeyboardAppearance.light;
    themeConfiguationBuilder.messageColor = RGBAColorBuilder()
      ..r = 114
      ..g = 114
      ..b = 114;

    await InAppPayments.setIOSCardEntryTheme(themeConfiguationBuilder.build());
  }

  Widget build(BuildContext context) => Scaffold(
      backgroundColor: Palette.black,
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Palette.black),
            ))
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 40),
                    Text(
                      LocalizationService.translateFromGeneral(
                          'paymentDetails'),
                      style: AppStyles.textCairo(
                        24,
                        Palette.mainAppColorWhite,
                        FontWeight.normal,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 40),
                    if (googlePayEnabled && Platform.isAndroid)
                      ElevatedButton(
                        onPressed: () {
                          // Implement Google Pay payment flow
                        },
                        child: Text(
                          LocalizationService.translateFromGeneral(
                              'payWithGooglePay'),
                          style: AppStyles.textCairo(
                            14,
                            Palette.mainAppColorNavy,
                            FontWeight.w600,
                          ),
                        ),
                      ),
                    if (applePayEnabled && Platform.isIOS)
                      ElevatedButton(
                        onPressed: () {
                          // Implement Apple Pay payment flow
                        },
                        child: const Text('Pay with Apple Pay'),
                      ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        InAppPayments.startCardEntryFlow(
                          onCardNonceRequestSuccess:
                              _onCardEntryCardNonceRequestSuccess,
                          onCardEntryCancel: _onCardEntryCanceled,
                        );
                      },
                      child: Text(
                        LocalizationService.translateFromGeneral('payWithCard'),
                        style: AppStyles.textCairo(
                          14,
                          Palette.mainAppColorNavy,
                          FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ));

  void _onCardEntryCardNonceRequestSuccess(CardDetails result) {
    // Add your card payment processing logic here
    InAppPayments.completeCardEntry(
      onCardEntryComplete: () {
        // Handle successful payment
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Payment successful!')),
        );
      },
    );
  }

  void _onCardEntryCanceled() {
    // Handle canceled payment
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Payment canceled')),
    );
  }
}
