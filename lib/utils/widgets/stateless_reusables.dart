import 'package:flutter/material.dart';

import '../../res/color_palette.dart';

class HeaderAlignText extends StatelessWidget {
  final String headerText;

  const HeaderAlignText({required this.headerText});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.only(top: 10, bottom: 2),
        child: Text(
          headerText,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.normal,
            color: ColorPalette.textColor,
          ),
        ),
      ),
    );
  }
}
