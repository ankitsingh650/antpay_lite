import 'package:antpay_lite/views/dashboard/dashboard_view.dart';
import 'package:antpay_lite/views/payment/PaymentScreen.dart';
import 'package:flutter/material.dart';
import '../../views/login/login_view.dart';
import '../../views/login/otp_verify_view.dart';
import '../../views/onboard/onboarding_view.dart';
import '../../views/profile/update_profile_view.dart';
import '../../views/splash/splash_view.dart';
import 'routes_name.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final argument = settings.arguments;
    switch (settings.name) {
      case RoutesName.splash:
        return MaterialPageRoute(builder: (BuildContext) => const SplashView());

      case RoutesName.onboarding:
        return MaterialPageRoute(builder: (BuildContext) => const Onboarding());

      case RoutesName.login:
        return MaterialPageRoute(builder: (BuildContext) => const LoginView());

      case RoutesName.dashboard:
        return MaterialPageRoute(builder: (BuildContext) => const DummyDashboard());

      case RoutesName.paymentFrom:
        return MaterialPageRoute(builder: (BuildContext) =>   BillPaymentScreen());

      case RoutesName.update_profile:
        return MaterialPageRoute(builder: (BuildContext) =>   UpdateProfileView());

      case RoutesName.offer_view_name:
        return MaterialPageRoute(builder: (BuildContext) =>   UpdateProfileView());

      case RoutesName.verify:
        return MaterialPageRoute(
            builder: (BuildContext) => const VerifyOtpView());

      default:
        return MaterialPageRoute(builder: (_) {
          return Scaffold(
            body: Center(
              child: Text('No route defined'),
            ),
          );
        });
    }
  }
}
