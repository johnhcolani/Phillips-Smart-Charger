import 'dart:async';

import 'package:animated_widgets/widgets/scale_animated.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:phillips_smart_charger/presentation/resources/assets_manager.dart';
import 'package:phillips_smart_charger/presentation/resources/values_manager.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:sizer/sizer.dart';

import '../bluetoothpage/bluetoothPage.dart';
import '../resources/color_manager.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  final bool _enabled = true;
  Timer? _timer;
  _startDelay() {
    _timer = Timer(const Duration(seconds: 2), _goNext);
  }

  _goNext() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) =>  const BluetoothPage()));
    // '/MyApp'; (context) => const MyApp();
  }
  @override
  void initState() {
    _startDelay();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.panDarkBlue,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child:Shimmer(
        colorOpacity: 0.3,
        child: Center(
          child: ScaleAnimatedWidget.tween(
            enabled: _enabled,
            duration: const Duration(milliseconds: 600),
            scaleDisabled: 0.3,
            scaleEnabled: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children:  [
                const SizedBox(height: AppSize.s40,),
                Padding(
                  padding: const EdgeInsets.only(left:AppSize.s65,right:AppSize.s65),

                  child: Image.asset(ImageAssets.splashLogo,scale: 1.6),
                ),
                const SizedBox(height: AppSize.s40,),
                Text(
                  'Smart Charger',
                  style: TextStyle(
                      fontFamily: 'Trade_Gothic',
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 4.h),
                ),
                const SizedBox(height: AppSize.s40,),
                //Image.asset(ImageAssets.smartChargerLogo,scale: 1.6,),
                Image.asset(ImageAssets.mainPageLogo,scale: 1.8,),
                Padding(
                  padding: const EdgeInsets.only(left:AppSize.s24,right:AppSize.s24 ),
                  child: Image.asset(ImageAssets.smartChargerPic,scale: 1.2,),
                ),


              ],
            ),
          ),
        ),
      ),
    ));
  }
}
