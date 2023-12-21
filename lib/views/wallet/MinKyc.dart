import 'package:antpay_lite/res/color_palette.dart';
import 'package:flutter/material.dart';

class MinKycScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Min Kyc'),
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
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Aadhaar Number',
                      ),
                    ),

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

                    // Gender

                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Gender',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Radio(
                          value: 'male',
                          groupValue: 'gender',
                          onChanged: (value) {
                            // Handle male selection
                          },
                        ),
                        Text(
                          'Male',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                          ),
                        ),
                        Radio(
                          value: 'female',
                          groupValue: 'gender',
                          onChanged: (value) {
                            // Handle female selection
                          },
                        ),
                        Text(
                          'Female',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),

                    // Date of Birth
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Date of Birth',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                        ),
                      ),
                    ),
                    // Add your DatePicker widget here

                    // Pincode
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Pincode',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                        ),
                      ),
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        hintText: 'Enter Your Pin Code',
                      ),
                      keyboardType: TextInputType.number,
                    ),

                    // State
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Select State',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                        ),
                      ),
                    ),
                    // Add your State Dropdown widget here

                    // City
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Select City',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                        ),
                      ),
                    ),
                    // Add your City Dropdown widget here

                    // Address
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Address',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                        ),
                      ),
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: 'Enter Your Address',
                      ),
                      maxLines: 3,
                    ),

                    // KYC Disclaimer
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Kyc Disclaimer',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                        ),
                      ),
                    ),

                    // Proceed Button
                    ElevatedButton(
                      onPressed: () {
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
