import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../res/color_palette.dart';


//OTP Pin Input Field Widget
Widget otpInputField(TextEditingController controller, BuildContext context) {
  return SizedBox(
    height: 68,
    width: 32,
    child: TextFormField(
      controller: controller,
      onChanged: (value) {
        if (value.length == 1) {
          FocusScope.of(context).nextFocus();
        }
        if(value.length==0){
          FocusScope.of(context).previousFocus();
        }
      },
      style: Theme.of(context).textTheme.headlineMedium,
      keyboardType: TextInputType.number,
      textAlign: TextAlign.center,
      inputFormatters: [
        LengthLimitingTextInputFormatter(1),
        FilteringTextInputFormatter.digitsOnly
      ],
    ),
  );
}

//Profile Update Text Input Fields
class InputFieldSizedBox extends StatefulWidget {
  final TextEditingController? controller;
  final FocusNode? currentFocusNode;
  final FocusNode? nextFocusNode;
  final String hintText;
  final bool enabled;
  final double? radius;
  final bool? isCaps;
  final bool? isObscured;
  final FormFieldValidator<String>? validator;
  final TextInputType keyboardType;
  final BuildContext context;

  const InputFieldSizedBox({
    this.controller,
    this.currentFocusNode,
    this.nextFocusNode,
    required this.hintText,
    this.enabled = true,
    this.radius,
    this.isCaps,
    this.isObscured,
    this.validator,
    this.keyboardType = TextInputType.text,
    required this.context,
  });

  @override
  _InputFieldSizedBoxState createState() => _InputFieldSizedBoxState();
}

class _InputFieldSizedBoxState extends State<InputFieldSizedBox> {
  bool setObscureText=false;
  @override
  Widget build(BuildContext context) {
    widget.currentFocusNode?.addListener(() {
      if (!widget.currentFocusNode!.hasFocus) {
        // When focus is lost, obscure the text
        if (widget.isObscured!) {
          setState(() {
            setObscureText = true;
          });
        }
      }
    });
    return SizedBox(
      height: 35,
      child: TextFormField(
        controller: widget.controller,
        focusNode: widget.currentFocusNode,
        enabled: widget.enabled,
        obscureText: setObscureText,
        obscuringCharacter: '*',
        validator: widget.validator,
        keyboardType: widget.keyboardType,
        textCapitalization: (widget.isCaps!=null && widget.isCaps==true)?TextCapitalization.characters:TextCapitalization.none,
        onChanged: (value) {
          if (value.length == 0 && widget.isObscured!) {
            setState(() {
              setObscureText=false;
            });
          }
          if(widget.isCaps!=null && widget.isCaps==true){
            widget.controller?.value = TextEditingValue(
                text: value.toUpperCase(),
                selection: widget.controller!.selection
            );
          }
        },
        decoration: InputDecoration(
          hintText: widget.hintText,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
            borderRadius: BorderRadius.circular(widget.radius!),
            gapPadding: 0.5,
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red),
            borderRadius: BorderRadius.circular(widget.radius!),
            gapPadding: 0.5,
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red),
            borderRadius: BorderRadius.circular(widget.radius!),
            gapPadding: 0.5,
          ),
          errorStyle: TextStyle(
            height: 0.09,
          ),
          disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
            borderRadius: BorderRadius.circular(widget.radius!),
            gapPadding: 0.5,
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
            borderRadius: BorderRadius.circular(widget.radius!),
            gapPadding: 0.5,
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 15),
          hintStyle: TextStyle(
            fontSize: 12,
          ),
        ),

        onFieldSubmitted: (value) {
          // CommonUtils.fieldFocusChanged(
          //     widget.context, widget.currentFocusNode!, widget.nextFocusNode!);
          widget.currentFocusNode?.unfocus();
          if (widget.nextFocusNode != null)
            FocusScope.of(context).requestFocus(widget.nextFocusNode);
          if (widget.isObscured!) {
            setState(() {
              setObscureText=true;
            });
          }
        },
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.normal,
          color: Colors.black,
        ),
      ),
    );
  }
}

class CustomFieldSizedBox extends StatefulWidget {
  final FocusNode? currentFocusNode;
  final FocusNode? nextFocusNode;
  final String hintText;
  final bool enabled;
  final double? radius;
  final FormFieldValidator<String>? validator;
  final TextInputType keyboardType;

  const CustomFieldSizedBox({
    this.currentFocusNode,
    this.nextFocusNode,
    required this.hintText,
    this.enabled = true,
    this.radius,
    this.validator,
    this.keyboardType = TextInputType.text,
  });

  @override
  _CustomFieldSizedBoxState createState() => _CustomFieldSizedBoxState();
}

class _CustomFieldSizedBoxState extends State<CustomFieldSizedBox> {
  bool _showValidationError = false;
  String? _errorMessage;
  late TextEditingController _textEditingController;
  late FocusNode _currentFocusNode;

  @override
  void initState() {
    super.initState();
    _currentFocusNode = widget.currentFocusNode ?? FocusNode();
    _textEditingController = TextEditingController();
    _currentFocusNode.addListener((_validateTextField));
  }

  @override
  void dispose() {
    _currentFocusNode.removeListener(_validateTextField);
    _currentFocusNode.dispose();
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 35,
          child: TextFormField(
            controller: _textEditingController,
            focusNode: _currentFocusNode,
            keyboardType: widget.keyboardType,
            decoration: InputDecoration(
              hintText: widget.hintText,
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
                borderRadius: BorderRadius.circular(widget.radius ?? 0.0),
                gapPadding: 0.5,
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
                borderRadius: BorderRadius.circular(widget.radius ?? 0.0),
                gapPadding: 0.5,
              ),
              contentPadding: EdgeInsets.symmetric(horizontal: 15),
              hintStyle: TextStyle(
                fontSize: 14,
              ),
            ),
            onChanged: (value) {
              setState(() {
                _showValidationError = false;
                _errorMessage = widget.validator?.call(value);
              });
            },
            onFieldSubmitted: (value) {
              if (widget.nextFocusNode != null) {
                FocusScope.of(context).requestFocus(widget.nextFocusNode);
              } else {
                _currentFocusNode.unfocus();
              }
            },
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.normal,
              color: Colors.black,
            ),
          ),
        ),
        if (_showValidationError && _errorMessage != null)
          Padding(
            padding: EdgeInsets.only(left: 8.0, top: 4.0),
            child: Text(
              _errorMessage!,
              style: TextStyle(
                color: Colors.red,
                fontSize: 12,
              ),
            ),
          ),
      ],
    );
  }

  void _validateTextField() {
    if (widget.validator != null) {
      setState(() {
        _showValidationError = true;
        _errorMessage = widget.validator!(_textEditingController.text);
      });
    }
  }
}

//Custom Dropdown menu
class CustomDropdownFormField extends StatefulWidget {
  final String? hint;
  final String? value;
  final List<String>? items;
  final ValueChanged<String?>? onChanged;
  final String errorText;
  final bool isValidate;

  const CustomDropdownFormField({
    Key? key,
    this.hint,
    this.value,
    this.items,
    this.onChanged,
    required this.errorText,
    required this.isValidate,
  }) : super(key: key);

  @override
  _CustomDropdownFormFieldState createState() =>
      _CustomDropdownFormFieldState();
}

class _CustomDropdownFormFieldState extends State<CustomDropdownFormField> {
  String? selectedValue;

  @override
  void initState() {
    super.initState();
    selectedValue = widget.value;
  }

  @override
  void didUpdateWidget(covariant CustomDropdownFormField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value != selectedValue) {
      // Update the selected value if it has changed
      selectedValue = widget.value;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: DropdownButtonFormField(
        isExpanded: true,
        hint: Text(
          widget.hint ?? '',
          overflow: TextOverflow.ellipsis,
        ),
        value: selectedValue,
        validator: (value) =>
            (value == null && widget.isValidate) ? widget.errorText : null,
        icon: const Icon(Icons.arrow_drop_down),
        items: widget.items?.map<DropdownMenuItem<String>>((String value) {
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
        }).toList(),
        onChanged: (String? value) {
          setState(() {
            selectedValue = value;
          });
          if (widget.onChanged != null) {
            widget.onChanged!(value);
          }
        },
      ),
    );
  }
}

//Stateful Text widget for Preview Text Fields

class PreviewTextField extends StatefulWidget {
  final double fontSize;
  final FontWeight fontWeight;
  final Color titleTextColor;
  final Color fieldTextColor;
  final String titleText;
  final String fieldText;

  PreviewTextField({
    required this.fontSize,
    required this.fontWeight,
    required this.titleTextColor,
    required this.fieldTextColor,
    required this.titleText,
    required this.fieldText,
  });

  @override
  _PreviewTextFieldState createState() => _PreviewTextFieldState();
}

class _PreviewTextFieldState extends State<PreviewTextField> {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.only(top: 10, bottom: 2),
        child: RichText(
            text: TextSpan(
          text: '${widget.titleText}: ',
          style: TextStyle(
            fontSize: widget.fontSize,
            fontWeight: widget.fontWeight,
            color: widget.titleTextColor,
          ),
          children: [
            TextSpan(
                text: '${widget.fieldText}',
                style: TextStyle(
                  fontSize: widget.fontSize,
                  fontWeight: widget.fontWeight,
                  color: widget.fieldTextColor,
                )),
          ],
        )),
      ),
    );
  }
}




//Stateful CardChip account clickable widget

class CustomCardChip extends StatefulWidget {
  final String text;
  final ImageProvider image;
  final VoidCallback onTap;

  CustomCardChip({required this.text, required this.image, required this.onTap});

  @override
  _CustomCardChipState createState() => _CustomCardChipState();
}

class _CustomCardChipState extends State<CustomCardChip> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
        elevation: 10,
        child: Container(
          width: 85,
          height: 40,
          padding: EdgeInsets.all(2),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                width: 24,
                height: 24,
                child: Image(
                  image: widget.image,
                ),
              ),
              Text(
                widget.text,
                style: TextStyle(
                  fontSize: 9,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                textAlign: TextAlign.left,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// home screen custom card container

class CustomCardContainer extends StatefulWidget {
  final nameImage;
  final String title;
  final String description;
  final VoidCallback onPressed;


  const CustomCardContainer({
    Key? key,
    required this.nameImage,
    required this.title,
    required this.description,
    required this.onPressed,

  }) : super(key: key);

  @override
  State<CustomCardContainer> createState() => _CustomCardContainerState();
}

class _CustomCardContainerState extends State<CustomCardContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 16,right: 16,bottom: 16),
      height: 140,
      // width: 1000,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        color: Colors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image(
              image: AssetImage('assets/images/'+widget.nameImage),
              height: 120,
              width: 120,
            ),
          ),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 8.0,left: 8.0),
                  child: Text(
                    widget.title,
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0,right: 8.0),
                  child: Text(
                    widget.description,
                    maxLines: 2,
                    softWrap: true,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                      color: Colors.black,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 8.0, right: 8.0),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(ColorPalette.bottomIconSelectedColor),
                      minimumSize: MaterialStateProperty.all(Size(10,30)),
                      elevation: MaterialStateProperty.all(4),
                      shadowColor: MaterialStateProperty.all(Colors.white),

                    ),

                    child: const Text(
                      'Apply Now',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed:widget.onPressed,

                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class AmountChipWidget extends StatefulWidget {
  final String text;
  final double width;
  final double height;
  final TextEditingController controller;

  const AmountChipWidget({
    Key? key,
    required this.text,
    required this.controller,
    this.width = 80.0,
    this.height = 30.0,

  }) : super(key: key);
  @override
  State<AmountChipWidget> createState() => _AmountChipWidgetState();
}

class _AmountChipWidgetState extends State<AmountChipWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        print(widget.text);
        setState(() {
          widget.controller.text=widget.text.substring(2);
        });
      },
      child: Container(
        margin: EdgeInsets.only(top: 12, right: 8),
        width: widget.width,
        height: widget.height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4.0),
          border: Border.all(
            color: Colors.black,
            width: 1.0,
          ),
        ),
        padding: EdgeInsets.symmetric(horizontal: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              widget.text,
              style: TextStyle(
                fontFamily: 'rupee_ford',
                fontSize: 12.0,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// custom card chip for surge module ke investmentAmountPage

class InvestAmountChipWidget extends StatefulWidget {
  final String text;
  final double width;
  final double height;
  final TextEditingController controller;

  const InvestAmountChipWidget({
    Key? key,
    required this.text,
    required this.controller,
    this.width = 80.0,
    this.height = 30.0,
  }) : super(key: key);

  @override
  State<InvestAmountChipWidget> createState() => _InvestAmountChipWidgetState();
}

class _InvestAmountChipWidgetState extends State<InvestAmountChipWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        print(widget.text);
        setState(() {
          widget.controller.text = widget.text;
        });
      },
      child: Container(
        margin: EdgeInsets.only(top: 12, right: 8),
        width: widget.width,
        height: widget.height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4.0),
          border: Border.all(
            color: Colors.black,
            width: 1.0,
          ),
        ),
        padding: EdgeInsets.symmetric(horizontal: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              widget.text,
              style: TextStyle(
                fontFamily: 'rupee_ford',
                fontSize: 12.0,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// in dashboard custom container

class CustomSizeBox extends StatefulWidget {
  final double amount;
  final String text;
  final Color color;

  const CustomSizeBox(
      {required this.color, required this.amount, required this.text});

  @override
  State<CustomSizeBox> createState() => _CustomSizeBoxState();
}

class _CustomSizeBoxState extends State<CustomSizeBox> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 110,
      height: 80,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: widget!.color,
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                textAlign: TextAlign.center,
                widget.amount.toString(),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 16.0, // Adjust as needed
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child: Text(
                textAlign: TextAlign.center,
                widget.text,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 12.0, // Adjust as needed
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
