import 'package:flutter/material.dart';
import 'package:food_delivery_app/resources/color_resources.dart';
import 'package:food_delivery_app/resources/font_resources.dart';
import 'package:food_delivery_app/resources/image_resources.dart';
import 'package:food_delivery_app/ui/forms/SignUpForm.dart';
import 'package:food_delivery_app/ui/screens/login_screen.dart';
import 'package:food_delivery_app/widgets/custom_widgets.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: ColorResources.darkGreyColor),
          brightness: Brightness.light,
          elevation: 0.0,
          backgroundColor: Colors.white,
          centerTitle: true,
          title: Text(
            'Sign Up',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 22,
              color: ColorResources.darkGreyColor,
              fontFamily: FontResources.bold,
            ),
          ),
        ),
        backgroundColor: ColorResources.whiteColor,
        body: SafeArea(
            child: Center(
              child: SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: SingleChildScrollView(
                    child: Column(children: [
                      SignUpForm(),
                      SizedBox(height: 50),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Have an account?",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16,
                              color: ColorResources.darkGreyColor,
                              fontFamily: FontResources.regular,
                            ),
                          ),
                          SizedBox(width: 10),
                          TextButton(
                            onPressed: (){
                              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => LoginScreen()));
                            },
                            style: ButtonStyle(
                              overlayColor: MaterialStateProperty.all(ColorResources.lightGreyColor),
                            ),
                            child: Text(
                              "Login",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 16,
                                color: ColorResources.darkGreyColor,
                                fontFamily: FontResources.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 30),
                      OrDivider(),
                      //region social icons
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SocialCardWidget(
                            icon: ImageResources.facebookIcon,
                          ),
                          SocialCardWidget(
                            icon: ImageResources.googleIcon,
                          ),
                          SocialCardWidget(
                            icon: ImageResources.twitterIcon,
                          )
                        ],
                      ),
                      //endregion
                      SizedBox(height: 20),
                    ]),
                  ),
                ),
              ),
            )),
      ),
    );
  }
}
