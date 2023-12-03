import 'package:flutter/material.dart';

class AppColors {
  static const appButton = Color(0xFF44fb46);
  static const textFieldLabelColor = Color(0xFF344054);
  static const grey100 = Color(0xFFF2F4F7);
  static const grey300 = Color(0xFFD0D5DD);
  static const grey400 = Color(0xFF98A2B3);
  static const error500 = Color(0xFFF04438);
  static const success500 = Color(0xFF12B76A);

  static Color fromHex(String? hexString) {
    if (hexString == null) return Colors.black;
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}
