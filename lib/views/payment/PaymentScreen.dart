import 'package:antpay_lite/ViewModel/payment/generateRazorpayorderViewmodel.dart';
import 'package:antpay_lite/res/color_palette.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data/retrofit/auth.dart';
import '../../model/payment/generateRazorpayorderBean.dart';
import '../../preferences/session_ manager.dart';
import '../../repository/common/common_api_repo.dart';
import 'PayuPaymentScreen.dart';

class BillPaymentScreen extends StatefulWidget {
  const BillPaymentScreen({super.key});

  @override
  State<BillPaymentScreen> createState() => BillPaymentScreenState();
}

class BillPaymentScreenState extends State<BillPaymentScreen> {
  var selection;
  late GenerateRazorpayorderBean generateRazorpayorderBeana;
  var generateRazorpayorderIN;
  var radioGroupPayment;

  var paymentMethod = 0;

  var amount = "0";

  TextEditingController _amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    generateRazorpayorderIN =
        Provider.of<GenerateRazorpayorderViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: ColorPalette.white,
        title: Text('BillPayment'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.asset(
              'assets/images/make_pay_banner.png',
              // Replace with your image path
              height: 220.0,
              fit: BoxFit.cover,
            ),
            Card(
              color: ColorPalette.white,
              surfaceTintColor: ColorPalette.white,
              margin: EdgeInsets.symmetric(horizontal: 10.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6.0),
              ),
              elevation: 2.0,
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Load Amount',
                            style: TextStyle(
                              fontFamily: 'rupee_ford',
                              color: Colors.black,
                              fontSize: 14.0,
                            ),
                          ),
                        ),
                        Text(
                          '₹ ${_amountController.text.isNotEmpty?_amountController.text : amount}',
                          // You may replace this with your actual value
                          style: TextStyle(
                            fontFamily: 'rupee_ford',
                            color: Colors.black,
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 4.0),
                    TextField(
                      controller: _amountController,
                      decoration: InputDecoration(
                        hintText: 'Amount',
                        hintStyle: TextStyle(color: Colors.black),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.horizontal(
                            left: Radius.zero,
                            right: Radius.circular(6.0),
                          ),
                        ),
                      ),
                      keyboardType: TextInputType.number,
                      maxLines: 1,
                      style: TextStyle(fontSize: 12.0),
                    ),
                    SizedBox(height: 7.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        _buildAmountSuggestion('₹ 500'),
                        SizedBox(width: 10.0),
                        _buildAmountSuggestion('₹ 1000'),
                        SizedBox(width: 10.0),
                        _buildAmountSuggestion('₹ 2000'),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20.0),
            Card(
              color: ColorPalette.white,
              surfaceTintColor: ColorPalette.white,
              margin: EdgeInsets.all(10.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6.0),
              ),
              elevation: 2.0,
              child: Column(
                children: [
                  /* RadioListTile(
                    title: Text(
                      'Pay Using your AntPay Wallet',
                      style: TextStyle(fontSize: 16.0),
                    ),
                    value: "Pay Using your AntPay Wallet",
                    groupValue: selection, // You need to manage the selected value
                    onChanged: (value) {
                      setState(() {
                        selection = value!;
                      });
                      // Handle radio button selection
                    },
                  ),
                  Divider(height: 1.0, color: Colors.grey),*/
                  /*  RadioListTile(
                    title: Text(
                      'Pay Using UPI',
                      style: TextStyle(fontSize: 16.0),
                    ),
                    value: "Pay Using UPI",
                    groupValue: selection,
                    // You need to manage the selected value
                    onChanged: (value) {
                      setState(() {
                        selection = value!;
                      });
                      // Handle radio button selection
                    },
                  ),
                  Divider(height: 1.0, color: Colors.grey),*/
                  RadioListTile(
                    title: Text(
                      'Pay Using Debit/Credit Card, Net Banking, Wallet or UPI ID',
                      style: TextStyle(fontSize: 16.0),
                    ),
                    value:
                        "Pay Using Debit/Credit Card, Net Banking, Wallet or UPI ID",
                    groupValue: selection,
                    // You need to manage the selected value
                    onChanged: (value) {
                      setState(() {
                        selection = value!;
                      });
                      // Handle radio button selection
                    },
                  ),
                  const SizedBox(height: 4),
                  Padding(
                    padding: EdgeInsets.only(
                        left: 200, right: 00, top: 6, bottom: 6),
                    child: Text(
                      '2.15% convenience fee extra',
                      textAlign: TextAlign.end,
                      style: TextStyle(
                        fontSize: 7.0,
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'rupee_ford',
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.0),
            Card(
              color: ColorPalette.white,
              surfaceTintColor: ColorPalette.white,
              margin: EdgeInsets.all(10.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6.0),
              ),
              elevation: 2.0,
              child: Padding(
                padding: EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(0.0),
                          child: Text(
                            '₹ ${_amountController.text.isNotEmpty?_amountController.text : amount}',
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            // Handle view details action
                          },
                          child: Row(
                            children: [
                              Text(
                                'View Details',
                                style: TextStyle(
                                  fontSize: 14.0,
                                  color: Colors.blue,
                                ),
                              ),
                              Icon(
                                Icons.arrow_forward,
                                color: Colors.blue,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (selection == 0) {
                          checkUser();
                          //checkWalletBalance();
                        } else if (selection == 3) {
                          fetchAPIKey();
                        } else {
                          /*  Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => PayuPaymentScreen(),
                          ));
*/
                          generateRazorpayorder();
                        }

                        // Handle pay now button click
                      },
                      style: ElevatedButton.styleFrom(
                          primary: Colors.blue,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0))),
                      child: Text(
                        'Pay Now',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 70.0), // Adjust as needed
          ],
        ),
      ),
    );
  }

  Widget _buildAmountSuggestion(String amount) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _amountController.text =
              amount.replaceAll('₹ ', ''); // Update the text field
        });
      },
      child: Container(
        height: 30.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6.0),
          border: Border.all(color: Colors.black),
        ),
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 14.0),
            child: Text(
              amount,
              style: TextStyle(
                fontFamily: 'rupee_ford',
                color: Colors.black,
                fontSize: 10.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildInfoRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.all(7.0),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Text(
              label,
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          ),
          Expanded(
            flex: 0,
            child: Text(
              ':',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              value,
              textAlign: TextAlign.end,
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> generateRazorpayorder() async {
    CommonApiRepo repoClass = CommonApiRepo();

    GenerateRazorpayorderModel data = GenerateRazorpayorderModel(
        amount: "1",
        mobile: SessionManager().getMobile(),
        service: 'ppi-wallet',
        channel: 'PG');

    generateRazorpayorderBeana = await repoClass.apiClient
        .generateRazorpayorder(data, AuthToken.getAuthToken(),
            SessionManager().getToken().toString());

    print(generateRazorpayorderBeana.ant_txn_id.toString());
    SessionManager().addAntTxnId(generateRazorpayorderBeana.ant_txn_id.toString());

    print('Response--->');
    print("ant_txn_id : ${generateRazorpayorderBeana.ant_txn_id.toString()}");
    print("api_key : ${generateRazorpayorderBeana.api_key}");
    print("order_id : ${generateRazorpayorderBeana.order_id}");
    print("msg : ${generateRazorpayorderBeana.msg}");

   /* SessionManager().addGnerateOrderResponse(
        generateRazorpayorderBeana.order_id.toString(),
        generateRazorpayorderBeana.api_key.toString(),
        generateRazorpayorderBeana.ant_txn_id.toString(),
        "",
        "",
        "");*/

    setState(() {
      /* RazorpaySingleton().makePayment(
          generateRazorpayorderBeana.api_key,
          generateRazorpayorderBeana.order_id,
          generateRazorpayorderBeana.ant_txn_id,context);*/

      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => PayuPaymentScreen(),
      ));
    });

    // }
    setState(() {});
  }

  void upiPay() {}

  void fetchAPIKey() {}
}

void checkUser() {}
