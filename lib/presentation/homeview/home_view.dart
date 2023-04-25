import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:phillips_smart_charger/presentation/configuration_page/configuration_page.dart';
import 'package:phillips_smart_charger/presentation/resources/color_manager.dart';
import 'package:phillips_smart_charger/presentation/resources/values_manager.dart';
import 'package:sizer/sizer.dart';

import '../resources/app_background.dart';
import '../resources/main_button.dart';


class HomeView extends StatefulWidget {
  final String deviceName;
   late String idNumber;
   double voltage=12.0;
   HomeView({Key? key, required this.deviceName, required this.idNumber})
      : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {

  late TextEditingController _idNumberController;

  get voltage => widget.voltage;
  @override
  void initState() {
    super.initState();
    _idNumberController = TextEditingController(text: widget.idNumber);
  }

  @override
  void dispose() {
    super.dispose();
    _idNumberController.dispose();
  }

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
                child: IconButton(
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ),
            SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [

                  const SizedBox(
                    height: AppSize.s1_5,
                  ),
                  Text('Trailer ID:',
                      style: TextStyle(
                          fontSize: AppSize.s18,
                          color: ColorManager.white,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center),
                  const SizedBox(
                    height: AppSize.s4,
                  ),
                  Text(widget.idNumber,
                      style: const TextStyle(
                          fontSize: AppSize.s14, color: Color(0xffdadaef)),
                      textAlign: TextAlign.center),
                  const SizedBox(
                    height: AppSize.s8,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Colors.blue,Colors.white],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter
                        ),
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16.0)),
                      height: 45.h,
                      width: 80.w,

                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [

                          MainBlackTextButton(textButton: 'Battery Voltage',newColorForButton: Colors.lightGreenAccent, textColorForButton: Colors.black,),
                          MainBlackTextButton(textButton: 'Charger Health',newColorForButton: Colors.lightGreenAccent,textColorForButton: Colors.black,),
                          MainBlackTextButton(textButton: 'Battery Health', newColorForButton: Colors.lightGreenAccent,textColorForButton: Colors.black,),
                          MainBlackTextButton(textButton: 'Lift-gate Cycle Count       425', newColorForButton: Colors.lightGreenAccent,textColorForButton: Colors.black,),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: AppSize.s16,
                  ),
                  MainWhiteTextButton(textButton: 'Energy Usage',  newColorForButton: Colors.transparent, onPressed: (){},),
                  MainWhiteTextButton(textButton: 'Configuration',  newColorForButton: Colors.transparent,onPressed: (){
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context)=>ConfigurationPage(deviceName: widget.deviceName, deviceId: widget.idNumber,)));
                  },),
                  MainWhiteTextButton(textButton: 'View Raw Data',  newColorForButton: Colors.transparent,onPressed: (){}),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

