import 'package:flutter/material.dart';

class CattleRichText extends StatelessWidget {
  const CattleRichText({
    Key? key,
    required this.text,
    this.fontSize = 18,
    this.color = Colors.black,
    this.fontWeight = FontWeight.normal,
    required this.richText,
    this.fontSize1 = 18,
    this.color1 = Colors.black,
    this.fontWeight1 = FontWeight.normal,
  }) : super(key: key);

  final String text;
  final String richText;
  final double fontSize;
  final double fontSize1;
  final Color color;
  final Color color1;
  final FontWeight fontWeight;
  final FontWeight fontWeight1;
  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: text,
        style: TextStyle(
          fontSize: fontSize1,
          color: color,
          fontWeight: fontWeight1,
        ),
        children: [
          TextSpan(
            text: richText,
            style: TextStyle(
              fontSize: fontSize,
              color: color1,
              fontWeight: fontWeight,
            ),
          ),
        ],
      ),
    );
  }
}
