
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../../data/retrofit/auth.dart';

import '../../model/transaction/transaction_history_model.dart';
import '../../model/transaction/transaction_history_model.dart';
import '../../preferences/session_ manager.dart';
import '../../repository/common/common_api_repo.dart';

import '../transaction/list_tile_view.dart';

class TransactionHistory extends StatefulWidget {
  const TransactionHistory({Key? key}) : super(key: key);

  @override
  State<TransactionHistory> createState() => _TransactionHistoryState();
}

class _TransactionHistoryState extends State<TransactionHistory> {

  List <TransactionHistorylist>? transactionlist = [];

  late TransactionHistoryResponseModel TransactionHistoryResponseModelin;
  TextEditingController controller=TextEditingController();
  late var VerifyViewModel;
  int _currentIndex = 0;

  final List<String> images = [
    "https://firebasestorage.googleapis.com/v0/b/antpay-ae6e5.appspot.com/o/OffersBanners%2Foffer_img1.png?alt=media&token=ccdd4d10-8da2-4de3-b942-ee4512e98d30",
    "https://firebasestorage.googleapis.com/v0/b/antpay-ae6e5.appspot.com/o/OffersBanners%2Foffer_img2.png?alt=media&token=53ba165f-3976-482e-8520-ec75b2b418b0",
    "https://firebasestorage.googleapis.com/v0/b/antpay-ae6e5.appspot.com/o/OffersBanners%2Foffer_img3.png?alt=media&token=beef4fba-aa51-4980-b61f-9416cdb528d4",
    "https://firebasestorage.googleapis.com/v0/b/antpay-ae6e5.appspot.com/o/OffersBanners%2Foffer_img4.png?alt=media&token=ed796c43-b227-4381-ab2e-32667224b96d",
    "https://firebasestorage.googleapis.com/v0/b/antpay-ae6e5.appspot.com/o/OffersBanners%2Foffer_img5.png?alt=media&token=c1542307-6d1a-48d5-ad9e-354483547b21"
    // Add more image URLs as needed
  ];


  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
     _Api_state();
    });
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.white, // Replace with your desired background color
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 180.0,// Adjust the height as needed
                  // Add your content for the banner here
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CarouselSlider(
                        items: images.map((url) {
                          return Image.network(
                            url,
                            fit: BoxFit.fill,
                          );
                        }).toList(),
                        options: CarouselOptions(
                          autoPlay: true,
                          aspectRatio: 2.0,
                          enlargeCenterPage: true,
                          onPageChanged: (index, reason) {
                            setState(() {
                              _currentIndex = index;
                            });
                          },
                        ),
                      ),
                      SizedBox(height: 10),

                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: images.map((url) {
                      int index = images.indexOf(url);
                      return Container(
                        width: 8.0,
                        height: 8.0,
                        margin: EdgeInsets.symmetric(horizontal: 4.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _currentIndex == index
                              ? Colors.blueAccent
                              : Colors.grey,
                        ),
                      );
                    }).toList(),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    'Transaction History',
                    style: TextStyle(
                      fontFamily: 'rupee_ford',
                      color: Colors.black,
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                // Add your ListView here
                Container(
                  padding: EdgeInsets.all(16),
                  height: MediaQuery
                      .of(context)
                      .size
                      .height,
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.0),
                    // color: Colors.white,
                  ),

                  child: Column(
                    children: [
                      Expanded(
                        child: Visibility(
                          visible: true,
                          child: ListView.builder(
                            itemCount: transactionlist!.length,
                            itemBuilder: (context, index) {
                              String responseMessage = transactionlist![index].ResposneMessage ?? '';
                              return MobilePlanListTile(
                                Number: transactionlist![index].recharge_no.toString(),
                                orderid: transactionlist![index].transaction_no.toString(),
                                successes: transactionlist![index].ResposneMessage.toString(),
                                time: transactionlist![index].created_at.toString(),
                                amount: transactionlist![index].amount.toString(),
                                RazorPay: transactionlist![index].payment_method.toString(),
                                successColor: responseMessage.toUpperCase().contains('SUCCESS') || responseMessage.toUpperCase().contains('SUCCES') ? Colors.green : Colors.red,
                              );

                            },
                          ),
                        ),
                      ),
                        Center(
                          child: Image(
                            image: const AssetImage('assets/images/loader_image.gif'),
                            width: MediaQuery.of(context).size.width * 0.05,
                            height: MediaQuery.of(context).size.height * 0.05,
                            // controller: gifController,
                          ),
                        )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),

    );
  }

  Future<void>_Api_state() async {
    CommonApiRepo repoClass = CommonApiRepo();
    TransactionHistoryRequestModel request = TransactionHistoryRequestModel(
      mobile: '8006034041',
    );
    TransactionHistoryResponseModel response;
    response = await repoClass.apiClient.Transaction(
        SessionManager().getToken().toString(),
        AuthToken.getAuthToken(),
        request);
    if (response.status.toString() == "1") {
      //VerifyViewModel.setLoading(true);
      print('Response:${response.status}');}
    if (response.transaction_list != null) {
      List<TransactionHistorylist>? transactionList = response.transaction_list;
      for (TransactionHistorylist transaction in transactionList!)
      {
        transactionlist?.add(transaction);
        print('Transaction Title: ${transaction.transaction_no}');
        print('Description: ${transaction.amount}');
        print('Reference ID: ${transaction.payment_method}');
        print('Status: ${transaction.created_at}');
        print('Date: ${transaction.ResposneMessage}');
        print('Amount: ${transaction.amount}');
        print('Is Credit: ${transaction.recharge_no}');
        print(''); // Separating each transaction details for clarity
      }
    } else {
      print('Transaction list is null');
    }

    setState(() {

    });
  }

}







