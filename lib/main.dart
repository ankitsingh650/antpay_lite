import 'package:antpay_lite/ViewModel/login/otp_verify_view_model.dart';
import 'package:antpay_lite/firebase_options.dart';
import 'package:antpay_lite/preferences/utility_preferences.dart';
import 'package:antpay_lite/utils/routes/routes.dart';
import 'package:antpay_lite/utils/routes/routes_name.dart';
import 'package:antpay_lite/views/dashboard/dashboard_view.dart';
import 'package:antpay_lite/views/dashboard/offer_view.dart';
import 'package:antpay_lite/views/dashboard/offer_view_model.dart';
import 'package:antpay_lite/views/login/BasicProfile_details_page.dart';
import 'package:antpay_lite/views/login/ExtendedProfile_details_page.dart';
import 'package:antpay_lite/views/login/update_profile_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'ViewModel/login/login_view_model.dart';
import 'ViewModel/payment/generateRazorpayorderViewmodel.dart';
import 'ViewModel/transaction/transaction_history_view_model.dart';
import 'preferences/session_ manager.dart';
import 'views/payment/PaymentScreen.dart';

void main() async {
  // Initialize Firebase
  WidgetsFlutterBinding.ensureInitialized();

  await SessionManager.initialize();
  await UtilityPreferences.initialize();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform)
      .then((value) {
    // Pass all uncaught errors from the framework to Crashlytics.
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;

    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Antpay',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LoginViewModel()),
        ChangeNotifierProvider(create: (_) => OtpVerifyViewModel()),
        ChangeNotifierProvider(create: (_) => TransactionHistoryViewModel()),
        ChangeNotifierProvider(create: (_)=> GenerateRazorpayorderViewModel()),
        ChangeNotifierProvider(create: (_)=> GenerateRazorpayorderViewModel()),
        ChangeNotifierProvider(create: (_)=> OfferViewModel()),
        //ChangeNotifierProvider(create: (_)=> UpdateProfileViewState()),

      ],
      child: MaterialApp(
        title: 'Antpay Bizhub',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        initialRoute: RoutesName.splash,
        onGenerateRoute: Routes.generateRoute,
      ),
    );
  }
}
