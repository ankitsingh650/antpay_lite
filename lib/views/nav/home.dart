import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:antpay_lite/model/wallet/FetchCardInfoRequestModel.dart';
import 'package:antpay_lite/model/wallet/FetchCardInfoResponseModel.dart';
import 'package:antpay_lite/model/wallet/GetBankDetailsResponseModel.dart';
import 'package:antpay_lite/model/wallet/WalletBalanceRequestModel.dart';
import 'package:antpay_lite/model/wallet/WalletBalanceResponseModel.dart';
import 'package:antpay_lite/views/payment/PaymentScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../../data/retrofit/auth.dart';
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

  // late SellerDetails? sellerDetails;

  // late List<Schemes>? responseSchemsList;
  // late KycStatus kycdata;

  var investmentViewModel;

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
                                itemCount: icons.length,
                                // Number of items
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: InkWell(
                                      onTap: () {
                                        switch (index) {
                                          case 2:

                                            Navigator.of(context).push(MaterialPageRoute(
                                              builder: (context) => BillPaymentScreen(),
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

                /*  Card(
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
                              balance.isEmpty ? "00" : '\u{20B9} ${balance}',
                              style: TextStyle(
                                fontFamily: 'rupee_ford',
                                color: ColorPalette.colorPrimary,
                                fontSize: 12.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              accountNumber,
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
                              ifscCode,
                              style: TextStyle(
                                fontFamily: 'rupee_ford',
                                color: ColorPalette.colorPrimary,
                                fontSize: 12.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              cardNumber,
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
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
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
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
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
                ),*/

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

                // ------>QR Card View End

                /*  Container(
                  margin: EdgeInsets.only(top: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border(
                      top: BorderSide(
                        color: ColorPalette.bottomIconSelectedColor,
                        width: 3,
                      ),
                      bottom: BorderSide(
                        color: Colors.red,
                        width: 3,
                      ),
                    ),
                  ),
                  child: Column(children: [
                    Text(
                      'Follow Us on',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                        decorationThickness: 2,
                        fontSize: 16,
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
                           */ /* onTap: () => CommonMethodUtils().linkLanuchInBrowser(urlFacebook),
                            child: Image.asset(
                              'assets/images/fb_icon.png',
                              height: 50,
                              width: 50,
                            ),*/ /*
                          ),
                        ),
                      */ /*  Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: () => CommonMethodUtils()
                                .linkLanuchInBrowser(urlTwitter),
                            child: Image.asset(
                              'assets/images/twitter_icon.png',
                              height: 50,
                              width: 50,
                            ),
                          ),
                        ),*/ /*
                      */ /*  Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: () => CommonMethodUtils()
                                .linkLanuchInBrowser(urlLinkedln),
                            child: Image.asset(
                              'assets/images/linkedin_icon.png',
                              height: 50,
                              width: 50,
                            ),
                          ),
                        ),*/ /*
                      ],
                    ),
                    Text(
                      'CIN: U67200HR2012PTC046705 |  Email ID: support@antworksmoney.com |  Copyrights © Antworks Money 2017-2021.All Rights Reserved.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 10,
                          color: Colors.grey,
                          fontWeight: FontWeight.bold),
                    ),
                  ]),
                ),*/
              ]),
            ),
          ),
        ));
  }

  void _getSellerDetails() async {
    CommonApiRepo repoClass = CommonApiRepo();

    /*  late MerchantDetails details;
    MerchantDataModel data = await repoClass.fetchMerchantDetails(SessionManager().getToken().toString(), AuthToken.getAuthToken(), SessionManager().getMobile().toString());

    if (data.status.toString() == "1") {
      details = data.details!;
      sellerDetails = data.sellerDetails;

      if (sellerDetails != null) {
        print(sellerDetails.toString());
        if(sellerDetails!.qrStringStatus.toString()=='0'){
          setState(() {
            print('Seller under verification process');
            merchantStatus=false;
          });
        }
        else{
          print('Seller verification done');
          merchantStatus=true;
        }
      } else {
        CommonUtils.showToast("Seller not Activated!");
      }
    }*/
  }

  Future<void> _captureAndSharePng() async {
    if (!qrData!.isEmpty) {
      /*   try {
        RenderRepaintBoundary boundary = globalKeyQR.currentContext!
            .findRenderObject() as RenderRepaintBoundary;

        // capturing the QR image
        var image = await boundary.toImage();
        ByteData? byteData =
            await image.toByteData(format: ImageByteFormat.png);
        Uint8List pngBytes = byteData!.buffer.asUint8List();

        //app directory for storing images.
        // final appDir = await getApplicationDocumentsDirectory();
        final tempDir = await getTemporaryDirectory();
        final file = await new File('${tempDir.path}/qr_image.png').create();
        //appending data as bytes
        await file.writeAsBytes(pngBytes);

        // final channel = const MethodChannel('channel:me.alfian.share/share');
        // channel.invokeMethod('shareFile', 'image.png');

        //Sharing QR
        await Share.shareFiles(
          [file!.path],
          mimeTypes: ["image/png"],
          text: "Share the QR Code",
        );
      } catch (e) {
        print(e.toString());
      }
    } else {
      CommonUtils.showToast("Invalid QR!");
    }*/
    }

    void _initQRData() async {
      CommonApiRepo repoClass = CommonApiRepo();
      /* FetchQrRequestModel request =
        FetchQrRequestModel(mobile: SessionManager().getMobile().toString());

    FetchQrResponseModel response;
    if(EnvironmentConfig().envStatus.toString()=='PROD'){
      print('Fetch QR call production');
      response =
      await repoClass.fetchQR(SessionManager().getToken().toString(), AuthToken.getAuthToken(),  request);
    }
    else {
      print('Fetch QR call dev');
      response =
      await repoClass.fetchQR_UAT(AuthToken.getAuthToken(), request);
    }

    if (response.status.toString() == "SUCCESS") {
      switch (response.responseCode) {
        case "P001":
          CommonUtils.showFlushBar(
              response.responseMessage.toString(), context);
          break;
        case "P002":
          CommonUtils.showFlushBar(
              response.responseMessage.toString(), context);
          break;
        case "P005":
          CommonUtils.showFlushBar(
              response.responseMessage.toString(), context);
          break;
        case "P006":
          CommonUtils.showFlushBar(
              response.responseMessage.toString(), context);
          break;
        case "PS004":
          CommonUtils.showFlushBar(
              response.responseMessage.toString(), context);
          break;
        case "PS026":
          CommonUtils.showFlushBar(
              response.responseMessage.toString(), context);
          break;
        case "PS030":
          CommonUtils.showFlushBar(
              response.responseMessage.toString(), context);
          break;
        case "00":
          setState(() {
            qrData = response.qrString.toString();
            id=response.vpa.toString();
            name=response.qrString.toString().split('pn=')[1];
            activated = true;
          });
          break;
        default:
          CommonUtils.showFlushBar("Network Error!", context);
      }
    } else {
      CommonUtils.showToast(response.responseMessage.toString());
      qrData = "";
    }*/
    }

    void _initBalance() async {
      CommonApiRepo repoClass = CommonApiRepo();
      /* FetchSellerBalanceRequestModel request = FetchSellerBalanceRequestModel(
        mobile: SessionManager().getMobile().toString());

    FetchSellerBalanceResponseModel response;

    if(EnvironmentConfig().envStatus.toString()=='PROD'){
      print('Fetch Balance call production');
      response =
      await repoClass.fetchBalance(SessionManager().getToken().toString(), AuthToken.getAuthToken(), request);
    }
    else {
      print('Fetch Balance call dev');
      response =
      await repoClass.fetchBalance_UAT(AuthToken.getAuthToken(), request);
    }


    if (response.status.toString() == "SUCCESS") {
      switch (response.responseCode) {
        case "P001":
          CommonUtils.showFlushBar(
              response.responseMessage.toString(), context);
          break;
        case "P002":
          CommonUtils.showFlushBar(
              response.responseMessage.toString(), context);
          break;
        case "P005":
          CommonUtils.showFlushBar(
              response.responseMessage.toString(), context);
          break;
        case "P006":
          CommonUtils.showFlushBar(
              response.responseMessage.toString(), context);
          break;
        case "PS004":
          CommonUtils.showFlushBar(
              response.responseMessage.toString(), context);
          break;
        case "PS026":
          CommonUtils.showFlushBar(
              response.responseMessage.toString(), context);
          break;
        case "PS031":
          CommonUtils.showFlushBar(
              response.responseMessage.toString(), context);
          break;
        case "00":
          print(
              'Response:${response.currentBalance}\n${response.withdrawableBalance}\n${response.monthlyLimitUtilized}');
          setState(() {
            List amount = response.currentBalance.toString().split(".");
            balance = amount[0];
            balanceDecimal = amount[1];
          });
          break;
        default:
          CommonUtils.showFlushBar("Server Error!", context);
      }
    } else {
      //handle if not registered as seller
    }*/
    }

    void _checkLoans() async {
      print(SessionManager().getMobile().toString());
      /*  LoanHistoryRequestModel requestModel= LoanHistoryRequestModel(
        mobile: SessionManager().getMobile().toString(),
        source: 'Bizhub'
    );

    CommonApiRepo repoClass = CommonApiRepo();
    LoanHistoryResponseModel response = await repoClass.fetchLoanHistory(SessionManager().getToken().toString(), AuthToken.getAuthToken(), requestModel);

    if(response.status.toString()=="1"){
      Navigator.pushNamed(context, RoutesName.business_loan_history);
    }
    else{
      Navigator.pushNamed(context, RoutesName.business_loan);
    }*/
    }

/*  Future openShareQRDialog(bool isShare) => showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)), //this right here
            child: MerchantQR(globalKeyShareQR, qrData??'Unknown', id??'Loading...', name??'Loading...', isShare, false, '')
        );
      });*/

    void _initMerchantCount() async {
      CommonApiRepo repoClass = CommonApiRepo();
      /* MerchantCount response = await repoClass.fetchMerchantCount(SessionManager().getToken().toString(), AuthToken.getAuthToken());
    if(response.status.toString()=="1"){
      setState(() {
        count=response.merchantCount.toString();
      });
    }*/
    }

    Future<void> _getInvestmentSchemes() async {
      //   investmentViewModel.setLoading(true);
/*    SchemesInvestmentResponseModel schemesInvestmentResponseModel =
    await investmentViewModel.getInvestmentSchemes();
    responseSchemsList = schemesInvestmentResponseModel.schemesList;
    //  this flow executes on the scheme api response kycStatus step according


    kycdata = schemesInvestmentResponseModel.kyc_status!;
    setState(() {
      if (kycdata.step.toString() == '3') {
            Navigator.pushNamed(context, RoutesName.investment_dashboard);
          }
          else {
            Navigator.pushNamed(context, RoutesName.investment_plan);
          }
    });*/
    }
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
