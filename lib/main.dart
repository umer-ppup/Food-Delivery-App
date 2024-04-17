import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:food_delivery_app/resources/color_resources.dart';
import 'package:food_delivery_app/ui/splash/splash_screen.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    // navigation bar color
    statusBarColor: ColorResources.whiteColor,
    statusBarIconBrightness: Brightness.dark,
    statusBarBrightness: Brightness.dark, // status bar color
  ));
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: SplashScreen(),
  ));
}