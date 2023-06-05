
import 'package:flutter/material.dart';
import 'package:phillips_smart_charger/presentation/resources/color_manager.dart';
import 'package:phillips_smart_charger/presentation/resources/style_manager.dart';
import 'package:phillips_smart_charger/presentation/resources/values_manager.dart';

import 'font_manager.dart';

ThemeData getApplicationTheme(){
  return ThemeData(
    // main colors of the app
      primaryColor: ColorManager.panDarkBlue,
      primaryColorLight: ColorManager.panLightBlue,
      primaryColorDark: ColorManager.panCoolGrey,
      disabledColor: ColorManager.panGery,
      // ripple color
      splashColor: ColorManager.primaryOpacity70,
      // will be used incase of disabled button for example
      //accentColor: ColorManager.panGery,
      // card view theme
      cardTheme: CardTheme(
          color: ColorManager.white,
          shadowColor: ColorManager.panCoolGrey,
          elevation: AppSize.s4),
      // App bar theme
      appBarTheme: AppBarTheme(
          centerTitle: true,
          color: ColorManager.panDarkBlue,
          elevation: AppSize.s4,
          shadowColor: ColorManager.primaryOpacity70,
          titleTextStyle: getRegularStyle(
              color: ColorManager.white, fontSize: FontSize.s16)),
      // Button theme
      buttonTheme: ButtonThemeData(
          shape: const StadiumBorder(),
          disabledColor: ColorManager.panGery,
          buttonColor: ColorManager.panDarkBlue,
          splashColor: ColorManager.primaryOpacity70),

      // elevated button theme
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              textStyle: getRegularStyle(color: ColorManager.white),
              primary: ColorManager.panDarkBlue,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppSize.s12)))),

      // Text theme
      textTheme: TextTheme(

          headline1: getSemiBoldStyle(
              color: ColorManager.panCoolGrey, fontSize: FontSize.s16),
          headline2: getRegularStyle(
              color: ColorManager.white, fontSize: FontSize.s16),
          headline3:
          getBoldStyle(color: ColorManager.panDarkBlue, fontSize: FontSize.s16),
          headline4: getRegularStyle(
              color: ColorManager.panDarkBlue, fontSize: FontSize.s14),
          subtitle1: getMediumStyle(
              color: ColorManager.panLightBlue, fontSize: FontSize.s14),
          subtitle2: getMediumStyle(
              color: ColorManager.panDarkBlue, fontSize: FontSize.s14),
          bodyText2: getMediumStyle(color: ColorManager.panLightBlue),
          caption: getRegularStyle(color: ColorManager.panGery),
          bodyText1: getRegularStyle(color: ColorManager.panGery)),
      // input decoration theme (text form field)

      inputDecorationTheme: InputDecorationTheme(
        contentPadding: const EdgeInsets.all(AppPadding.p8),
        // hint style
        hintStyle: getRegularStyle(color: ColorManager.panGery),

        // label style
        labelStyle: getMediumStyle(color: ColorManager.panCoolGrey),
        // error style
        errorStyle: getRegularStyle(color: ColorManager.error),

        // enabled border
        enabledBorder: OutlineInputBorder(
            borderSide:
            BorderSide(color: ColorManager.panGery, width: AppSize.s1_5),
            borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8))),

        // focused border
        focusedBorder: OutlineInputBorder(
            borderSide:
            BorderSide(color: ColorManager.panDarkBlue, width: AppSize.s1_5),
            borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8))),

        // error border
        errorBorder: OutlineInputBorder(
            borderSide:
            BorderSide(color: ColorManager.error, width: AppSize.s1_5),
            borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8))),
        // focused error border
        focusedErrorBorder: OutlineInputBorder(
            borderSide:
            BorderSide(color: ColorManager.panDarkBlue, width: AppSize.s1_5),
            borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8))),
      ));
}
