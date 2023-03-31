import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../resources/app_background.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
      AppBar(),
      body: const Center(
        child: Text('Main Page'),
      ),
    );
  }
}
