
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import '../../ViewModel/login/update_profile_view_model.dart';
import '../../data/retrofit/auth.dart';
import '../../model/login/profile_data.dart';
import '../../preferences/session_ manager.dart';
import '../../repository/common/common_api_repo.dart';
import '../../res/color_palette.dart';
import '../../utils/common_utils.dart';
import '../../utils/custom_shape.dart';
import '../../utils/routes/routes_name.dart';
import '../../utils/widgets/stateless_reusables.dart';
import 'BasicProfile_details_page.dart';
import 'ExtendedProfile_details_page.dart';


class UpdateProfileView extends StatefulWidget {
  const UpdateProfileView({Key? key}) : super(key: key);

  @override
  State<UpdateProfileView> createState() => _UpdateProfileViewState();
}

class _UpdateProfileViewState extends State<UpdateProfileView> {

  /*late MerchantDetails details;*/
  late TextEditingController merchantID,
      name,
      email,
      number,
      location,
      occupation,
      date,
      mIncomeController
  ;

  FocusNode idNode = FocusNode();
  FocusNode nameNode = FocusNode();
  FocusNode emailNode = FocusNode();
  FocusNode numberNode = FocusNode();
  FocusNode businessNameNode = FocusNode();
  FocusNode occupationNode = FocusNode();
  FocusNode addressNode = FocusNode();
  FocusNode cityNode = FocusNode();
  FocusNode pinCodeNode = FocusNode();
  FocusNode locationNode = FocusNode();
  FocusNode mNumberFocusNode = FocusNode();
  FocusNode mIncomeFocusNode = FocusNode();

  late TextEditingController mBusinessName, mAddress, mCity, mPin;

  late PageController _pageViewController;

  int currentIndex = 0;

  var _myFormKey1 = GlobalKey<FormState>();
  var _myFormKey2 = GlobalKey<FormState>();


  List<String> genderList = ['Male', 'Female'];

  String? gender;

  late var UpdateProfileViewModel;


  @override
  void initState() {
    _pageViewController = PageController(initialPage: 0);
    _myFormKey1 = GlobalKey<FormState>();
    _myFormKey2 = GlobalKey<FormState>();

    merchantID = TextEditingController();
    name = TextEditingController();
    email = TextEditingController();
    number = TextEditingController();
    location = TextEditingController();
    occupation = TextEditingController();
    date = TextEditingController();
    mIncomeController = TextEditingController();

    mBusinessName = TextEditingController();
    mAddress = TextEditingController();
    mCity = TextEditingController();
    mPin = TextEditingController();


    UpdateProfileViewModel = _UpdateProfileViewState();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
    //  _initFields();
    });
    // WidgetsBinding.instance?.addPostFrameCallback((_) {
    //   _initStates();
    //   _initIndustries();
    // });
    super.initState();
  }

  @override
  void dispose() {
    merchantID.dispose();
    name.dispose();
    email.dispose();
    number.dispose();
    location.dispose();
    mBusinessName.dispose();
    mAddress.dispose();
    mCity.dispose();
    mPin.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      // resizeToAvoidBottomInset: false,
      backgroundColor: ColorPalette.iconColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Container(
                height: MediaQuery.of(context).size.height,
              ),
              Positioned(
                top: 15,
                left: 0,
                right: 0,
                child: Container(
                  height: 100,
                  width: 250,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image:
                              AssetImage('assets/images/profileicon1.png'))),
                ),
              ),
              Positioned(
                  top: 115,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    height: MediaQuery.of(context).size.height*0.78, //600,
                    width: MediaQuery.of(context).size.width - 40,
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(25),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              blurRadius: 15,
                              spreadRadius: 5),
                        ]),
                    child: Column(
                      children: [
                        Text(
                          "Update Profile",
                          style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: CommonUtils.toColor("#000000")),
                        ),
                        SizedBox(
                          height: 450,
                          child: PageView(
                            // physics: NeverScrollableScrollPhysics(),
                            controller: _pageViewController,
                            onPageChanged: (int index) {
                              setState(() {
                                currentIndex = index;
                              });
                              // print(':::Name: ${fName.text}\nEmail: ${mEmail.text}\nPhone: ${mPhone.text}\nDOB: ${date.text}\nGender: ${businessLoanViewModel.gender}\nStatus: ${detailsPage.selectedMaritalStatus}\State: ${detailsPage.selectedState}\nCity: ${detailsPage.selectedCity}\nEducation: ${detailsPage.selectedEducation}\Occupation: ${detailsPage.selectedOccupation}');
                            },
                            children: [
                              BasicProfile_details_page(
                                  mNameController: name,
                                  mnameFocusNode: nameNode,
                                  mEmailController: email,
                                  mEmailFocusNode: emailNode,
                                  mNumberController: number,
                                  mNumberFocusNode: numberNode,
                                  mOccupationController: occupation,
                                  mOccupationFocusNode: occupationNode,
                                  mDOBController: date,
                                  formKey: _myFormKey1),
                              ExtendedProfile_details_page(
                                  mIncomeController: mIncomeController,
                                  mIncomeFocusNode: mIncomeFocusNode,
                                  mNumberFocusNode: mNumberFocusNode,

                                  formKey: _myFormKey2, )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        if (currentIndex == 0)
                          Container(
                            margin: EdgeInsets.only(top: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Container(
                                  width: 110,
                                  height: 35,
                                  margin: EdgeInsets.only(top: 10),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50)),
                                  child: ElevatedButton(
                                    onPressed: () {
                                      print('corporate id:${SessionManager().getCorporateID().toString()}');
                                      // Navigator.pushNamed(
                                      //     context, RoutesName.dummy_dash);
                                      //saveProfilePrefs();
                                      Navigator.pushReplacementNamed(
                                          context, RoutesName.dashboard);
                                    },
                                    child: Text(
                                      "Skip",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.normal,
                                          fontSize: 14),
                                    ),
                                    style: ButtonStyle(backgroundColor:
                                        MaterialStateProperty.resolveWith(
                                            (states) {
                                      if (states
                                          .contains(MaterialState.pressed)) {
                                        return ColorPalette.skipButton;
                                      }
                                      return ColorPalette.skipButton;
                                    })),
                                  ),
                                ),
                                Container(
                                  width: 110,
                                  height: 35,
                                  margin: EdgeInsets.only(top: 10, left: 10),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50)),
                                  child: ElevatedButton(
                                    onPressed: () async {
                                        if (_myFormKey1.currentState!.validate()) {
                                          _pageViewController.nextPage(
                                              duration: Duration(
                                                  milliseconds: 200),
                                              curve: Curves.bounceIn);
                                          setState(() {
                                            if (currentIndex <
                                                3) currentIndex++;
                                          });
                                        }
                                    },
                                    child: Text(
                                      "Proceed",
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
                                        return ColorPalette.nextButtonColor;
                                      }
                                      return ColorPalette.nextButtonColor;
                                    })),

                                  ),
                                ),
                              ],
                            ),
                          ),
                        if (currentIndex == 1)
                          Expanded(
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: SizedBox(
                                width: double.infinity,
                                height: 40,
                                child: TextButton(
                                  onPressed: () {
                                    _initState();
                                  },
                                  style: TextButton.styleFrom(
                                      foregroundColor: Colors.black,
                                      backgroundColor:
                                          ColorPalette.nextButtonColor,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20))),
                                  child: Text("Submit"),
                                ),
                              ),
                            ),
                          ),
                        Expanded(
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              margin: EdgeInsets.symmetric(vertical: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: List.generate(
                                    2, (index) => buildDotPager(index)),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )),
              Positioned(
                  left: -3,
                  right: 0,
                  top: 115,
                  child: Container(
                    height: 20,
                    width: 50,
                    margin: EdgeInsets.symmetric(horizontal: 50),
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/images/img_in.png'))),
                  ))
            ],
          ),
        ),
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
          color: currentIndex == index
              ? ColorPalette.nextButtonColor
              : ColorPalette.dotPagerUnselected),
    );
  }



  void _initState() async {
    CommonApiRepo repoClass = CommonApiRepo();
    ProfileUpdateRequestModel request = ProfileUpdateRequestModel(
        company_name: "",
        dob: date.text.toString(),
        email: email.text.toString(),
        income: mIncomeController.text.toString(),
        invest_in_equity_market_flag: "0",
        marital_status: 'Married',
        mobile: SessionManager().getMobile().toString(),
        name: name.text.toString(),
        occupation: 'UpdateProfileViewModel.ocupationsalar.toString()',
        own_house_motor_flag: "0",
        profile_img: "",
        qualification: 'Graduate');


    ProfileUpdateResponseModel response;

    response = await repoClass.apiClient.profileUpdate(
        SessionManager().getToken().toString(),
        AuthToken.getAuthToken(),
        request);

    if (response.status.toString() == "1") {
      print('Response:${response.status}');
      Navigator.pushReplacementNamed(
          context, RoutesName.dashboard);
      setState(() {
      });
    } else {

    }
  }
}


