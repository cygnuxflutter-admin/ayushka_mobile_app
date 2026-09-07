import 'dart:ui';
import 'package:flutter/material.dart';

class ColorConstant {
  static Color deepPurple700 = fromHex('#583c92');

  static Color indigo20001 = fromHex('#81a8e0');

  static Color gray4004c = fromHex('#4cc6c6c6');

  static Color black9003f = fromHex('#3f000000');

  static Color deepPurple300 = fromHex('#9f81e0');

  static Color black90066 = fromHex('#66000000');

  static Color black90000 = fromHex('#00000000');

  static Color black900 = fromHex('#000000');

  static Color deepOrange200 = fromHex('#ffc49c');

  static Color blueGray900 = fromHex('#232f34');

  static Color gray700 = fromHex('#666666');

  static Color gray500 = fromHex('#91979a');

  static Color blue700 = fromHex('#2973d9');

  static Color blueGray400 = fromHex('#888888');

  static Color redA200 = fromHex('#ff4d4d');

  static Color green600B2 = fromHex('#b232b832');

  static Color blueGray9007f = fromHex('#7f232f34');

  static Color gray300 = fromHex('#dbdbdb');

  static Color orange300 = fromHex('#ffaf4d');

  static Color blue50 = fromHex('#e6f1f7');

  static Color blueGray4007f = fromHex('#7f8b8b8b');

  static Color indigo200 = fromHex('#80a7e0');

  static Color indigoA700 = fromHex('#4542e1');

  static Color blueGray90033 = fromHex('#33232f34');

  static Color whiteA700 = fromHex('#ffffff');

  static Color redA700 = fromHex('#FF0000');

  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}
