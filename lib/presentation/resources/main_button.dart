
import 'package:flutter/material.dart';
import 'package:phillips_smart_charger/presentation/resources/values_manager.dart';
import 'package:sizer/sizer.dart';

class MainBlackTextButton extends StatelessWidget {
  String textButton;
  Color newColorForButton;
  Color textColorForButton;

  MainBlackTextButton({super.key, required this.textButton,required this.newColorForButton,required this.textColorForButton});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top:AppSize.s8,left:AppSize.s8,right: AppSize.s8 ),
      child: ElevatedButton(
        onPressed: () {
          // Add your onPressed callback here
        },
        style: ButtonStyle(
          minimumSize: MaterialStateProperty.all( Size(double.infinity, 7.h)),
          backgroundColor: MaterialStateProperty.all(newColorForButton),
          foregroundColor: MaterialStateProperty.all(Colors.white),
        ),
        child: Text(textButton,style: const TextStyle(color: Colors.black,fontSize: AppSize.s16,fontWeight: FontWeight.bold),),
      ),
    );
  }
}

class MainWhiteTextButton extends StatelessWidget {
  final String textButton;
  final Color newColorForButton;
  final VoidCallback onPressed;

  MainWhiteTextButton({
    super.key,
    required this.textButton,
    required this.newColorForButton,
    required this.onPressed
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top:AppSize.s8,left:AppSize.s8,right: AppSize.s8 ),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.white,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
        child: ElevatedButton(
          onPressed: onPressed,
          style: ButtonStyle(
            minimumSize: MaterialStateProperty.all( Size(double.infinity, 7.h)),
            backgroundColor: MaterialStateProperty.all(newColorForButton),
            foregroundColor: MaterialStateProperty.all(Colors.white),
          ),
          child: Text(textButton,style: const TextStyle(color: Colors.white,fontSize: AppSize.s16,fontWeight: FontWeight.bold),),
        ),
      ),
    );
  }
}