import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';
import '../resources/app_background.dart';
import '../resources/color_manager.dart';
import '../resources/main_button.dart';
import '../resources/values_manager.dart';

class TrailerIdPage extends StatefulWidget {
  String deviceName;
  String deviceId;
  TrailerIdPage({super.key, required this.deviceName, required this.deviceId});
  @override
  _TrailerIdPageState createState() => _TrailerIdPageState();
}

class _TrailerIdPageState extends State<TrailerIdPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: Stack(
          children: [
            const AppBackground(),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: EdgeInsets.only(top: 5.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    Text(
                      'Trailer ID',
                      style: TextStyle(
                          fontSize: AppSize.s24, color: ColorManager.white),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.info,
                        color: ColorManager.panDarkBlue,
                        size: AppSize.s32,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              ),
            ),
            SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 30.h,
                    width: double.infinity,
padding: const EdgeInsets.only(left: AppSize.s48,right:AppSize.s48 ),
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [
                          ColorManager.panDarkBlue,
                          ColorManager.whiteOpacity50,
                          ColorManager.whiteOpacity50,
                          ColorManager.whiteOpacity50,
                          ColorManager.whiteOpacity50,
                          ColorManager.panDarkBlue,
                        ],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [

                        Container(

                          height: AppSize.s48,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8)),
                            border: Border.all(width: AppSize.s1_5,color: Colors.white)
                          ),
                          child: Center(child: Text(widget.deviceId,style: TextStyle(
                            color:ColorManager.panDarkBlue,fontSize: AppSize.s20
                          ),)),
                        ),
                        const SizedBox(height: AppSize.s24,),
                        Padding(
                          padding: const EdgeInsets.only(right: AppSize.s32,left:AppSize.s32 ),
                          child: MainWhiteTextButton(
                            textButton: 'Confirm QR-Code',
                            newColorForButton: ColorManager.panDarkBlue,
                            onPressed: () {  },

                          ),
                        ),
                      ],
                    )
                  ),
                  const SizedBox(
                    height: AppSize.s65,
                  ),

                  Container(
                    height: 25.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [
                          ColorManager.panDarkBlue,
                          ColorManager.whiteOpacity50,
                          ColorManager.whiteOpacity50,
                          ColorManager.whiteOpacity50,
                          ColorManager.whiteOpacity50,
                          ColorManager.panDarkBlue,
                        ],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: AppPadding.p40,right:AppPadding.p40 ),
                          child: MainWhiteTextButton(
                              textButton: '',
                              newColorForButton: Colors.transparent,
                              onPressed: () {}),
                        ),
                        const SizedBox(
                          height: AppSize.s8,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: AppPadding.p40,right:AppPadding.p40 ),
                          child: MainWhiteTextButton(
                              textButton: 'Confirm',
                              newColorForButton: Colors.transparent,
                              onPressed: () {}),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
