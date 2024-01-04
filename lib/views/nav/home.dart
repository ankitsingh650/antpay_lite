import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:antpay_lite/model/wallet/FetchCardInfoRequestModel.dart';
import 'package:antpay_lite/model/wallet/FetchCardInfoResponseModel.dart';
import 'package:antpay_lite/model/wallet/GetBankDetailsResponseModel.dart';
import 'package:antpay_lite/model/wallet/WalletBalanceRequestModel.dart';
import 'package:antpay_lite/model/wallet/WalletBalanceResponseModel.dart';
import 'package:antpay_lite/views/payment/PaymentScreen.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../../data/retrofit/auth.dart';
import '../../model/homebanner/homebanner.dart';
import '../../model/homebanner/offers_model.dart';
import '../../model/wallet/GetBankDetailsRequestModel.dart';
import '../../preferences/session_ manager.dart';
import '../../repository/common/common_api_repo.dart';
import '../../res/color_palette.dart';
import '../../utils/common_utils.dart';
import '../../utils/method_utils.dart';
import '../../utils/routes/routes_name.dart';
import '../../utils/widgets/reusables.dart';

import '../transaction/notification_history.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool _isFrontVisible = true;

  final List<IconData> icons = [
    Icons.account_balance,
    Icons.wallet,
    Icons.monetization_on,
    Icons.real_estate_agent_outlined
  ];


  final List<String> imagePaths = [
    'assets/images/instant_pay_black.png',
    'assets/images/to_contact_black.png',
    'assets/images/to_wallet_black.png',
    'assets/images/request_money_d.png',
  ];



  final List<String> icon_name = [
    "Account\nTransfer",
    "Wallet\nTransfer",
    "  Add\nMoney",
    "Request\nMoney"
  ];
  bool showQR = false;
  bool fetchQR = true;
  bool activated = false;
  bool merchantStatus = false;
  String? qrData;
  String? id;
  String? name;
  String? count;
  late String offerID;

  final String urlFacebook = "https://www.facebook.com/antworksmoney";
  final String urlTwitter = "https://twitter.com/AntworksMoney";
  final String urlLinkedln =
      "https://www.linkedin.com/company/antworks-money/mycompany/";

  String balance = '',
      balanceDecimal = '00',
      accountNumber = '00000',
      cardNumber = '0000 0000 0000',
      ifscCode = 'ABCD000';

  TextEditingController controller = TextEditingController();

  GlobalKey globalKeyQR = new GlobalKey();
  GlobalKey globalKeyShareQR = new GlobalKey();

  // late SellerDetails? sellerDetails;

  // late List<Schemes>? responseSchemsList;
  // late KycStatus kycdata;

  var investmentViewModel;
  List<Bannerlist> bannerList=[];
  late List<Offer>? offersList=[];
  late List<Results>? offerResultList=[];
  bool offerViewStatus=false;

  void _onButtonPressedApplyLoan() {
    //  _checkLoans();
    // Navigator.pushNamed(context, RoutesName.business_loan);
  }

  void _onButtonPressedApplyInvevestment() {
    print("apply Investment");
    // Navigator.pushNamed(context, RoutesName.collection);
    //Text to Speech
    // TextToSpeech tts = TextToSpeech();
    // tts.speak("Hello, world!");
    // _getInvestmentSchemes();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // CommonUtils.showToast(EnvironmentConfig().envStatus.toString());
    // _initMerchantCount();
    //  _getSellerDetails();
    //// _initQRData();

    _initBalance();
    _fetchCardDetail();
    _fetchAccountDetail();
    _initOfferDetails();
    _initOffers();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(_controller);
  }


  void _toggleCard() {
    setState(() {
      _isFrontVisible = !_isFrontVisible;
    });

    if (_isFrontVisible) {
      _controller.reverse();
    } else {
      _controller.forward();
    }
  }


  @override
  Widget build(BuildContext context) {
    // investmentViewModel = Provider.of<InvestmentViewModel>(context);
    return Scaffold(
        backgroundColor: ColorPalette.baseBackgroundColor,
        body: SafeArea(
          child: Container(
            height: double.infinity,
            width: double.infinity,
            child: SingleChildScrollView(
              child: Column(children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    height: 140,
                    child: Card(
                      color: ColorPalette.blueBackgroundColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      elevation: 2.0,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: ListView.separated(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: imagePaths.length,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: InkWell(
                                        onTap: () {
                                          switch (index) {
                                            case 2:
                                              Navigator.of(context).push(MaterialPageRoute(builder: (context) => BillPaymentScreen(),
                                              ));
                                              break;
                                          }
                                        },
                                        child: Column(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.all(12.0),
                                              child: Image.asset(
                                                imagePaths[index],
                                                width: 30, // Set the width based on your requirements
                                                height: 30, // Set the height based on your requirements
                                              ),
                                            ),
                                            const SizedBox(height: 4.0),
                                            Text(
                                              icon_name[index],
                                              style: const TextStyle(
                                                fontSize: 11.0,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                  separatorBuilder: (BuildContext context, int index) {
                                    return SizedBox(width: 10);
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                    ),
                  ),
                ),

                Container(
                  padding: const EdgeInsets.all(8),
                  child: GestureDetector(
                    onTap: _toggleCard,
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 500),
                      switchInCurve: Curves.easeInOut,
                      switchOutCurve: Curves.easeInOut,
                      child: _isFrontVisible
                          ? FrontCard(
                          balance, accountNumber, ifscCode, cardNumber)
                          : BackCard(
                          balance, accountNumber, ifscCode, cardNumber),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 180,bottom: 10),
                  child: Text(
                    'Top recommendations',
                    style: TextStyle(
                      fontFamily: 'rupee_ford',
                      color: Colors.black,
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                // Add your ListView here
                CarouselSlider(
                  options: CarouselOptions(
                    enlargeCenterPage: true,
                    autoPlay: bannerList?.length == 1 ? false : true, // Set autoPlay based on the length of offersList
                    aspectRatio: 16 / 9,
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enableInfiniteScroll: bannerList?.length == 1 ? false : true,
                    autoPlayAnimationDuration: Duration(milliseconds: 800),
                    viewportFraction: 1, ),
                  items: bannerList ?.map((offer) {
                    return Builder(
                      builder: (BuildContext context) {
                        return InkWell(
                          onTap: (){
                            print('offer click id: ${offer.id}');
                            //Navigator.pushNamed(context, RoutesName.offer_view, arguments: offer);
                          },
                          child: Container(
                              margin: EdgeInsets.only(left: 16, right: 16, bottom: 16,),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(18)),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.all(Radius.circular(18)),
                                child: Image.network(
                                  offer.banner_img??'',
                                  fit: BoxFit.fill,
                                  loadingBuilder: (BuildContext context, Widget child,
                                      ImageChunkEvent? loadingProgress) {
                                    if (loadingProgress == null) return child;
                                    return Center(
                                      child: CircularProgressIndicator(
                                        color: ColorPalette.nextButtonColor,
                                        value: loadingProgress.expectedTotalBytes != null
                                            ? loadingProgress.cumulativeBytesLoaded /
                                            loadingProgress.expectedTotalBytes!
                                            : null,
                                      ),
                                    );
                                  },
                                  errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
                                    return Container(
                                        height: 140,
                                        width: MediaQuery.of(context).size.width,
                                        margin: EdgeInsets.only(left: 16, right: 16, bottom: 16,),
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(Radius.circular(18)),
                                            color: CommonUtils.toColor('#CCCCCC'),
                                            border: Border.all(
                                              color: Colors.blueGrey, // Set your desired border color
                                              width: 1, // Set the width of the border
                                            )
                                        ),
                                        child: Center(
                                          child: Text(
                                              textAlign:TextAlign.center,
                                              'Error loading image... Sorry for the inconvenience!',
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.normal,
                                                color: Colors.black,
                                              )
                                          ),
                                        )
                                    );

                                    //   Image.asset(
                                    //   'assets/images/surge_banner.png', // Replace with the path to your default image asset.
                                    //   height: 140,
                                    //   fit: BoxFit.cover, // Adjust the fit as needed.
                                    // );
                                  },
                                ),
                              )
                          ),
                        );
                      },
                    );
                  }).toList(),
                ),

                Padding(
                  padding: const EdgeInsets.only(right: 250,bottom: 10),
                  child: Text(
                    'Antpay Offer',
                    style: TextStyle(
                      fontFamily: 'rupee_ford',
                      color: Colors.black,
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                offersList!.isEmpty?Container():
                CarouselSlider(
                  options: CarouselOptions(
                    enlargeCenterPage: true,
                    autoPlay: offersList?.length == 1 ? false : true, // Set autoPlay based on the length of offersList
                    aspectRatio: 16 / 9,
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enableInfiniteScroll: offersList?.length == 1 ? false : true,
                    autoPlayAnimationDuration: Duration(milliseconds: 800),
                    viewportFraction: 1, ),
                  items: offersList?.map((offer) {
                    return Builder(
                      builder: (BuildContext context) {
                        return InkWell(
                          onTap: (){
                            print('offer click id Anpay: ${offer.id}');
                            Navigator.pushNamed(context, RoutesName.offer_view_name, arguments: offer);
                          },
                          child: Container(
                              margin: EdgeInsets.only(left: 16, right: 16, bottom: 16,),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(18)),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.all(Radius.circular(18)),
                                child: Image.network(
                                  offer.offerBannerImg??'',
                                  fit: BoxFit.cover,
                                  loadingBuilder: (BuildContext context, Widget child,
                                      ImageChunkEvent? loadingProgress) {
                                    if (loadingProgress == null) return child;
                                    return Center(
                                      child: CircularProgressIndicator(
                                        color: ColorPalette.nextButtonColor,
                                        value: loadingProgress.expectedTotalBytes != null
                                            ? loadingProgress.cumulativeBytesLoaded /
                                            loadingProgress.expectedTotalBytes!
                                            : null,
                                      ),
                                    );
                                  },
                                  errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
                                    return Container(
                                        height: 140,
                                        width: MediaQuery.of(context).size.width,
                                        margin: EdgeInsets.only(left: 16, right: 16, bottom: 16,),
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(Radius.circular(18)),
                                            color: CommonUtils.toColor('#CCCCCC'),
                                            border: Border.all(
                                              color: Colors.blueGrey, // Set your desired border color
                                              width: 1, // Set the width of the border
                                            )
                                        ),
                                        child: Center(
                                          child: Text(
                                              textAlign:TextAlign.center,
                                              'Error loading image... Sorry for the inconvenience!',
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.normal,
                                                color: Colors.black,
                                              )
                                          ),
                                        )
                                    );

                                    //   Image.asset(
                                    //   'assets/images/surge_banner.png', // Replace with the path to your default image asset.
                                    //   height: 140,
                                    //   fit: BoxFit.cover, // Adjust the fit as needed.
                                    // );
                                  },
                                ),
                              )
                          ),
                        );
                      },
                    );
                  }).toList(),
                ),
                Container(
                  margin: EdgeInsets.only(top: 16),
                  height: 130,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border(
                      top: BorderSide(
                        color: ColorPalette.bottomIconSelectedColor,
                        width: 2,
                      ),
                      bottom: BorderSide(
                        color: Colors.red,
                        width: 2,
                      ),
                    ),
                  ),
                  child: Column(children: [
                    Text(
                      'Follow Us on',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                        decorationThickness: 1.5,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: () => CommonMethodUtils()
                                .linkLanuchInBrowser(urlFacebook),
                            child: Image.asset(
                              'assets/images/facebook.png',
                              height: 40,
                              width: 40,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: () => CommonMethodUtils()
                                .linkLanuchInBrowser(urlTwitter),
                            child: Image.asset(
                              'assets/images/twitterx.png',
                              height: 40,
                              width: 40,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: () => CommonMethodUtils()
                                .linkLanuchInBrowser(urlLinkedln),
                            child: Image.asset(
                              'assets/images/linkedin.png',
                              height: 40,
                              width: 40,
                            ),
                          ),
                        ),
                      ],
                    ),

                    Text(
                      'ANTWORKS FINANCIAL BUDDY TECHNOLOGIES PVT.LTD.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        decorationThickness: 2,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),

                    Text(
                      'CIN: U67200HR2012PTC046705 |  Email ID: support@antworksmoney.com   Copyrights © Antworks Money 2017-2024.All Rights Reserved.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 9,
                          color: Colors.grey,
                          fontWeight: FontWeight.bold),
                    ),



                  ]),
                ),
              ]),


            ),
          ),
        ));
  }



  void _initBalance() async {
    CommonApiRepo repoClass = CommonApiRepo();
    WalletBalanceRequestModel request = WalletBalanceRequestModel(
        actionName: 'WALLETBAL',
        p1: SessionManager().getMobile().toString());

    WalletBalanceResponseModel response;

    response = await repoClass.apiClient.walletbal(
        SessionManager().getToken().toString(),
        AuthToken.getAuthToken(),
        request);

    if (response.statusCode.toString() == "SUCCESS") {
      print('Response:${response.balance}');
      setState(() {
        List amount = response.balance.toString().split(".");
        balance = amount[0];
        balanceDecimal = amount[1];
      });
    } else {
      //handle if not registered as seller
    }
  }

  void _fetchCardDetail() async {
    CommonApiRepo repoClass = CommonApiRepo();
    FetchCardInfoRequestModel request = FetchCardInfoRequestModel(
        p2: "E",
        actionName: 'GETCARD',
        p1: SessionManager().getMobile().toString());

    FetchCardInfoResponseModel response;

    response = await repoClass.apiClient.fetchCardInfo(
        SessionManager().getToken().toString(),
        AuthToken.getAuthToken(),
        request);

    if (response.statusCode.toString() == "SUCCESS") {
      print('Response:${response.message}');
      setState(() {
        cardNumber = response.cardNumber.toString();
      });
    } else {
      //handle if not registered as seller
    }
  }

  void _initOffers() async{
    CommonApiRepo repoClass = CommonApiRepo();
    OfferResponse response = await repoClass.apiClient.getOffers();
    if (response.status.toString() == "1") {
      offerResultList=response.results;
      if(offerResultList!.isEmpty){
        setState(() {
          offerViewStatus=false;

        });
      }
      else{
        setState(() {
          offerViewStatus=true;
          if(offersList!.isNotEmpty){
            offersList!.clear();
          }
          for (Results result in offerResultList!) {
            print(result.imgURL);
            List<Offer>? currentResultOfferList=result!.offer;
            for(Offer offer in currentResultOfferList!){
              Offer currOffer=Offer(
                id: offer.id,
                offerName: offer.offerName,
                offerType: offer.offerType,
                couponCodeType: offer.couponCodeType,
                offerIconImg: offer.offerIconImg,
                offerBannerImg: "${result.imgURL}${offer.offerBannerImg}",
                companyIconImg: offer.companyIconImg,
                offerUrl: offer.offerUrl,
                appId: offer.appId,
                playStoreURL: offer.playStoreURL,
                status: offer.status,
              );
              offersList?.add(currOffer);
            }
          }
          print("no of offers: ${offersList?.length}");
        });
      }
    }
  }

  void _initOfferDetails() async {
    CommonApiRepo repoClass = CommonApiRepo();
    HomebannerModel response;
    response = await repoClass.apiClient.Homebanner();
    if (response.status.toString() == "1") {
      print('Response:${response.banner_list}');
      setState(() {
        bannerList=response.banner_list!;
      });
    } else {

    }
  }

  void _fetchAccountDetail() async {
    CommonApiRepo repoClass = CommonApiRepo();
    GetBankDetailsRequestModel request = GetBankDetailsRequestModel(
        mobile: SessionManager().getMobile().toString());

    GetBankDetailsResponseModel response;

    response = await repoClass.apiClient.fetchAccountInfo(
        SessionManager().getToken().toString(),
        AuthToken.getAuthToken(),
        request);

    if (response.status.toString() == "1") {
      print('Response:${response.accountHolderName}');
      setState(() {
        accountNumber = response.accountNo.toString();
        ifscCode = response.ifscCode.toString();
        /* List amount = response.balance.toString().split(".");
        balance = amount[0];
        balanceDecimal = amount[1];*/
      });
    } else {
      //handle if not registered as seller
    }
  }



}

class FrontCard extends StatefulWidget {
  var balance;
  var accountNumber;
  var ifscCode;
  var cardNumber;

  FrontCard(
      this.balance,
      this.accountNumber,
      this.ifscCode,
      this.cardNumber,
      );

  @override
  State<FrontCard> createState() => _FrontCardState();
}

class _FrontCardState extends State<FrontCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      surfaceTintColor: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'A/c Balance',
                  style: TextStyle(
                    fontFamily: 'rupee_ford',
                    color: ColorPalette.colorPrimary,
                    fontSize: 9.0,
                  ),
                ),
                Text(
                  'Account Number',
                  style: TextStyle(
                    fontFamily: 'rupee_ford',
                    color: ColorPalette.colorPrimary,
                    fontSize: 9.0,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 5.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.balance.isEmpty ? "00" : '\u{20B9} ${widget.balance}',
                  style: TextStyle(
                    fontFamily: 'rupee_ford',
                    color: ColorPalette.colorPrimary,
                    fontSize: 12.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  widget.accountNumber,
                  style: TextStyle(
                    fontFamily: 'rupee_ford',
                    color: ColorPalette.colorPrimary,
                    fontSize: 12.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 8.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'IFSC',
                  style: TextStyle(
                    fontFamily: 'rupee_ford',
                    color: ColorPalette.colorPrimary,
                    fontSize: 9.0,
                  ),
                ),
                Text(
                  'Card Number',
                  style: TextStyle(
                    fontFamily: 'rupee_ford',
                    color: ColorPalette.colorPrimary,
                    fontSize: 9.0,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 5.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.ifscCode,
                  style: TextStyle(
                    fontFamily: 'rupee_ford',
                    color: ColorPalette.colorPrimary,
                    fontSize: 12.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  widget.cardNumber,
                  style: TextStyle(
                    fontFamily: 'rupee_ford',
                    color: ColorPalette.colorPrimary,
                    fontSize: 12.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 8.0,
            ),
            Container(
              height: 1.0,
              color: ColorPalette.colorPrimary,
            ),
            SizedBox(
              height: 8.0,
            ),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Set Transaction Limit',
                      style: TextStyle(
                        fontFamily: 'rupee_ford',
                        color: ColorPalette.colorPrimary,
                        fontSize: 12.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Transaction History',
                      style: TextStyle(
                        fontFamily: 'rupee_ford',
                        color: ColorPalette.colorPrimary,
                        fontSize: 12.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 8.0,
            ),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Card Activate/Deactivate',
                      style: TextStyle(
                        fontFamily: 'rupee_ford',
                        color: ColorPalette.colorPrimary,
                        fontSize: 12.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Set/Reset Pin',
                      style: TextStyle(
                        fontFamily: 'rupee_ford',
                        color: ColorPalette.colorPrimary,
                        fontSize: 12.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(
                  'assets/images/powered_by.png',
                  height: 60.0,
                  width: 120.0,
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    'View Virtual Card',
                    style: TextStyle(
                      fontFamily: 'rupee_ford',
                      color: ColorPalette.colorPrimary,
                      fontSize: 12.0,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              // children: [
              //   Padding(
              //     padding: const EdgeInsets.all(1.0),
              //     child: Image.network("",
              //       loadingBuilder: (BuildContext context, Widget child,
              //           ImageChunkEvent? loadingProgress) {
              //         if (loadingProgress == null) {
              //           return child;
              //         }
              //         else {
              //           return Center(
              //             child: Image(
              //               image: const AssetImage(
              //                   'assets/images/loader_image.gif'),
              //               width: MediaQuery
              //                   .of(context)
              //                   .size
              //                   .width * 0.15,
              //               height: MediaQuery
              //                   .of(context)
              //                   .size
              //                   .height * 0.10,
              //             ), // You can replace this with your loader GIF widget.
              //           );
              //         }
              //       },
              //     ),
              //   ),
              // ],

            ),
          ],
        ),

      ),

    );

  }
}

class BackCard extends StatefulWidget {
  var balance;
  var accountNumber;
  var ifscCode;
  var cardNumber;

  BackCard(
      this.balance,
      this.accountNumber,
      this.ifscCode,
      this.cardNumber,
      );

  @override
  State<BackCard> createState() => _BackCardState();
}

class _BackCardState extends State<BackCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.blueGrey,
      surfaceTintColor: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'A/c Balance',
                  style: TextStyle(
                    fontFamily: 'rupee_ford',
                    color: ColorPalette.colorPrimary,
                    fontSize: 9.0,
                  ),
                ),
                Text(
                  'Account Number',
                  style: TextStyle(
                    fontFamily: 'rupee_ford',
                    color: ColorPalette.colorPrimary,
                    fontSize: 9.0,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 5.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.balance.isEmpty ? "00" : '\u{20B9} ${widget.balance}',
                  style: TextStyle(
                    fontFamily: 'rupee_ford',
                    color: ColorPalette.colorPrimary,
                    fontSize: 12.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  widget.accountNumber,
                  style: TextStyle(
                    fontFamily: 'rupee_ford',
                    color: ColorPalette.colorPrimary,
                    fontSize: 12.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 8.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'IFSC',
                  style: TextStyle(
                    fontFamily: 'rupee_ford',
                    color: ColorPalette.colorPrimary,
                    fontSize: 9.0,
                  ),
                ),
                Text(
                  'Card Number',
                  style: TextStyle(
                    fontFamily: 'rupee_ford',
                    color: ColorPalette.colorPrimary,
                    fontSize: 9.0,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 5.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.ifscCode,
                  style: TextStyle(
                    fontFamily: 'rupee_ford',
                    color: ColorPalette.colorPrimary,
                    fontSize: 12.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  widget.cardNumber,
                  style: TextStyle(
                    fontFamily: 'rupee_ford',
                    color: ColorPalette.colorPrimary,
                    fontSize: 12.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 8.0,
            ),
            Container(
              height: 1.0,
              color: ColorPalette.colorPrimary,
            ),
            SizedBox(
              height: 8.0,
            ),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Set Transaction Limit',
                      style: TextStyle(
                        fontFamily: 'rupee_ford',
                        color: ColorPalette.colorPrimary,
                        fontSize: 12.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Transaction History',
                      style: TextStyle(
                        fontFamily: 'rupee_ford',
                        color: ColorPalette.colorPrimary,
                        fontSize: 12.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 8.0,
            ),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Card Activate/Deactivate',
                      style: TextStyle(
                        fontFamily: 'rupee_ford',
                        color: ColorPalette.colorPrimary,
                        fontSize: 12.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Set/Reset Pin',
                      style: TextStyle(
                        fontFamily: 'rupee_ford',
                        color: ColorPalette.colorPrimary,
                        fontSize: 12.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(
                  'assets/images/powered_by.png',
                  height: 60.0,
                  width: 120.0,
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    'View Virtual Card',
                    style: TextStyle(
                      fontFamily: 'rupee_ford',
                      color: ColorPalette.colorPrimary,
                      fontSize: 12.0,
                    ),
                  ),
                ),
              ],
            ),


          ],



        ),
      ),
    );



  }




}



