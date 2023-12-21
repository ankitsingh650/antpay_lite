// payment_screen.dart

import 'dart:convert';

import 'package:antpay_lite/preferences/session_%20manager.dart';
import 'package:antpay_lite/res/color_palette.dart';
import 'package:flutter/material.dart';
import 'package:payu_checkoutpro_flutter/PayUConstantKeys.dart';
import 'package:payu_checkoutpro_flutter/payu_checkoutpro_flutter.dart';

import 'HashService.dart';

class PayuPaymentScreen extends StatefulWidget {
  const PayuPaymentScreen({super.key});

  @override
  State<PayuPaymentScreen> createState() => _PayuPaymentScreenState();
}

class _PayuPaymentScreenState extends State<PayuPaymentScreen>
    implements PayUCheckoutProProtocol {
  late PayUCheckoutProFlutter _checkoutPro;

  @override
  void initState() {
    super.initState();

    print("ant_txn_id_2 : ${SessionManager().getAntTxnId()}");
    _checkoutPro = PayUCheckoutProFlutter(this);

    _checkoutPro.openCheckoutScreen(
      payUPaymentParams: PayUParams.createPayUPaymentParams(),
      payUCheckoutProConfig: PayUParams.createPayUConfigParams(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Load Wallet'),
        ),
        /*  body: Center(
          child: ElevatedButton(
            child: const Text("Start Payment"),
            onPressed: () async {
              _checkoutPro.openCheckoutScreen(
                payUPaymentParams: PayUParams.createPayUPaymentParams(),
                payUCheckoutProConfig: PayUParams.createPayUConfigParams(),
              );
            },
          ),
        ),*/
      ),
    );
  }

  showAlertDialog(BuildContext context, String title, String content) {
    Widget okButton = TextButton(
      child: const Text("OK"),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(title),
            content: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: new Text(content),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text("OK"),
                onPressed: () {
                  Navigator.pop(context);
                },
              )
            ],
          );
        });
  }

  @override
  generateHash(Map response) {
    print("hashName: ${response}");
    // Backend will generate the hash which you need to pass to SDK
    // hashResponse: is the response which you get from your server

    late Map hashResponse; // ={"payment_related_details_for_mobile_sdk":"66da13b8b91db9abbe6747f7c766df8120f752a76f74ef35d6f14c1f03db1758324fe289f056623eaa5cc2bd58358c946984ce7cae40f6833cc61a4399ebefbb"};

    //Keep the salt and hash calculation logic in the backend for security reasons. Don't use local hash logic.
    //Uncomment following line to test the test hash.
    hashResponse = HashService.generateHash(response);

    print("testHash ${hashResponse}");

    _checkoutPro.hashGenerated(hash: hashResponse);
  }

  @override
  onPaymentSuccess(dynamic response) {
    print("payment Response  ${response}");

    showAlertDialog(context, "onPaymentSuccess", response.toString());
  }

  @override
  onPaymentFailure(dynamic response) {
    showAlertDialog(context, "onPaymentFailure", response.toString());
  }

  @override
  onPaymentCancel(Map? response) {
    showAlertDialog(context, "onPaymentCancel", response.toString());
  }

  @override
  onError(Map? response) {
    showAlertDialog(context, "onError", response.toString());
  }
}

class PayUTestCredentials {
  //Find the test credentials from dev guide: https://devguide.payu.in/flutter-sdk-integration/getting-started-flutter-sdk/mobile-sdk-test-environment/
  static const merchantKey = "LMQfIC"; // Add you Merchant Key
  static const iosSurl =
      "https://antworksmoney.com/apiserver/antapp/success_payuresponse";
  static const iosFurl =
      "https://antworksmoney.com/apiserver/antapp/failure_payuresponse";
  static const androidSurl =
      "https://antworksmoney.com/apiserver/antapp/success_payuresponse";
  static const androidFurl =
      "https://antworksmoney.com/apiserver/antapp/failure_payuresponse";

  static const merchantAccessKey = ""; //Add Merchant Access Key - Optional
  static const sodexoSourceId = ""; //Add sodexo Source Id - Optional
}

//Pass these values from your app to SDK, this data is only for test purpose
class PayUParams {
  static Map createPayUPaymentParams() {
    var siParams = {
      PayUSIParamsKeys.isFreeTrial: true,
      PayUSIParamsKeys.billingAmount: '1',
      //Required
      PayUSIParamsKeys.billingInterval: 1,
      //Required
      PayUSIParamsKeys.paymentStartDate: '2023-12-20',
      //Required
      PayUSIParamsKeys.paymentEndDate: '2023-12-30',
      //Required
      PayUSIParamsKeys.billingCycle: //Required
          'daily',
      //Can be any of 'daily','weekly','yearly','adhoc','once','monthly'
      PayUSIParamsKeys.remarks: 'Test SI transaction',
      PayUSIParamsKeys.billingCurrency: 'INR',
      PayUSIParamsKeys.billingLimit: 'ON',
      //ON, BEFORE, AFTER
      PayUSIParamsKeys.billingRule: 'MAX',
      //MAX, EXACT
    };

    var additionalParam = {
      PayUAdditionalParamKeys.udf1: "udf1",
      PayUAdditionalParamKeys.udf2: "udf2",
      PayUAdditionalParamKeys.udf3: "udf3",
      PayUAdditionalParamKeys.udf4: "udf4",
      PayUAdditionalParamKeys.udf5: "udf5",
      PayUAdditionalParamKeys.merchantAccessKey:
          PayUTestCredentials.merchantAccessKey,
      //   PayUAdditionalParamKeys.sourceId: PayUTestCredentials.sodexoSourceId,
    };

    var spitPaymentDetails = {
      "type": "absolute",
      "splitInfo": {
        PayUTestCredentials.merchantKey: {
          "aggregatorSubTxnId": "1234567540099887766650091",
          //unique for each transaction
          "aggregatorSubAmt": "1"
        }
      }
    };

    var payUPaymentParams = {
      PayUPaymentParamKey.key: "LMQfIC",

      PayUPaymentParamKey.amount: "1.02",
      PayUPaymentParamKey.productInfo: "ProductInfo",
      PayUPaymentParamKey.firstName: SessionManager().getName(),
      PayUPaymentParamKey.email: SessionManager().getUserEmail(),
      PayUPaymentParamKey.phone: SessionManager().getMobile(),
      PayUPaymentParamKey.ios_surl: PayUTestCredentials.iosSurl,
      PayUPaymentParamKey.ios_furl: PayUTestCredentials.iosFurl,
      PayUPaymentParamKey.android_surl: PayUTestCredentials.androidSurl,
      PayUPaymentParamKey.android_furl: PayUTestCredentials.androidFurl,
      PayUPaymentParamKey.environment: "0",
      //0 => Production 1 => Test
      PayUPaymentParamKey.userCredential: SessionManager().getMobile(),
      //Pass user credential to fetch saved cards => A:B - Optional
      PayUPaymentParamKey.transactionId: SessionManager().getAntTxnId(),
      // PayUPaymentParamKey.additionalParam: additionalParam,
      PayUPaymentParamKey.enableNativeOTP: true,
      // PayUPaymentParamKey.splitPaymentDetails: json.encode(spitPaymentDetails),
      PayUPaymentParamKey.userToken: "",
      //Pass a unique token to fetch offers. - Optional
    };

    return payUPaymentParams;
  }

  static Map createPayUConfigParams() {
    var paymentModesOrder = [
      {"Wallets": "PHONEPE"},
      {"UPI": "TEZ"},
      {"Wallets": ""},
      {"EMI": ""},
      {"NetBanking": ""},
    ];

    var cartDetails = [
      {"GST": "5%"},
      {"Delivery Date": "25 Dec"},
      {"Status": "In Progress"}
    ];
    var enforcePaymentList = [
      {"payment_type": "CARD", "enforce_ibiboCode": "UTIBENCC"},
    ];

    var customNotes = [
      {
        "custom_note": "Its Common custom note for testing purpose",
        "custom_note_category": [
          PayUPaymentTypeKeys.emi,
          PayUPaymentTypeKeys.card
        ]
      },
      {
        "custom_note": "Payment options custom note",
        "custom_note_category": null
      }
    ];

    var payUCheckoutProConfig = {
      PayUCheckoutProConfigKeys.primaryColor: "#338DFF",
      PayUCheckoutProConfigKeys.secondaryColor: "#FFFFFF",
      PayUCheckoutProConfigKeys.merchantName: "Antpay",
      // PayUCheckoutProConfigKeys.merchantLogo: "logo",
      PayUCheckoutProConfigKeys.showExitConfirmationOnCheckoutScreen: true,
      PayUCheckoutProConfigKeys.showExitConfirmationOnPaymentScreen: true,
      // PayUCheckoutProConfigKeys.cartDetails: cartDetails,
      // PayUCheckoutProConfigKeys.paymentModesOrder: paymentModesOrder,
      PayUCheckoutProConfigKeys.merchantResponseTimeout: 30000,
      // PayUCheckoutProConfigKeys.customNotes: customNotes,
      PayUCheckoutProConfigKeys.autoSelectOtp: true,
      PayUCheckoutProConfigKeys.waitingTime: 30000,
      PayUCheckoutProConfigKeys.autoApprove: false,
      PayUCheckoutProConfigKeys.merchantSMSPermission: true,
      PayUCheckoutProConfigKeys.showCbToolbar: true,
    };
    return payUCheckoutProConfig;
  }
}
