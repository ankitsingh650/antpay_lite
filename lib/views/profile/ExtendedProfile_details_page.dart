 
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../utils/widgets/reusables.dart';
import '../../utils/widgets/stateless_reusables.dart';

class ExtendedProfile_details_page extends StatefulWidget {
  final TextEditingController mIncomeController;
  final FocusNode mIncomeFocusNode;
  final FocusNode mNumberFocusNode;


  final GlobalKey<FormState> formKey;

  String? ocupation;
  String? selectedOccupation;
  String? selectedGender;


  ExtendedProfile_details_page({
    required this.mIncomeController,
    required this.mIncomeFocusNode,
    required this.mNumberFocusNode,
    required this.formKey,

  });


  @override
  State<ExtendedProfile_details_page> createState() => _ExtendedProfile_details_pageState();
}

class _ExtendedProfile_details_pageState extends State<ExtendedProfile_details_page> {
  bool? _isInvesting = null;
  bool? _isInvestingin = null;
  String ocupationsalar = 'Salaried'; // Initialize with a default value
  String Education = 'Post Graduate'; // Initialize with a default value

  List<String> ocupationList = ["Salaried", "Self Employed - Professional", "Self Employed - Business Person", "HouseMaker", "Student", "Retired", "Others", "Select occupation"];
  List<String> EducationList = ["Post Graduate", "Graduate", "12th", "Diploma", "10th", "Below 10th", "Select your education"];

  late var ExtendedProfile_details_pageViewModel;

  late TextEditingController searchContentSetor;

  @override
  void initState() {
    // TODO: implement initState
    ExtendedProfile_details_pageViewModel = _ExtendedProfile_details_pageState();
    searchContentSetor = TextEditingController();
    WidgetsBinding.instance?.addPostFrameCallback((_) {

    });
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    //BasicProfile_details_pageViewModel = Provider.of<UpdateProfileViewModel>(context);

    ocupationsalar = ExtendedProfile_details_pageViewModel.ocupationsalar;
    Education = ExtendedProfile_details_pageViewModel.Education;


    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          SizedBox(
            height: 12,
          ),
          Flexible(
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              scrollDirection: Axis.vertical,
              child: Form(
                key: widget.formKey,
                // autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  children: [
                    HeaderAlignText(headerText: "Ocupation"),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: DropdownButtonFormField<String>(
                        isExpanded: true,
                        hint: const Text('Ocupation'),
                        value: ocupationsalar,
                        icon: const Icon(Icons.arrow_drop_down),
                        validator: (value) => value == null ? 'Select ocupation' : null,
                        items: ocupationList
                            ?.map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.normal,
                                color: Colors.black,
                              ),
                            ),
                          );
                        })
                            .toSet()
                            .toList(),
                        onChanged: (String? value) {
                          setState(() {
                            ocupationsalar = value ?? ''; // Ensure it's not null
                            widget.selectedGender = value;
                            ExtendedProfile_details_pageViewModel.setGender(value ?? '');
                          });
                        },
                      ),

                    ),

                    HeaderAlignText(headerText: "Education"),
                    // InputFieldSizedBox(
                    //   controller: widget.mOccupationController,
                    //   currentFocusNode: widget.mOccupationFocusNode,
                    //   nextFocusNode: null,
                    //   hintText: "Enter your Occupation",
                    //   enabled: true,
                    //   radius: 8.0,
                    //   validator: (value) {
                    //     if (value!.isEmpty) {
                    //       return "Enter your Occupation";
                    //     }
                    //     return null;
                    //   },
                    //   keyboardType: TextInputType.text,
                    //   context: context,
                    // ),
                    CustomDropdownFormField(
                      hint: 'Select Education',
                      value: Education.isEmpty?null:Education,
                      items: EducationList,
                      isValidate: true,
                      errorText: "Education Required",
                      onChanged: (String? value) {
                        setState(() {
                          Education = value!;
                          widget.selectedOccupation = value!;
                          ExtendedProfile_details_pageViewModel.setOccupation(value!);
                        });
                      },
                    ),

                    HeaderAlignText(headerText: "Income per month"),
                    InputFieldSizedBox(
                      controller: widget.mIncomeController,
                      currentFocusNode: widget.mIncomeFocusNode,
                      nextFocusNode: widget.mNumberFocusNode,
                      hintText: "Enter Income",
                      enabled: true,
                      radius: 8.0,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Enter Income";
                        }
                        if (value.length < 3) {
                          return "Enter valid Income";
                        }
                        return null;
                      },
                      keyboardType: TextInputType.number,
                      context: context,
                    ),

                    Text(
                      'Do you invest in Equity Markets, Mutual Funds and Fixed Deposits ?',
                      style: TextStyle(
                        fontFamily: 'rupee_ford',
                        color: Colors.black, // Change the color as needed
                        fontSize: 12.0,
                      ),
                    ),
                    SizedBox(height: 10.0),
                    Row(
                      children: [
                        Radio<bool>(
                          value: true,
                          groupValue: _isInvesting,
                          onChanged: (bool? value) {
                            setState(() {
                              _isInvesting = value;
                              // Handle the radio button state change
                              if (_isInvesting == true) {
                                // Show a message when "Yes" is selected

                              }
                            });
                          },
                        ),
                        Text(
                          'Yes',
                          style: TextStyle(
                            fontFamily: 'rupee_ford',
                            fontSize: 12.0,
                          ),
                        ),
                        SizedBox(width: 10.0),
                        Radio<bool>(
                          value: false,
                          groupValue: _isInvesting,
                          onChanged: (bool? value) {
                            setState(() {
                              _isInvesting = value;
                              // Handle the radio button state change
                              if (_isInvesting == false) {
                                // Show a message when "No" is selected

                              }
                            });
                          },
                        ),
                        Text(
                          'No',
                          style: TextStyle(
                            fontFamily: 'rupee_ford',
                            fontSize: 12.0,
                          ),
                        ),
                      ],
                    ),

                    Text(
                      'Do you own a house, car or two wheeler ?',
                      style: TextStyle(
                        fontFamily: 'rupee_ford',
                        color: Colors.black, // Change the color as needed
                        fontSize: 12.0,
                      ),
                    ),
                    SizedBox(height: 10.0),
                    Row(
                      children: [
                        Radio<bool>(
                          value: true,
                          groupValue: _isInvestingin,
                          onChanged: (bool? value) {
                            setState(() {
                              _isInvestingin = value;
                              // Handle the radio button state change
                              if (_isInvestingin == true) {
                                // Show a message when "Yes" is selected

                              }
                            });
                          },
                        ),
                        Text(
                          'Yes',
                          style: TextStyle(
                            fontFamily: 'rupee_ford',
                            fontSize: 12.0,
                          ),
                        ),
                        SizedBox(width: 10.0),
                        Radio<bool>(
                          value: false,
                          groupValue: _isInvestingin,
                          onChanged: (bool? value) {
                            setState(() {
                              _isInvestingin = value;
                              // Handle the radio button state change
                              if (_isInvestingin == false) {
                                // Show a message when "No" is selected

                              }
                            });
                          },
                        ),
                        Text(
                          'No',
                          style: TextStyle(
                            fontFamily: 'rupee_ford',
                            fontSize: 12.0,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom))
        ],
      ),
    );
  }
}



