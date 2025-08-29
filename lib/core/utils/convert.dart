import 'dart:ui';

class Convert{

  static Color? getColorFromHex(String? hexColor) {
    if(hexColor==null) return null;

    hexColor = hexColor.replaceAll('#', '');
    return Color(int.parse('0xFF$hexColor'));
  }

}