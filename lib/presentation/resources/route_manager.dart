import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:phillips_smart_charger/presentation/onboarding/onboarding.dart';
import 'package:phillips_smart_charger/presentation/resources/string_manager.dart';
import 'package:phillips_smart_charger/presentation/splashView/splash_view.dart';
import '../homeview/home_view.dart';




class Routes{
  static const String splashRoute= "/";
  static const String onBordingRoute= "/onboarding";
  static const String homeRoute= "/home";
  // static const String splashRoute= "/";
  // static const String splashRoute= "/";
  // static const String splashRoute= "/";
}
class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings routeSettings){
    switch( routeSettings.name){
      case Routes.splashRoute:
        return MaterialPageRoute(builder: (_)=> const SplashView());
      case Routes.onBordingRoute:
        return MaterialPageRoute(builder: (_)=> const OnBoarding());
      case Routes.homeRoute:
        return MaterialPageRoute(builder: (_)=> const HomeView());
      default:
        return unDefinedRoute();
    }
  }
  static Route<dynamic> unDefinedRoute(){
    return MaterialPageRoute(builder: (_)=>
    Scaffold(
      appBar: AppBar(title: const Text(AppStrings.noRouteFound),),
      body:const Text(AppStrings.noRouteFound) ,
    )
    );

  }
}