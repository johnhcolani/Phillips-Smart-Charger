
import 'package:flutter/material.dart';
import 'package:phillips_smart_charger/presentation/resources/route_manager.dart';
import 'package:sizer/sizer.dart';

import '../presentation/resources/theme_manager.dart';

class MyApp extends StatefulWidget {

  MyApp._internal();    /// private named constructor
  int appState = 0 ;
  static final MyApp instance = MyApp._internal();   /// single instance -- singleton
  factory MyApp() => instance;
  @override
  State<MyApp> createState() => _MyAppState();  /// factory for the class instance
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return Sizer(
        builder: (context, orientation, deviceType) {
          return MaterialApp(

            debugShowCheckedModeBanner: false,
            onGenerateRoute: RouteGenerator.getRoute,
            initialRoute: Routes.splashRoute,
            theme: getApplicationTheme(),
          );
        });
  }
}
