import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:phillips_smart_charger/presentation/resources/app_background.dart';
import 'package:phillips_smart_charger/presentation/resources/color_manager.dart';
import 'package:phillips_smart_charger/presentation/resources/main_button.dart';
import 'package:phillips_smart_charger/presentation/resources/values_manager.dart';
import 'package:phillips_smart_charger/presentation/trailer_id/trailer_id.dart';
import 'package:sizer/sizer.dart';

class ConfigurationPage extends StatefulWidget {
  String deviceName;
  String deviceId;
  ConfigurationPage(
      {super.key, required this.deviceName, required this.deviceId});
  @override
  _ConfigurationPageState createState() => _ConfigurationPageState();
}

class _ConfigurationPageState extends State<ConfigurationPage> {
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
                     Text('Configuration',style: TextStyle(
                      fontSize: AppSize.s24,color: ColorManager.white
                    ),),
                    IconButton(
                      icon: const Icon(
                        Icons.settings,
                        color: Colors.white,
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

                  MainWhiteTextButton(
                      textButton: 'Change Trailer ID',
                      newColorForButton: Colors.transparent,
                      onPressed: (){
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (BuildContext context)=>TrailerIdPage(deviceName: widget.deviceName, deviceId: widget.deviceId)));

                      }),
                  SizedBox(height: AppSize.s8,),
                  MainWhiteTextButton(
                      textButton: 'Reset (Battery Life)',
                      newColorForButton: Colors.transparent,
                      onPressed: (){}),
                  // const Center(
                  //   child: Text('This is the configuration page.'),
                  // ),
                  // Center(
                  //   child: Text(widget.deviceName),
                  // ),
                  // Center(
                  //   child: Text(widget.deviceId),
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
