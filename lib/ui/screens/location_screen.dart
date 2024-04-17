import 'package:flutter/material.dart';
import 'package:food_delivery_app/resources/color_resources.dart';
import 'package:food_delivery_app/resources/font_resources.dart';
import 'package:food_delivery_app/resources/string_resources.dart';
import 'package:food_delivery_app/widgets/custom_widgets.dart';
import 'package:geolocator/geolocator.dart';
import 'package:progress_dialog/progress_dialog.dart';

import 'choose_location_screen.dart';
import 'home_screen.dart';

class LocationScreen extends StatefulWidget {
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {

  //region check permission function
  Future checkPermission(ProgressDialog pr, BuildContext context) async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied || permission == LocationPermission.deniedForever) {
      LocationPermission permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied || permission == LocationPermission.deniedForever){
        await pr.hide();
        return;
      }
      else{
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) => ChooseLocationScreen()));
      }
    }
    else{
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (BuildContext context) => ChooseLocationScreen()));
    }
  }
  //endregion

  //region location functions
  Future getCurrentLocation(ProgressDialog pr, BuildContext context) async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied || permission == LocationPermission.deniedForever) {
      LocationPermission permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied || permission == LocationPermission.deniedForever){
        await pr.hide();
        return;
      }
      else{
        getLocation(pr, context);
      }
    }
    else{
      getLocation(pr, context);
    }
  }
  Future getLocation(ProgressDialog pr, BuildContext context) async {
    await pr.show();
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    await pr.hide();
    print(position);
    Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (BuildContext context) => HomeScreen()));
  }
  //endregion

  @override
  Widget build(BuildContext context) {
    final ProgressDialog pr = ProgressDialog(context,type: ProgressDialogType.Normal, isDismissible: false, showLogs: false);
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        brightness: Brightness.light,
        title: Text(''),
        backgroundColor: ColorResources.whiteColor,
      ),
      backgroundColor: ColorResources.whiteColor,
      body: SafeArea(
        child: Center(
          child: SizedBox(
            width: double.infinity,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: Image.asset('asset/images/current_location_image.png', width: MediaQuery.of(context).size.width, height: MediaQuery.of(context).size.height * 0.5, fit: BoxFit.contain,),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 40.0),
                    child: Text(
                      StringResources.location,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        color: ColorResources.darkGreyColor,
                        fontFamily: FontResources.regular,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 40.0),
                    child: DefaultButton(
                      text: StringResources.okLocation,
                      onPress: () {
                        getCurrentLocation(pr, context);
                      },
                    ),
                  ),
                  TextButton(
                    style: ButtonStyle(
                      overlayColor: MaterialStateProperty.all(ColorResources.lightGreyColor),
                    ),
                    onPressed: () {
                      checkPermission(pr, context);
                    },
                    child: textRegular(StringResources.otherLocation, TextAlign.center)
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
