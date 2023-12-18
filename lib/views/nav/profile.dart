import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../../preferences/session_ manager.dart';

import '../../preferences/utility_preferences.dart';
import '../../repository/common/common_api_repo.dart';
import '../../res/color_palette.dart';
import '../../utils/common_utils.dart';
import '../../utils/routes/routes_name.dart';
import '../../utils/widgets/list_view_tile.dart';
import '../../utils/widgets/reusables.dart';
import '../transaction/notification_history.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  bool showQR = false;
  bool fetchQR = true;
  bool activated = false;
  bool merchantStatus = false;
  String? qrData;
  String? id;
  String? name;

  GlobalKey globalKeyQR = new GlobalKey();
  GlobalKey globalKeyShareQR = new GlobalKey();

  //late SellerDetails? sellerDetails;

  @override
  void initState() {

   super.initState();
   //// _getSellerDetails();
   // _initQRData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPalette.baseBackgroundColor,
     /* appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Container(
          height: 30,
          width: 130,
          child: Image.asset('assets/images/antpaybizhub_logo.png'),
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
      ),*/
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [

              Card(
                color: ColorPalette.white,
                surfaceTintColor: ColorPalette.white,
                elevation: 2.0,
                margin: EdgeInsets.all(20.0),
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 30.0,
                        backgroundImage: AssetImage('assets/images/profile_image.png'), // Replace with your actual path or use AssetImage
                      ),
                      SizedBox(width: 16.0),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              SessionManager().getName().toString(),
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 8.0),
                            Text(
                             SessionManager().getMobile().toString(),
                              style: TextStyle(fontSize: 14.0),
                            ),
                            Text(
                              'Wallet Status: Active',
                              style: TextStyle(fontSize: 14.0),
                            ),

                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              SingleChildScrollView(
                child: Container(
                  margin:
                      EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 20),
                  // height: MediaQuery.of(context).size.height*0.45,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    color: Colors.white,
                  ),
                  child: Column(
                    children: [



                      ProfileListItemTile(
                        imagePath: 'assets/images/my_account.png',
                        text: 'My Account',
                        onTap: () {
                          print("account");
                          final Map sellerCredential =
                              SessionManager().getSellerCredential();
                          if (sellerCredential['seller_identifier'] != null &&
                              sellerCredential['seller_identifier']
                                  .toString()
                                  .isNotEmpty) {
                        /*    Navigator.pushNamed(
                                context, RoutesName.seller_edit);*/
                          } else {
                            CommonUtils.showToast("Seller not Activated!");
                          }
                        },
                      ),
                      Divider(height: 3, color: Colors.black12),

                      ProfileListItemTile(
                        imagePath: 'assets/images/my_account.png',
                        text: 'Profile',
                        onTap: () {
                          print("Go to Update Profile");
                          Map<String, dynamic> passScreenData = {
                            'fromScreen': 'profile',
                          };
                          Navigator.pushNamed(
                              context, RoutesName.update_profile,
                              arguments: passScreenData);
                        },
                      ),
                      Divider(height: 3, color: Colors.black12),

                      ProfileListItemTile(
                        imagePath: 'assets/images/settings_icon.png',
                        text: 'Setting',
                        onTap: () {
                          print("Settings");
                        },
                      ),
                      Divider(height: 3, color: Colors.black12),

                      ProfileListItemTile(
                        imagePath: 'assets/images/support.png',
                        text: 'Support -24x7 Help',
                        onTap: () {
                          print("Support");
                        },
                      ),
                      Divider(height: 3, color: Colors.black12),

                      ProfileListItemTile(
                        imagePath: 'assets/images/faq.png',
                        text: 'Frequently Asked Questions',
                        onTap: () {
                          print("FAQ");
                        },
                      ),
                      Divider(height: 3, color: Colors.black12),

                      ProfileListItemTile(
                        imagePath: 'assets/images/logout.png',
                        text: 'Logout',
                        onTap: () {
                          print("logout");
                          SessionManager().logOutUser();
                          UtilityPreferences().setString('isOnboarded', 'true');
                          Navigator.of(context, rootNavigator: true)
                              .pushReplacementNamed(RoutesName.login);
                          // to push to new screen without bottom bar
                          // PersistentNavBarNavigator.pushNewScreen(
                          //   context,
                          //   screen: LoginView(),
                          //   withNavBar: false, // OPTIONAL VALUE. True by default.
                          //   pageTransitionAnimation: PageTransitionAnimation.cupertino,
                          // );
                          CommonUtils.showToast(
                              'User Logged Out Successfully!');
                        },
                      ),
                      // Padding(
                      //   padding: const EdgeInsets.all(8.0),
                      //   child: InkWell(
                      //     onTap: (){
                      //       print("logout");
                      //       SessionManager().logOutUser();
                      //       UtilityPreferences().setString('isOnboarded', 'true');
                      //       Navigator.pushReplacementNamed(context, RoutesName.login);
                      //       CommonUtils.showToast('User Logged Out Successfully!');
                      //     },
                      //     child: Row(
                      //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //       children: [
                      //         Row(
                      //           crossAxisAlignment: CrossAxisAlignment.start,
                      //           children: [
                      //             Padding(
                      //               padding: const EdgeInsets.all(8.0),
                      //               child: Image(
                      //                 image: AssetImage('assets/images/faq.png'),
                      //                 width: 16,
                      //                 height: 16,
                      //               ),
                      //             ),
                      //             Padding(
                      //               padding: const EdgeInsets.only(left:8.0,top:4,right:8.0,bottom: 8.0),
                      //               child: Text(
                      //                 'Logout',
                      //                 maxLines: 1,
                      //                 textAlign: TextAlign.left,
                      //                 style: const TextStyle(
                      //                   fontSize: 14,
                      //                   fontWeight: FontWeight.normal,
                      //                   color: Colors.black,
                      //                 ),
                      //               ),
                      //             ),
                      //           ],
                      //         ),
                      //         Row(
                      //           crossAxisAlignment: CrossAxisAlignment.end,
                      //           children: [
                      //             Padding(
                      //               padding: const EdgeInsets.all(8.0),
                      //               child: Image(
                      //                 image: AssetImage('assets/images/right_arrow.png'),
                      //                 width: 14,
                      //                 height: 14,
                      //               ),
                      //             ),
                      //           ],
                      //         ),
                      //       ],
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

/*  void _getSellerDetails() async {
    CommonApiRepo repoClass = CommonApiRepo();

    late MerchantDetails details;
    MerchantDataModel data = await repoClass.fetchMerchantDetails(
        SessionManager().getToken().toString(),
        AuthToken.getAuthToken(),
        SessionManager().getMobile().toString());

    if (data.status.toString() == "1") {
      details = data.details!;
      sellerDetails = data.sellerDetails;

      if (sellerDetails != null) {
        print(sellerDetails.toString());
        if (sellerDetails!.qrStringStatus.toString() == '0') {
          setState(() {
            print('Seller under verification process');
            merchantStatus = false;
          });
        } else {
          print('Seller verification done');
          merchantStatus = true;
        }
      } else {
        CommonUtils.showToast("Seller not Activated!");
      }
    }
  }*/

 /* Future<void> _captureAndSharePng() async {
    if (!qrData!.isEmpty) {
      try {
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
    }
  }*/


 }
