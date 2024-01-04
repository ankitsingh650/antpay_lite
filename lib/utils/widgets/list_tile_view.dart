import 'package:flutter/material.dart';

import '../../res/color_palette.dart';

class BillersInputField extends StatefulWidget {
  final String headlineName;
  final TextEditingController controller;
  final Function(String) onTextChange;

  const BillersInputField(
      {required this.headlineName,
      required this.onTextChange,
      required this.controller});

  @override
  _BillersInputField createState() => _BillersInputField();
}

class _BillersInputField extends State<BillersInputField> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  widget.headlineName,
                  style: TextStyle(
                      fontWeight: FontWeight.normal,
                      color: ColorPalette.blueBackgroundColor,
                      fontSize: 14),
                ),
              ),
            ],
          ),
          Container(
            height: 45,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white),
              borderRadius: BorderRadius.circular(8),
            ),
            child: TextFormField(
              controller: widget.controller,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                  borderRadius: BorderRadius.circular(12),
                  gapPadding: 0.5,
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                  borderRadius: BorderRadius.circular(12),
                  gapPadding: 0.5,
                ),
                contentPadding: EdgeInsets.symmetric(horizontal: 15),
                hintStyle: TextStyle(
                  fontSize: 14,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// mobile offer list tile
class MobileOfferListTile extends StatefulWidget {
  final String bannerCategory;
  final String bannerName;
  final String bannerImagePath;
  final VoidCallback? onTap;

  const MobileOfferListTile(
      {required this.bannerCategory,
      required this.bannerName,
      required this.bannerImagePath,
      required this.onTap});

  @override
  State<MobileOfferListTile> createState() => _MobileOfferListTileState();
}

class _MobileOfferListTileState extends State<MobileOfferListTile> {
  @override
  Widget build(BuildContext context) {
    return Card(
      // elevation: 2.0,
      margin: EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          widget.onTap!();
        },
        child: Container(
          padding: EdgeInsets.all(8.0),
          // height: MediaQuery.of(context).size.height * 0.30,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.0),
            color: Colors.white,
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 16.0, left: 8.0, bottom: 8.0),
                    child: Text(
                      widget.bannerCategory,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      widget.bannerName,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 14.0,
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image(
                  image: AssetImage(widget.bannerImagePath),
                  width: MediaQuery.of(context).size.width,
                  height: 140,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// reward coupon ListTile
class RewardCouponListTile extends StatefulWidget {
  final String couponOffer;
  final String couponCode;
  final VoidCallback? onTap;

  const RewardCouponListTile(
      {required this.couponOffer,
      required this.couponCode,
      required this.onTap});

  @override
  State<RewardCouponListTile> createState() => _RewardCouponListTileState();
}

class _RewardCouponListTileState extends State<RewardCouponListTile> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2.0,
      margin: EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          widget.onTap!();
        },
        child: Container(
          // padding: EdgeInsets.all(8.0),
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.0),
            color: Colors.white,
          ),
          child: Column(
            children: [
              Text(
                widget.couponOffer,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 16.0,
                ),
              ),
              SizedBox(
                height: 8,
              ),
              GestureDetector(
                onTap: (){
                  print("Coupon Code: ${widget.couponCode}");
                },
                child: Container(
                  height:40 ,
                  width: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14.0),
                    color: ColorPalette.blueBackgroundColor,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                        child: Text(
                          widget.couponCode,
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ),
                      SizedBox(width: 4.0,),
                      Icon(
                        Icons.copy,
                        size: 20,
                        color: Colors.black,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 8,
              ),
            ],
          ),
        ),
      ),
    );
  }
}


// reward history ListTile
class RewardHistoryListTile extends StatefulWidget {
  final String historyDate;
  final String coinsValue;
  final String rewardEarned;
  // final VoidCallback? onTap;

  const RewardHistoryListTile(
      {required this.historyDate,
        required this.coinsValue,
        required this.rewardEarned
        // required this.onTap
        });

  @override
  State<RewardHistoryListTile> createState() => _RewardHistoryListTileState();
}

class _RewardHistoryListTileState extends State<RewardHistoryListTile> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2.0,
      margin: EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          // widget.onTap!();
        },
        child: Container(
          // padding: EdgeInsets.all(8.0),
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            // borderRadius: BorderRadius.circular(12.0),
            color: Colors.white,
          ),
          child: Column(
            children: [
            Container(
            height: 40,
            decoration: BoxDecoration(
              // image: DecorationImage(
              //   image: AssetImage("assets/cd.png"), // Set your drawable resource
              //   fit: BoxFit.fill,
              // ),
              border: Border.all(width: 2,color: ColorPalette.blueBackgroundColor),

            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 30,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 6),
                    child: Center(
                      child: Text(
                        widget.historyDate,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.black,

                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 2,
                  height: double.infinity,
                  color: ColorPalette.blueBackgroundColor,
                ),
                Expanded(
                  flex: 20,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 6),
                    child: Center(
                      child: Text(
                        widget.coinsValue,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 1,
                  height: double.infinity,
                  color: ColorPalette.blueBackgroundColor,
                ),
                Expanded(
                  flex: 50,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 6),
                    child: Center(
                      child: Text(
                        widget.rewardEarned,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
            ],
          ),
        ),
      ),
    );
  }
}


class OfferCashbackListTile extends StatefulWidget {
  final String ImagePath;
  final VoidCallback? onTap;

  const OfferCashbackListTile(
      {
        required this.ImagePath,
        required this.onTap});

  @override
  State<OfferCashbackListTile> createState() => _OfferCashbackListTileState();
}

class _OfferCashbackListTileState extends State<OfferCashbackListTile> {
  @override
  Widget build(BuildContext context) {
    return Card(
      // elevation: 2.0,
      margin: EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          widget.onTap!();
        },
        child: Container(
          padding: EdgeInsets.all(8.0),
          // height: MediaQuery.of(context).size.height * 0.30,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.0),
            color: Colors.white,
          ),
          child: Container(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Image.network(widget.ImagePath,
              width: 120.0,
              height: 70.0,
              fit:BoxFit.fill,
              ),
            ),
          )

        ),
      ),
    );
  }
}


// reward history ListTile
class MobilePlanListTile extends StatefulWidget {
  final String Number;
  final String orderid;
  final String successes;
  final String time;
  final String amount;
  final String RazorPay;
  final Color successColor;
  // final VoidCallback? onTap;

  const MobilePlanListTile(
      {
        required this.Number,
        required this.orderid,
        required this.successes,
        required this.time,
        required this.amount,
        required this.RazorPay,
        required this.successColor,
        // required this.onTap
      });

  @override
  State<MobilePlanListTile> createState() => _MobilePlanListTileState();
}

class _MobilePlanListTileState extends State<MobilePlanListTile> {
  @override
  Widget build(BuildContext context) {


    return Card(
      elevation: 2.0,
      margin: EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          // widget.onTap!();
        },
        child: Container(
          // padding: EdgeInsets.all(8.0),
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.0),
            color: Colors.white,
          ),

          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 1.0,),
                child: Align(
                  alignment: Alignment.topLeft,
                 /* child: Text('',
                    textAlign: TextAlign.start,
                    style: TextStyle(color: widget.successColor),
                  ),*/
                ),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 1.0,),
                    child: Text('Mo:${widget.Number}',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 10.0, top: 0),
                    child: Text(
                      '${widget.successes}',
                      textAlign: TextAlign.start,
                        style: TextStyle(color: widget.successColor,
                            fontWeight: FontWeight.bold)

                    ),
                  ),
                ],
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 1.0),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text('${widget.RazorPay}',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          color: Colors.black,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 1.0),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text('${widget.time}',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          color: Colors.black,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),

                ],
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 10.0,),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text('Ref.ID:${widget.orderid}',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          color: Colors.black,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 10.0),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text('₹ ${widget.amount}',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          color: Colors.black,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),

                ],
              ),
            ],
          ),
        ),
      ),
    );

  }
}
