import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:food_delivery_app/models/user_model.dart';
import 'package:food_delivery_app/resources/color_resources.dart';
import 'package:food_delivery_app/resources/string_resources.dart';
import 'package:food_delivery_app/util/util.dart';
import 'package:food_delivery_app/widgets/custom_widgets.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Storage storage = new Storage();
  User user = new User();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    storage.readData().then((value) async {
      if(value != ""){
        setState(() {
          user = User.fromJson(json.decode(value));
        });
      }
      else{
        user.id = "123";
        user.name = "ABC";
        user.email = "sample@email.com";
        user.phoneNumber = "Sample phone number";
        user.password = "";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorResources.whiteColor,
      appBar: AppBar(
        iconTheme: IconThemeData(color: ColorResources.darkGreyColor),
        brightness: Brightness.light,
        elevation: 0.0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            textRegular('Profile', TextAlign.start),
          ],
        ),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 20),
        child: Column(
          children: [
            //region profile header
            profileHeaderWidget(),
            //endregion

            SizedBox(height: 20),

            //region profile menu for different values
            profileMenuWidget(
              context,
              StringResources.userName,
              user.name != null ? user.name : "",
              Icons.person,
                  () => {},
            ),
            profileMenuWidget(
              context,
              StringResources.userEmail,
              user.email != null ? user.email : "",
              Icons.email_rounded,
                  () => {},
            ),
            profileMenuWidget(
              context,
              StringResources.userPhoneNumber,
              user.phoneNumber != null ? user.phoneNumber : "",
              Icons.phone,
                  () => {},
            )
            //endregion
          ],
        ),
      ),
    );
  }
}