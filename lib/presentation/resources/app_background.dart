import 'package:flutter/material.dart';
import 'package:phillips_smart_charger/presentation/resources/color_manager.dart';
import 'dart:math' as math;


class AppBackground extends StatefulWidget {
  const AppBackground({Key? key}) : super(key: key);

  @override
  State<AppBackground> createState() => _AppBackgroundState();
}

class _AppBackgroundState extends State<AppBackground> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children:[
        Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [ColorManager.panDarkBlue, ColorManager.panCorporate]),
          ),
        ),
        Transform.translate(
          
          offset: Offset(0,220),
          child: Opacity(
            opacity: 0.15,
            child:Image.asset('assets/images/smartchargerpic.png',
            fit: BoxFit.contain,
            width: double.infinity,
            height: double.infinity,),
          ),
        )
      ]
    );
  }
}
