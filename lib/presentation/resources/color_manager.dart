
import 'package:flutter/material.dart';

class ColorManager{
  static Color panDarkBlue= HexColor.fromHex('#002F6C') ;
  static Color panDarkBlueOpacity30= HexColor.fromHex('#4D002F6C') ;
  static Color panDarkBlueOpacity10= HexColor.fromHex('#1A002F6C') ;
  static Color panLightBlue = HexColor.fromHex('#009CDE') ;
  static Color panSLightBlue = HexColor.fromHex('#8fb9cb') ;
  static Color panGery = HexColor.fromHex('#A2AAAD') ;
  static Color panBlackC = HexColor.fromHex('#000000') ;
  static Color panCoolGrey = HexColor.fromHex('#53565A') ;
  static Color panCorporate = HexColor.fromHex('#0076A8') ;
  static Color panOEM = HexColor.fromHex('#009A44') ;
  static Color white = HexColor.fromHex("#FFFFFF");
  static Color whiteOpacity70 = HexColor.fromHex("#B3FFFFFF");
  static Color whiteOpacity50 = HexColor.fromHex("#80FFFFFF");
  static Color whiteOpacity30 = HexColor.fromHex("#4DFFFFFF");
  static Color whiteOpacity10 = HexColor.fromHex("#1AFFFFFF");

  static Color panEurope = HexColor.fromHex('#AB2328') ;
  static Color panMotorSport = HexColor.fromHex('#009CDE') ;
  static Color panAfterMarket = HexColor.fromHex('#E87722') ;
  static Color panConnect = HexColor.fromHex('#002F6C') ;
  static Color panAsiaPacific = HexColor.fromHex('#8C4799') ;
  static Color primaryOpacity70 = HexColor.fromHex("#B3ED9728");
  static Color error = HexColor.fromHex('#e61f34'); // red color
}

extension HexColor on Color {
  static Color fromHex(String hexColorString){
    hexColorString = hexColorString.replaceAll('#', '');
    if(hexColorString.length==6){
      hexColorString='FF'+ hexColorString;
    }
    return Color(int.parse(hexColorString,radix: 16));
  }
}