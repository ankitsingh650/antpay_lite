
import 'package:flutter/material.dart';
import 'package:flutter_holo_date_picker/date_picker.dart';

import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../utils/widgets/reusables.dart';
import '../../utils/widgets/stateless_reusables.dart';


class BasicProfile_details_page extends StatefulWidget {

  final TextEditingController mNameController;
  final FocusNode mnameFocusNode;
  final TextEditingController mEmailController;
  final FocusNode mEmailFocusNode;

  final TextEditingController mNumberController;
  final FocusNode mNumberFocusNode;
  final TextEditingController mOccupationController;
  final FocusNode mOccupationFocusNode;
  final TextEditingController mDOBController;

  final GlobalKey<FormState> formKey;

  String? selectedGender;
  String? selectedOccupation;

  BasicProfile_details_page({
    required this.mNameController,
    required this.mnameFocusNode,
    required this.mEmailController,
    required this.mEmailFocusNode,
    required this.mNumberController,
    required this.mNumberFocusNode,
    required this.mOccupationController,
    required this.mOccupationFocusNode,
    required this.mDOBController,
    required this.formKey,
  });

  @override
  State<BasicProfile_details_page> createState() => _BasicProfile_details_pageState();
}


class _BasicProfile_details_pageState extends State<BasicProfile_details_page> {

  String gender = 'Male';// Initialize with an empty string
  late String occupation = '';

  List<String> genderList = ['Male', 'Female'];

  List<String> occupationList = [
    'Single',
    'Married'
  ];

  late var BasicProfile_details_pageViewModel;
  @override
  void initState() {
    super.initState();

    // Initialize BasicProfile_details_pageViewModel here
    BasicProfile_details_pageViewModel = _BasicProfile_details_pageState(); // Replace with your actual initialization logic
  }
  @override
  Widget build(BuildContext context) {
    //BasicProfile_details_pageViewModel = Provider.of<UpdateProfileViewModel>(context);

    gender=BasicProfile_details_pageViewModel.gender;
    occupation=BasicProfile_details_pageViewModel.occupation;

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
                    HeaderAlignText(headerText: "Name"),
                    InputFieldSizedBox(
                      controller: widget.mNameController,
                      currentFocusNode: widget.mnameFocusNode,
                      nextFocusNode: widget.mEmailFocusNode,
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
                    HeaderAlignText(headerText: "E-mail ID"),
                    InputFieldSizedBox(
                      controller: widget.mEmailController,
                      currentFocusNode: widget.mEmailFocusNode,
                      nextFocusNode: widget.mNumberFocusNode,
                      hintText: "Enter mail ID",
                      enabled: true,
                      radius: 8.0,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Enter Email";
                        }
                        if (value.length < 3) {
                          return "Enter valid mail";
                        }
                        return null;
                      },
                      keyboardType: TextInputType.emailAddress,
                      context: context,
                    ),
                    HeaderAlignText(headerText: "Mobile Number"),
                    InputFieldSizedBox(
                      controller: widget.mNumberController,
                      currentFocusNode: widget.mNumberFocusNode,
                      nextFocusNode: widget.mOccupationFocusNode,
                      hintText: "Enter your Mobile",
                      enabled: false,
                      radius: 8.0,
                      // validator: (value) {
                      //   if (value!.isEmpty) {
                      //     return "Enter your Mobile";
                      //   }
                      //   if (value.length < 3) {
                      //     return "Name too short";
                      //   }
                      //   return null;
                      // },
                      keyboardType: TextInputType.phone,
                      context: context,
                    ),
                    HeaderAlignText(headerText: "Gender"),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: DropdownButtonFormField<String>(
                        isExpanded: true,
                        hint: const Text('Select Gender'),
                        value: gender,
                        icon: const Icon(Icons.arrow_drop_down),
                        validator: (value) => value == null ? 'Select Gender' : null,
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
                          setState(() {
                            gender = value ?? ''; // Ensure it's not null
                            widget.selectedGender = value;
                            BasicProfile_details_pageViewModel.setGender(value ?? '');
                          });
                        },
                      ),

                    ),

                    HeaderAlignText(headerText: "Marital Status"),
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
                      hint: 'Select your Marital',
                      value: occupation.isEmpty?null:occupation,
                      items: occupationList,
                      isValidate: true,
                      errorText: "Marital Required",
                      onChanged: (String? value) {
                        setState(() {
                          occupation = value!;
                          widget.selectedOccupation = value!;
                          BasicProfile_details_pageViewModel.setOccupation(value!);
                        });
                      },
                    ),
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

                        if(datePicked!=null)
                        {
                          // setState(() {
                          //   widget.mDOBController.text='${datePicked.day}/${datePicked.month}/${datePicked.year}';
                          // });
                          // String formattedDate = DateFormat('dd-MM-yyyy').format(datePicked);
                          // setState(() {
                          //   widget.mDOBController.text = formattedDate;
                          // });

                          setState(() {
                            String formattedDate =
                            DateFormat('dd/MM/yyyy').format(datePicked);
                            setState(() {
                              widget.mDOBController.text = formattedDate;
                            });
                          });
                        }

                      },

                      child: SizedBox(
                        height: 35,
                        child: TextFormField(
                          controller: widget.mDOBController,
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
                    //-----------------------------------------------------------
                    //for update profile Screen 2
                    // HeaderAlignText(headerText: "Business Name"),
                    // InputFieldSizedBox(
                    //   controller: businessName,
                    //   currentFocusNode: businessNameNode,
                    //   nextFocusNode: addressNode,
                    //   hintText: "Enter Business Name",
                    //   enabled: true,
                    //   validator: (value) {
                    //     if (value!.isEmpty) {
                    //       return "Enter your Name";
                    //     }
                    //     if(value.length<3){
                    //       return "Name too short";
                    //     }
                    //     return null;
                    //   },
                    //   keyboardType: TextInputType.text,
                    //   context: context,
                    // ),
                    // HeaderAlignText(headerText: "Business Industry"),
                    // Align(
                    //   alignment: Alignment.centerLeft,
                    //   child: DropdownButtonFormField(
                    //     isExpanded: true,
                    //       hint: const Text('Select Industry'),
                    //       value: industry,
                    //       icon: const Icon(Icons.arrow_drop_down),
                    //       items: industryName?.map<DropdownMenuItem<String>>((String value) {
                    //         return DropdownMenuItem<String>(
                    //           value: value,
                    //           child: Text(value,
                    //               overflow: TextOverflow.ellipsis,
                    //               style: TextStyle(
                    //                 fontSize: 16,
                    //                 fontWeight: FontWeight.normal,
                    //                 color: Colors.black,
                    //               )),
                    //         );
                    //       }).toList(),
                    //       onChanged: (String? value) {
                    //         // This is called when the user selects an item.
                    //         setState(() {
                    //           industry = value!;
                    //         });
                    //       }),
                    // ),
                    // HeaderAlignText(headerText: "Address"),
                    // InputFieldSizedBox(
                    //   controller: address,
                    //   currentFocusNode: addressNode,
                    //   nextFocusNode: pinCodeNode,
                    //   hintText: "Enter Address",
                    //   enabled: true,
                    //   validator: (value) {
                    //     if (value!.isEmpty) {
                    //       return "Enter Address";
                    //     }
                    //     return null;
                    //   },
                    //   keyboardType: TextInputType.text,
                    //   context: context,
                    // ),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: [
                    //     Expanded(
                    //       flex: 1,
                    //       child: Container(
                    //         margin: EdgeInsets.all(8),
                    //         child: Column(
                    //           children: [
                    //             Align(
                    //               alignment: Alignment.centerLeft,
                    //               child: Container(
                    //                 child: Text(
                    //                   "State",
                    //                   style: TextStyle(
                    //                       fontSize: 16,
                    //                       fontWeight: FontWeight.normal,
                    //                       color: ColorPalette.textColor),
                    //                 ),
                    //               ),
                    //             ),
                    //             Align(
                    //               alignment: Alignment.centerLeft,
                    //               child: DropdownButtonFormField(
                    //                   isExpanded: true,
                    //                   hint: const Text('Select State',
                    //                       overflow: TextOverflow.ellipsis),
                    //                   value: state,
                    //                   icon: const Icon(Icons.arrow_drop_down),
                    //                   items: stateName?.map<DropdownMenuItem<String>>((String value) {
                    //                     return DropdownMenuItem<String>(
                    //                       value: value,
                    //                       child: Text(value,
                    //                         overflow: TextOverflow.ellipsis,
                    //                           style: TextStyle(
                    //                             fontSize: 16,
                    //                             fontWeight: FontWeight.normal,
                    //                             color: Colors.black,
                    //                           )),
                    //                     );
                    //                   }).toList(),
                    //                   onChanged: (String? value) {
                    //                     // This is called when the user selects an item.
                    //                     setState(() {
                    //                       state = value!;
                    //                       code=stateDataList?.elementAt(stateName!.indexOf(state!)).code;
                    //                       print('code no: $code');
                    //                     });
                    //                     city=null;
                    //                     _initCities(code);
                    //                   }),
                    //             ),
                    //           ],
                    //         ),
                    //       ),
                    //     ),
                    //     Flexible(
                    //       child: Container(
                    //         margin: EdgeInsets.all(8),
                    //         child: Column(
                    //           children: [
                    //             Align(
                    //               alignment: Alignment.centerLeft,
                    //               child: Container(
                    //                 child: Text(
                    //                   "City",
                    //                   style: TextStyle(
                    //                       fontSize: 16,
                    //                       fontWeight: FontWeight.normal,
                    //                       color: ColorPalette.textColor),
                    //                 ),
                    //               ),
                    //             ),
                    //             Align(
                    //               alignment: Alignment.centerLeft,
                    //               child: DropdownButtonFormField(
                    //                   hint: const Text('Select City',
                    //                       overflow: TextOverflow.ellipsis),
                    //                   isExpanded: true,
                    //                   value: city,
                    //                   icon: const Icon(Icons.arrow_drop_down),
                    //                   items: cityName?.map<DropdownMenuItem<String>>((String value) {
                    //                     return DropdownMenuItem<String>(
                    //                       value: value,
                    //                       child: Text(value,
                    //                           overflow: TextOverflow.ellipsis,
                    //                           style: TextStyle(
                    //                             fontSize: 16,
                    //                             fontWeight: FontWeight.normal,
                    //                             color: Colors.black,
                    //                           )),
                    //                     );
                    //                   }).toList(),
                    //                   onChanged: (String? value) {
                    //                     // This is called when the user selects an item.
                    //                     setState(() {
                    //                       city = value!;
                    //                     });
                    //                   }),
                    //             ),
                    //           ],
                    //         ),
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    // HeaderAlignText(headerText: "Pin Code"),
                    // InputFieldSizedBox(
                    //   controller: pinCode,
                    //   currentFocusNode: pinCodeNode,
                    //   nextFocusNode: locationNode,
                    //   hintText: "Enter Pin Code",
                    //   enabled: true,
                    //   validator: (value) {
                    //     if (value!.isEmpty) {
                    //       return "Enter your Name";
                    //     }
                    //     if(value.length<6){
                    //       return "Invalid!";
                    //     }
                    //     return null;
                    //   },
                    //   keyboardType: TextInputType.number,
                    //   context: context,
                    // ),
                    // HeaderAlignText(headerText: "Generate Map"),
                    // InputFieldSizedBox(
                    //   controller: location,
                    //   currentFocusNode: locationNode,
                    //   nextFocusNode: null,
                    //   hintText: "Enter Location",
                    //   enabled: true,
                    //   validator: (value) {
                    //     if (value!.isEmpty) {
                    //       return "Location can't be empty";
                    //     }
                    //     return null;
                    //   },
                    //   keyboardType: TextInputType.text,
                    //   context: context,
                    // ),
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
