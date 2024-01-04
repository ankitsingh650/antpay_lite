import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import '../../ViewModel/offer/offer_view_model.dart';

import 'package:provider/provider.dart';

import '../../model/offer/offer_details_model.dart';
import '../../model/offer/offers_model.dart';
import '../../res/color_palette.dart';
import '../../utils/common_utils.dart';
import '../transaction/notification_history.dart';


class OfferView extends StatefulWidget {
  const OfferView({super.key});

  @override
  State<OfferView> createState() => _OfferViewState();
}

class _OfferViewState extends State<OfferView> {

  late var offerViewModel;
  String offerID='';

  String terms='';
  String couponCode='';
  String redirectionUrl='';

  bool loading=true;

  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      _initOfferDetails();
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
  // Your widget tree that includes OfferView
    offerViewModel=Provider.of<OfferViewModel>(context);
    final Offer? offerData;
    final  OfferDetails? offerDetails;
    if(ModalRoute.of(context)?.settings.arguments is Offer){
      offerData= ModalRoute.of(context)?.settings.arguments as Offer;
      offerDetails=null;
      print('from home features category click');
    }
    else{
      offerData=null;
      offerDetails= ModalRoute.of(context)?.settings.arguments as OfferDetails;
      print('from category click');

    }
    offerID=((offerData==null)?offerDetails?.id : offerData?.id)!;
    return Scaffold(
      backgroundColor: ColorPalette.baseBackgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Container(
          height: 30,
          width: 130,
          child: Image.asset('assets/images/antpay_logo.png'),
        ),
        backgroundColor: Colors.white,
        actions: <Widget>[
          Transform.scale(
            scale: 0.6,
            child: IconButton(
              icon: Image.asset('assets/images/notification_bell.png'),
              onPressed: () {
                // do something
                print('Bell Icon');
                // Navigator.pushNamed(context, RoutesName.notification_history);
                PersistentNavBarNavigator.pushNewScreen(
                  context,
                  screen: NotificationHistory(),
                  withNavBar: true, // OPTIONAL VALUE. True by default.
                  pageTransitionAnimation: PageTransitionAnimation.cupertino,
                );
              },
            ),
          )
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: loading?Column(
            children: [
              Center(
                child: Container(
                  child: Image(
                    image: const AssetImage('assets/images/loader_image.gif'),
                    width: MediaQuery.of(context).size.width*0.15,
                    height: MediaQuery.of(context).size.height*0.10,
                    // controller: gifController,
                  ),
                ),
              ),
            ],
          ):
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 160,
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.only(left: 16, right: 16, bottom: 16, top: 16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  child: Image.network(
                    offerDetails?.offerBannerImg??offerData?.offerBannerImg??'',
                    // offerData.offerBannerImg??'',
                    height: 160,
                    fit: BoxFit.cover,
                    loadingBuilder: (BuildContext context, Widget child,
                        ImageChunkEvent? loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Center(
                        child: CircularProgressIndicator(
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
                          margin: EdgeInsets.only(left: 16, right: 16, bottom: 16, top: 16),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(20)),
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
                    },
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 16, bottom: 16, left: 16, right: 26),
                child: Text(
                  offerData?.offerName??offerDetails?.offerName??'Loading...',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 16, bottom: 16, left: 16, right: 26),
                child: Text(
                  terms,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.normal
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: DottedBorder(
                      color: Colors.brown,
                      strokeWidth: 1,
                      radius: Radius.circular(20),
                      dashPattern: [5,2],
                      child: Container(
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                        ),
                        child: Text(
                          'COUPON CODE\n\n${couponCode}',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                            color: Colors.black
                          ),
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      await Clipboard.setData(ClipboardData(text: couponCode));
                      CommonUtils.showToast('coupon Code');
                    },
                    child: Container(
                      margin: EdgeInsets.all(16),
                      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                      decoration: BoxDecoration(
                        color: CommonUtils.toColor('#09466d'),
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      ),
                      child: Text(
                          'COPY',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                            color: Colors.white,
                          )
                      ),

                    ),
                  )
                ],
              ),
              Center(
                child: Container(
                  margin: EdgeInsets.only(bottom: 16),
                  child: ElevatedButton(
                    onPressed: () {
                      if(redirectionUrl.isNotEmpty){
                        CommonUtils.openPolicyView(
                            context, redirectionUrl);
                      }
                    },
                    child: Text(
                      "SHOP NOW",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.normal,
                          fontSize: 14),
                    ),
                    style: ButtonStyle(backgroundColor:
                    MaterialStateProperty.resolveWith(
                            (states) {
                          if (states
                              .contains(MaterialState.pressed)) {
                            return ColorPalette.dotPagerSelected;
                          }
                          return ColorPalette.dotPagerSelected;
                        })),
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }

  void _initOfferDetails() async{
    if(offerID==null || offerID.isEmpty){
      loading=false;
      CommonUtils.showToast('Something went wrong!');
    }else{
      OfferDetailsRequest id= OfferDetailsRequest(offerID: offerID);
      Details details = await offerViewModel.getOfferDetails(id);
      OfferDetails? offerDetails=details.offerDetails;
      if(offerDetails?.termCondition!=null){
        setState(() {
          terms=offerDetails!.termCondition.toString();
          couponCode=details.couponId.toString();
          redirectionUrl=offerDetails!.offerUrl.toString();
          loading=false;
          print("url$redirectionUrl");
        });
      }
    }
  }
}
