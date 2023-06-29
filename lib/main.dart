import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motivation_app/screen/home_screen.dart';

void main() {
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
        fontFamily: 'The Jamsil',
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        fontFamily: 'The Jamsil',
      ),
      home: HomeScreen(),
    ),
  );
}
