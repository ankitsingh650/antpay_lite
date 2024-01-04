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
import '../../model/offer/homebanner.dart';
import '../../model/offer/offers_model.dart';
import '../../model/wallet/GetBankDetailsRequestModel.dart';
import '../../preferences/session_ manager.dart';
import '../../repository/common/common_api_repo.dart';
import '../../res/color_palette.dart';
import '../../utils/common_utils.dart';
import '../../utils/method_utils.dart';
import '../../utils/routes/routes_name.dart';
import '../../utils/widgets/reusables.dart';

import '../transaction/notification_history.dart';
import '../wallet/MinVerifyMobile.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool _isFrontVisible = true;


  List<Bannerlist> bannerList=[];
  late List<Offer>? offersList=[];
  late List<Results>? offerResultList=[];
  bool offerViewStatus=false;

  final List<IconData> icons = [
    Icons.account_balance,
    Icons.wallet,
    Icons.monetization_on,
    Icons.real_estate_agent_outlined
  ];
  final List<String> icon_name = [
    "Account\nTransfer",
    "Wallet\nTransfer",
    "Add\nMoney",
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

  int _currentStep = 0;
  PageController _pageController = PageController();

  var investmentViewModel;

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
    _initOffers();
    _initOfferDetails();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(_controller);
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
            color: ColorPalette.white,
            height: double.infinity,
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
                                itemCount: icons.length,
                                // Number of items
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: InkWell(
                                      onTap: () {
                                        switch (index) {
                                          case 2:
                                            Navigator.of(context)
                                                .push(MaterialPageRoute(
                                              builder: (context) =>
                                                  BillPaymentScreen(),
                                            ));
                                          // Navigator.pushReplacementNamed(context, RoutesName.paymentFrom);
                                          /* PersistentNavBarNavigator
                                                .pushNewScreen(
                                              context,
                                              screen: BillPaymentScreen(),
                                              withNavBar: false,
                                              // OPTIONAL VALUE. True by default.
                                              pageTransitionAnimation:
                                                  PageTransitionAnimation
                                                      .cupertino,
                                            );*/
                                        }
                                      },
                                      child: Column(
                                        children: [
                                          CircleAvatar(
                                            backgroundColor: Colors.blue,
                                            radius: 30,
                                            child: Icon(
                                              icons[index],
                                              color: Colors.white,
                                            ),
                                          ),
                                          const SizedBox(height: 4.0),
                                          Text(
                                            icon_name[index],
                                            style: const TextStyle(
                                              fontSize: 11.0,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                                separatorBuilder:
                                    (BuildContext context, int index) {
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
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    height: 80, // Adjust the height as needed
                    child: Stepper(
                      physics: PageScrollPhysics(),
                      onStepTapped: (value) {},
                      type: StepperType.horizontal,
                      currentStep: _currentStep,
                      onStepContinue: () {
                        if (_currentStep < 4) {
                          _pageController.nextPage(
                            duration: Duration(milliseconds: 500),
                            curve: Curves.ease,
                          );
                        }
                      },
                      onStepCancel: () {
                        if (_currentStep > 0) {
                          _pageController.previousPage(
                            duration: Duration(milliseconds: 500),
                            curve: Curves.ease,
                          );
                        }
                      },
                      steps: [


                        Step(
                          state: StepState.complete,

                          title: Text('Step 1'),
                          content: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Account Setup'),
                              // Add more widgets as needed
                            ],
                          ),
                          isActive: _currentStep == 0,
                        ),
                        Step(
                          title: Text('Step 2'),
                          content: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Account Setup'),
                              // Add more widgets as needed
                            ],
                          ),
                          isActive: _currentStep == 1,
                        ),
                        Step(
                          title: Text('Step 3'),
                          content: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Account Setup'),
                              // Add more widgets as needed
                            ],
                          ),
                          isActive: _currentStep == 2,
                        ),
                        Step(
                          title: Text('Step 4'),
                          content: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Account Setup'),
                              // Add more widgets as needed
                            ],
                          ),
                          isActive: _currentStep == 3,
                        ),
                        Step(
                          title: Text('Step 5'),
                          content: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Account Setup'),
                              // Add more widgets as needed
                            ],
                          ),
                          isActive: _currentStep == 4,
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  height: 200,
                  child: PageView(
                    controller: _pageController,
                    onPageChanged: (index) {
                      setState(() {
                        _currentStep = index;
                      });
                    },
                    children: [
                      Container(
                        child: StepCard(
                          title: 'Step 1: Account Setup',
                          content: 'Set up your account for wallet activation.',
                        ),
                      ),
                      StepCard(
                        title: 'Step 2: KYC Verification',
                        content: 'Complete KYC verification for security.',
                      ),
                      StepCard(
                        title: 'Step 3: Activation Complete',
                        content:
                        'Congratulations! Your wallet is now activated.',
                      ),
                      StepCard(
                        title: 'Step 4: Activation Complete',
                        content:
                        'Congratulations! Your wallet is now activated.',
                      ),
                      StepCard(
                        title: 'Step 5: Activation Complete',
                        content:
                        'Congratulations! Your wallet is now activated.',
                      ),
                    ],
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

                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20,bottom: 10),
                    child: Text(

                      'Top Recommendations',
                      style: TextStyle(
                        fontFamily: 'rupee_ford',
                        color: Colors.black,
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
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
                        );;
                      },
                    );
                  }).toList(),
                ),

                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20,bottom: 10),
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
                        );;
                      },
                    );
                  }).toList(),
                ),

              ]),
            ),
          ),
        ));
  }

  void _initBalance() async {
    CommonApiRepo repoClass = CommonApiRepo();
    WalletBalanceRequestModel request = WalletBalanceRequestModel(
        actionName: 'WALLETBAL', p1: SessionManager().getMobile().toString());

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

        /*   List amount = response.balance.toString().split(".");
        balance = amount[0];
        balanceDecimal = amount[1];*/
      });
    } else {
      //handle if not registered as seller
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
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
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
      elevation: 2.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      color: Colors.transparent,
      // surfaceTintColor: Colors.white,
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              // Same radius as the shape above
              image: DecorationImage(
                image: AssetImage('assets/images/real_card_bg.png'),
                // Replace with your image path
                fit: BoxFit.fill,
              ),
            ),
            padding: EdgeInsets.only(left: 20.0, right: 6, top: 6,bottom: 6),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Antworks Logo
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: EdgeInsets.all(10.0),
                      child: Image.asset(
                        'assets/images/antlogo_newpprepaidcard.png',
                        width: 80.0,
                        height: 30.0,
                        fit: BoxFit.contain,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(10.0),
                      child: Image.asset(
                        'assets/images/yesbank_logo_new.png',
                        width: 80.0,
                        height: 30.0,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ],
                ),

                // Yes Bank Logo

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: 4.0),
                      child: Image.asset(
                        'assets/images/icon_sim.png',
                        width: 44.0,
                        height: 40.0,
                        fit: BoxFit.contain,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 6.0, right: 10.0),
                      child: Text(
                        'AntPay Freedom Card',
                        style: TextStyle(
                          fontFamily: 'rupee_ford',
                          color: Colors.white,
                          fontSize: 12.0,
                        ),
                      ),
                    ),
                  ],
                ),

                Container(
                  margin: EdgeInsets.only(top: 4.0, bottom: 4.0),
                  child: Text(
                    '0000  0000  0000  0000',
                    style: TextStyle(
                      fontFamily: 'creditcard',
                      color: Colors.white,
                      fontSize: 20.0,
                      letterSpacing: 0.06,
                    ),
                  ),
                ),

                Container(
                  margin: EdgeInsets.only(top: 4.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'MONTH/YEAR',
                        style: TextStyle(
                          fontFamily: 'rupee_ford',
                          color: Colors.white,
                          fontSize: 8.0,
                        ),
                      ),
                    ],
                  ),
                ),
                // RuPay Card Logo

                // Valid Though Layout
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    margin: EdgeInsets.only(top: 4.0),
                    child:  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      //  crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'VALID\n THRU',
                          style: TextStyle(
                            fontFamily: 'rupee_ford',
                            color: Colors.white,
                            fontSize: 8.0,
                          ),
                        ),

                        SizedBox(
                          width: 10,
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 4.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '00/00',
                                style: TextStyle(
                                  fontFamily: 'creditcard',
                                  color: Colors.white,
                                  fontSize: 18.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // Validity Date Layout





                // Card Holder Details Layout
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 6.0, bottom: 2.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'CARD HOLDER NAME',
                            style: TextStyle(
                              fontFamily: 'rupee_ford',
                              color: Colors.white,
                              fontSize: 12.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                        ],
                      ),
                    ),
                    Container(
                      child: Column(
                        children: [

                          Container(
                            margin: EdgeInsets.all(10.0),
                            child: Image.asset(
                              'assets/images/rupaylogo_card.png',
                              width: 80.0,
                              height: 30.0,
                              fit: BoxFit.contain,
                            ),
                          ),


                        ],
                      ),
                    ),



                  ],
                ),


                Container(
                  child:  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [

                      Text(
                        'CVV  567',
                        style: TextStyle(
                          fontFamily: 'rupee_ford',
                          color: Colors.white,
                          fontSize: 10.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      Text(
                        'Hide Your Card',
                        style: TextStyle(
                          fontFamily: 'rupee_ford',
                          color: Colors.white,
                          fontSize: 10.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(10.0),
                        child: Text(
                          'Prepaid',
                          style: TextStyle(
                            fontFamily: 'rupee_ford',
                            color: Colors.white,
                            fontSize: 10.0,
                          ),
                        ),
                      ),

                    ],
                  ),
                )

                // Text to Hide Your Card

                // Prepaid Card Heading


                // Month/Year Layout

                // Card Number

                // SIM Image

                // AntPay Card Type
              ],
            ),
          ),
         Positioned(
            bottom: 8,
            left: 8,


           child:  Container(
           margin: EdgeInsets.only(bottom: 8.0),
           child:   RotatedBox(quarterTurns: -1, child: Text(  style: TextStyle(
             fontFamily: 'rupee_ford',
             color: Colors.white,
             fontSize: 8.0,
           ),'For Use Only in India')),


           /*  Text(
                'For Use Only in India',
                style: TextStyle(
                  fontFamily: 'rupee_ford',
                  color: Colors.white,
                  fontSize: 8.0,
                    transform: Matrix4.rotationZ(-91 * (3.14159265359 / 180)),
                ),
              ),*/
         ),)
        ],
      )
    );
  }
}

class StepCard extends StatelessWidget {
  final String title;
  final String content;

  const StepCard({
    required this.title,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: ColorPalette.lightbluebg,
      surfaceTintColor: ColorPalette.lightbluebg,
      margin: EdgeInsets.all(16),
      elevation: 4,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12),
            Text(content),
            SizedBox(height: 16),
            // Add some spacing between the content and the button
            SizedBox(
              width: 120,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  textStyle: TextStyle(color: Colors.white),
                  primary: Colors.red, // Set the background color to red
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MinVerifyMobile()));
                  // Add your action when the "Open Now" button is pressed
                },
                child:
                    Text("Proceed Now", style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }





}


