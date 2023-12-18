import 'dart:async';


import 'package:antpay_lite/views/onboard/onboarding_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../preferences/session_ manager.dart';
import '../../preferences/utility_preferences.dart';
import '../../utils/routes/routes_name.dart';



class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {

  final UtilityPreferences _utilityPreferences = UtilityPreferences();
 bool onboarding=false;

  @override
  void initState() {

    super.initState();
    isOnboarded();
   // checkOnBoardingStatus();

    Timer(const Duration(seconds: 4), () async {
       /*  Navigator.pushReplacement(
           context,
           MaterialPageRoute(
           builder: (context) => const Onboarding(),
         ));*/

      if(SessionManager().userLoggedIn()){
        // handle verifytoken() api call->true flow
        print('splash login');
        Navigator.pushReplacementNamed(context, RoutesName.dummy_dash);
        //else-> login flow
      }
      else{
        if(onboarding){
          print('splash login with onb');
          _utilityPreferences.setString('isOnboarded', 'true');
          // Navigator.pushNamed(context, RoutesName.onboarding);
          Navigator.pushReplacementNamed(context, RoutesName.onboarding);
        }
        else{
          // Navigator.pushNamed(context, RoutesName.login);
          print('splash login without onb');

          Navigator.pushReplacementNamed(context, RoutesName.login);
        }
      }

        });
  }


  @override
  void dispose(){
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
      overlays: SystemUiOverlay.values
    );
    super.dispose();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.all(16),
              color: Colors.white,
              child: Center(
                  child: Image.asset(
                    'assets/images/antpay_logo.png',
                    height: 120,
                    width:200,
                    // fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          Container(
            color: Colors.white,
            padding: EdgeInsets.all(16),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Image.asset('assets/images/footer_logo.png',
                height: 40,
                fit: BoxFit.cover,
              ),
            ),
          )
        ],
      ),
    );
  }

  void isOnboarded() {

    final isOnboarded =_utilityPreferences.getString('isOnboarded', 'false');


    if(isOnboarded=='false'){
      setState(() {

        onboarding=true;
      });
    }
    else{
      setState(() {
        onboarding=false;
      });

    }

    print('showOnboradingScreen ${isOnboarded}');
  }


}
