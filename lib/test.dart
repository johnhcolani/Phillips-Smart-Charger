
import 'package:flutter/material.dart';
import 'package:phillips_smart_charger/app/app.dart';

class Test extends StatelessWidget {
  const Test({Key? key}) : super(key: key);

void updateAppState(){
  MyApp.instance.appState = 10;
}
void getAppState(){
  print('MY APP INSTANCE IS ${MyApp.instance.appState}');
}
  @override
  Widget build(BuildContext context) {

    return Container();
  }
}
