import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:food_delivery_app/resources/color_resources.dart';
import 'package:food_delivery_app/resources/string_resources.dart';
import 'package:food_delivery_app/resources/font_resources.dart';
import 'package:food_delivery_app/ui/screens/location_screen.dart';
import 'package:food_delivery_app/ui/screens/tutorial_screen.dart';
import 'package:food_delivery_app/util/util.dart';
import 'package:food_delivery_app/widgets/custom_widgets.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorResources.whiteColor,
      body: Column(
        children: [
          Expanded(
            flex: 3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  StringResources.splashMiddleText,
                  style: TextStyle(
                    fontSize: 28,
                    color: ColorResources.darkGreyColor,
                    fontFamily: FontResources.splashFont2,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                //region spinner to indication loading
                SpinKitChasingDots(
                  itemBuilder: (BuildContext context, int index) {
                    return DecoratedBox(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50.0),
                        color: index.isEven
                            ? ColorResources.lightGreyColor
                            : ColorResources.darkGreyColor,
                      ),
                    );
                  },
                ),
                //endregion
              ],
            ),
          ),
          Expanded(
            flex: 0,
            child: Padding(
              padding: EdgeInsets.only(bottom: 20.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('asset/images/atrule_icon.png',
                      width: 50, height: 50),
                  textRegular(StringResources.companyName, TextAlign.start),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    Timer(Duration(seconds: 5), () {
      checkKey('login').then((value) => {
            if (value == false) {addBoolToSF('login', false)}
          });

      checkKey('tutorial').then((value) => {
        if (value == false) {
          Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (BuildContext context) => TutorialScreen()))
        }
        else{
          Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (BuildContext context) => LocationScreen()))
        }
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    SystemChrome.setEnabledSystemUIOverlays(
        [SystemUiOverlay.top, SystemUiOverlay.bottom]);
  }
}
