import 'package:flutter/material.dart';

import '../../model/oboarding_content_model.dart';
import '../../res/color_palette.dart';
import '../../utils/routes/routes_name.dart';



class Onboarding extends StatefulWidget {
  const Onboarding({Key? key}) : super(key: key);

  @override
  _OnboardingState createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  int currentIndex = 0;

  late PageController _pageController;

  @override
  void initState() {
     _pageController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
                controller: _pageController,
                itemCount: contents.length,
                onPageChanged: (int index) {
                  setState(() {
                    currentIndex = index;
                  });
                },
                itemBuilder: (_, i) {
                  return Padding(
                    padding: const EdgeInsets.all(80.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                            contents[i].headerImage),
                        SizedBox(height: 50),
                        Image.asset(contents[i].contentImage),
                        SizedBox(height: 20),
                        Text(
                          contents[i].headerText,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: Colors.black),
                        ),
                        Text(
                          contents[i].descText,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ],
                    ),
                  );
                }),
          ),
          Container(
            height: 50,
            margin: EdgeInsets.symmetric(horizontal: 100),
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.blueAccent,
              borderRadius: BorderRadius.circular(20),
            ),
            child: TextButton(
              onPressed: () {
                if (currentIndex == contents.length - 1) {
               /*    Navigator.push(context,
                      MaterialPageRoute(builder: (_) => SignInScreen()));
                  Navigator.pushNamed(context, RoutesName.login);*/
                  Navigator.pushReplacementNamed(context, RoutesName.login);
                }
                _pageController.nextPage(
                    duration: Duration(milliseconds: 200),
                    curve: Curves.bounceIn);
              },
              style: TextButton.styleFrom(
                  foregroundColor: Colors.black,
                  backgroundColor: ColorPalette.dotPagerSelected,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20))),
              child: Text(currentIndex == contents.length-1 ? "Let's Get started" : "Next"),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                  contents.length, (index) => buildDotPager(index)),
            ),
          )
        ],
      ),
    );
  }

  Container buildDotPager(int index) {
    return Container(
      height: 10,
      width: currentIndex == index ? 30 : 15,
      margin: EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: currentIndex == index ?ColorPalette.dotPagerSelected: ColorPalette.dotPagerUnselected),
    );
  }
}
