import 'package:antpay_lite/views/nav/profile.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../../res/color_palette.dart';
import '../../utils/routes/routes.dart';
import '../nav/home.dart';
import '../transaction/transaction_history_view.dart';

class DummyDashboard extends StatefulWidget {
  const DummyDashboard({Key? key}) : super(key: key);

  @override
  State<DummyDashboard> createState() => _DummyDashboardState();
}

class _DummyDashboardState extends State<DummyDashboard> {
  bool showQR = false;
  bool fetchQR = false;
  bool activated = false;
  String? qrData;
  int _currentIndex = 0;
  int _selectedIndex = 0;
  List pages = [Home(), TransactionHistory(), Profile()];
 // List pages = [Home(), Profile(), TransactionHistory(), Social()];

  List<Widget> _pages = [Home(),TransactionHistory(),Profile()];

  // Custom PersistentTabController
  final PersistentTabController _controller =
  PersistentTabController(initialIndex: 0);

  @override
  void initState() {

    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Container(
          height: 30,
          width: MediaQuery.of(context).size.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset('assets/images/antpay_logo.png',
              width: MediaQuery.of(context).size.width*0.30,
              height: 30,),
              // Image.asset('assets/images/antpaybizhub_logo.png',
              //   width: MediaQuery.of(context).size.width*0.30,
              //   height: 30,),
            ],
          ),
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
              },
            ),
          )
        ],
      ),

      body: _pages[_selectedIndex],
     /* body: PersistentTabView(
        context,
        controller: _controller,
        screens: _pages,
        items: _navBarItems(),
        backgroundColor: Colors.white,
        handleAndroidBackButtonPress: true,
        resizeToAvoidBottomInset: false,
        navBarStyle: NavBarStyle.style13,
        hideNavigationBarWhenKeyboardShows: true,
        confineInSafeArea: true,
        // Choose the style you want
      ),*/

      bottomNavigationBar: BottomNavigationBar(
        elevation: 2,
        currentIndex:  _selectedIndex,
          showSelectedLabels: true,
          showUnselectedLabels: true,
         selectedItemColor: ColorPalette.colorPrimary,
          onTap: (index) {
            if (index == _selectedIndex) {
              // If tapped index is the same as the current index, you can choose to ignore the tap or reset the state
                setState(() {

                 _currentIndex = 0; // Reset to a default index
               });
            } else {
              setState(() {
                _selectedIndex = index;
              });
            }
          },
          items: _items()),
    );
  }

List<BottomNavigationBarItem> _items(){
    return    [
      BottomNavigationBarItem(
        icon: ImageIcon(
          AssetImage('assets/images/home.png'),
        ),
        label: 'Home',
      ),
      BottomNavigationBarItem(
        icon: ImageIcon(
          AssetImage('assets/images/history.png'),
        ),
        label: 'History',
      ),

      BottomNavigationBarItem(
        icon: ImageIcon(
          AssetImage('assets/images/profile.png'),
        ),
        label: 'Profile',
      ),
      // Add more items as needed
    ];
}

  List<PersistentBottomNavBarItem> _navBarItems() {
    return [
      PersistentBottomNavBarItem(
        icon: ImageIcon(
          AssetImage('assets/images/home.png'),
        ),
        // icon: Icon(Icons.home),
        title: "Home",
        activeColorPrimary: ColorPalette.bottomIconSelectedColor,
        inactiveColorPrimary: ColorPalette.bottomIconUnSelectedColor,
        routeAndNavigatorSettings: const RouteAndNavigatorSettings(onGenerateRoute:
        Routes.generateRoute),
      ),
      PersistentBottomNavBarItem(
        icon: ImageIcon(
          AssetImage('assets/images/history.png'),
        ),
        title: "History",
        activeColorPrimary: ColorPalette.bottomIconSelectedColor,
        inactiveColorPrimary: ColorPalette.bottomIconUnSelectedColor,
        routeAndNavigatorSettings: const RouteAndNavigatorSettings(onGenerateRoute:
        Routes.generateRoute),
      ),
      PersistentBottomNavBarItem(
        icon: ImageIcon(
          AssetImage('assets/images/profile.png'),
        ),
        title: "Profile",
        activeColorPrimary: ColorPalette.bottomIconSelectedColor,
        inactiveColorPrimary: ColorPalette.bottomIconUnSelectedColor,
        routeAndNavigatorSettings: const RouteAndNavigatorSettings(onGenerateRoute:
        Routes.generateRoute),
      ),

    /*  PersistentBottomNavBarItem(
        icon: ImageIcon(
          AssetImage('assets/images/social.png'),
        ),
        title: "Social",
        activeColorPrimary: ColorPalette.bottomIconSelectedColor,
        inactiveColorPrimary: ColorPalette.bottomIconUnSelectedColor,
      ),*/
    ];
  }
}



