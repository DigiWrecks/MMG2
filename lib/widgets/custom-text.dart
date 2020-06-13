import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {

  final String text;
  final double size;
  final Color color;
  final TextAlign align;
  final bool isBold;
  final bool isUnderlined;

  const CustomText({Key key, this.text, this.size, this.color=Colors.white, this.align=TextAlign.start, this.isBold=true, this.isUnderlined=false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: align,
      style: TextStyle(
          color: color,
          fontWeight: isBold?FontWeight.bold:FontWeight.normal,
          fontSize: size,
        decoration: isUnderlined?TextDecoration.underline:TextDecoration.none
      ),



    );
  }
}