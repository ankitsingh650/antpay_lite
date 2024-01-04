import 'package:antpay_lite/ViewModel/wallet/min_kyc_view_model.dart';
import 'package:antpay_lite/app_constants.dart';
import 'package:antpay_lite/model/wallet/PanKYCResponseModel.dart';
import 'package:antpay_lite/res/color_palette.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_holo_date_picker/date_picker.dart';
import 'package:provider/provider.dart';

import '../../utils/widgets/reusables.dart';
import '../../utils/widgets/stateless_reusables.dart';

class MinKycScreen extends StatefulWidget {
  const MinKycScreen({super.key});

  @override
  State<MinKycScreen> createState() => _MinKycScreenState();
}

class _MinKycScreenState extends State<MinKycScreen> {
  late var mynKycViewModel;

  List<String> genderList = ['Male', 'Female'];

  List<String> cityList = ['Delhi', 'Faridabad'];

  List<String> stateList = ['Delhi', 'Haryana'];



  @override
  void initState() {

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    mynKycViewModel = Provider.of<MinKycViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: ColorPalette.white,
        title: Text('Min Ac Kyc'),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(top: 20.0),
              child: Image.asset(
                'assets/images/profileicon1.png',
                // replace with your image path
                height: 100.0,
              ),
            ),
            Card(
              elevation: 2,
              color: ColorPalette.white,
              surfaceTintColor: ColorPalette.white,
              margin: EdgeInsets.only(bottom: 10.0, left: 10, right: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Padding(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Text(
                      'Mini Account',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Create your Mini Account',
                      style: TextStyle(fontSize: 10.0),
                    ),
                    // Add other UI elements here
                    // ...

                    // Example: EditText for Aadhaar Number

                    HeaderAlignText(headerText: "Aadhaar Number"),
                    InputFieldSizedBox(
                      // controller: widget.mNameController,
                      // currentFocusNode: widget.mnameFocusNode,
                      // nextFocusNode: widget.mEmailFocusNode,
                      hintText: "Enter your Name",
                      enabled: true,
                      radius: 8.0,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Enter your Name";
                        }
                        if (value.length < 3) {
                          return "Name too short";
                        }
                        return null;
                      },
                      keyboardType: TextInputType.text,
                      context: context,
                    ),

                    /*    TextField(
                      decoration: InputDecoration(
                        labelText: 'Aadhaar Number',
                      ),
                    ),*/

                    // Example: RadioButton for Aadhaar
                    /*  RadioListTile(
                      value: 'aadhaar',
                      groupValue: 'kyc_method',
                      onChanged: (value) {
                        // Handle radio button change
                      },
                      title: Text('Aadhaar KYC'),
                    ),

                    // Example: RadioButton for PAN
                    RadioListTile(
                      value: 'pan',
                      groupValue: 'kyc_method',
                      onChanged: (value) {
                        // Handle radio button change
                      },
                      title: Text('PAN KYC'),
                    ),*/

                    HeaderAlignText(headerText: "Gender"),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: DropdownButtonFormField<String>(
                        isExpanded: true,
                        hint: const Text('Select Gender'),
                        // value: gender,
                        icon: const Icon(Icons.arrow_drop_down),
                        validator: (value) =>
                            value == null ? 'Select Gender' : null,
                        items: genderList
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
                          /* setState(() {
                            gender = value ?? ''; // Ensure it's not null
                            widget.selectedGender = value;
                            BasicProfile_details_pageViewModel.setGender(value ?? '');
                          });*/
                        },
                      ),
                    ),

                    // Date of Birth
                    HeaderAlignText(headerText: "Date of Birth"),
                    InkWell(
                      onTap: () async {
                        var datePicked = await DatePicker.showSimpleDatePicker(
                          context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1900),
                          lastDate: DateTime.now(),
                          dateFormat: "dd-MMMM-yyyy",
                          looping: true,
                        );

                        if (datePicked != null) {
                          // setState(() {
                          //   widget.mDOBController.text='${datePicked.day}/${datePicked.month}/${datePicked.year}';
                          // });
                          // String formattedDate = DateFormat('dd-MM-yyyy').format(datePicked);
                          // setState(() {
                          //   widget.mDOBController.text = formattedDate;
                          // });

                          /*   setState(() {
                            String formattedDate =
                            DateFormat('dd/MM/yyyy').format(datePicked);
                            setState(() {
                              widget.mDOBController.text = formattedDate;
                            });
                          }

                          );*/
                        }
                      },
                      child: SizedBox(
                        height: 35,
                        child: TextFormField(
                          //controller: widget.mDOBController,
                          enabled: false,
                          decoration: InputDecoration(
                            hintText: 'Enter D.O.B',
                            suffixIcon: const Icon(Icons.calendar_month),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                              borderRadius: BorderRadius.circular(20.0),
                              gapPadding: 0.5,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                              borderRadius: BorderRadius.circular(20.0),
                              gapPadding: 0.5,
                            ),
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 15),
                            hintStyle: TextStyle(
                              fontSize: 14,
                            ),
                          ),
                          onFieldSubmitted: (value) {},
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                            color: Colors.black,
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Please Enter D.O.B";
                            }
                          },
                        ),
                      ),
                    ),
                    // Add your DatePicker widget here

                    // Pincode

                    HeaderAlignText(headerText: "Pin Code"),
                    InputFieldSizedBox(
                      // controller: widget.mNameController,
                      // currentFocusNode: widget.mnameFocusNode,
                      // nextFocusNode: widget.mEmailFocusNode,
                      hintText: "Pin Code",
                      enabled: true,
                      radius: 8.0,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Enter your Pincode";
                        }
                        if (value.length < 6) {
                          return "Pincode too short";
                        }
                        return null;
                      },
                      keyboardType: TextInputType.text,
                      context: context,
                    ),

                    HeaderAlignText(headerText: "Select State"),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: DropdownButtonFormField<String>(
                        isExpanded: true,
                        hint: const Text('Select State'),
                        // value: city,
                        icon: const Icon(Icons.arrow_drop_down),
                        validator: (value) =>
                            value == null ? 'Select State' : null,
                        items: stateList
                            .map<DropdownMenuItem<String>>((String value) {
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
                          /*  setState(() {
                            city = value ?? ''; // Ensure it's not null
                            widget.selectedGender = value;
                            BasicProfile_details_pageViewModel.setGender(value ?? '');
                          });*/
                        },
                      ),
                    ),
                    // Add your State Dropdown widget here

                    // City
                    HeaderAlignText(headerText: "Select City"),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: DropdownButtonFormField<String>(
                        isExpanded: true,
                        hint: const Text('Select City'),
                        // value: city,
                        icon: const Icon(Icons.arrow_drop_down),
                        validator: (value) =>
                            value == null ? 'Select City' : null,
                        items: cityList
                            .map<DropdownMenuItem<String>>((String value) {
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
                          /*  setState(() {
                            city = value ?? ''; // Ensure it's not null
                            widget.selectedGender = value;
                            BasicProfile_details_pageViewModel.setGender(value ?? '');
                          });*/
                        },
                      ),
                    ),
                    // Add your City Dropdown widget here

                    // Address
                    HeaderAlignText(headerText: "Address"),
                    InputFieldSizedBox(
                      // controller: widget.mNameController,
                      // currentFocusNode: widget.mnameFocusNode,
                      // nextFocusNode: widget.mEmailFocusNode,
                      hintText: "Enter your Address",
                      enabled: true,
                      radius: 8.0,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Enter your Address";
                        }

                        return null;
                      },
                      keyboardType: TextInputType.text,
                      context: context,
                    ),
                    // KYC Disclaimer

                    SizedBox(
                      height: 10,
                    ),

                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        AppConstant.disclaimerText,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                        ),
                      ),
                    ),

                    SizedBox(
                      height: 20,
                    ),
                    // Proceed Button

                    ElevatedButton(
                      onPressed: () async {


                        PanKYCResponseModel responseName = await mynKycViewModel.minKycAadhar( );

                               if (kDebugMode) {
                                 print(responseName);
                               }


                        // Handle button click
                      },
                      child: Text(
                        'Proceed',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.white,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.blue, // your button's color
                      ),
                    ),

                    // ... other widgets ...
                  ],
                ),
              ),
            ),
            // Add other UI elements here
            // ...
          ],
        ),
      ),
    );
  }
}
