import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:food_delivery_app/models/user_model.dart';
import 'package:food_delivery_app/resources/color_resources.dart';
import 'package:food_delivery_app/resources/string_resources.dart';
import 'package:food_delivery_app/util/util.dart';
import 'package:food_delivery_app/widgets/custom_widgets.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:fluttertoast/fluttertoast.dart';

// ignore: must_be_immutable
class SignUpForm extends StatefulWidget {
  Storage storage = new Storage();
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();


  //TextController to read text entered in text field
  TextEditingController cName = TextEditingController();
  TextEditingController cEmail = TextEditingController();
  TextEditingController cPhoneNumber = TextEditingController();
  TextEditingController cPassword = TextEditingController();
  TextEditingController cConfirmPassword = TextEditingController();

  FocusNode _nameFocusNode = FocusNode();
  FocusNode _emailFocusNode = FocusNode();
  FocusNode _phoneNumberFocusNode = FocusNode();
  FocusNode _passwordFocusNode = FocusNode();
  FocusNode _confirmPasswordFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    final ProgressDialog pr = ProgressDialog(context,type: ProgressDialogType.Normal, isDismissible: false, showLogs: false);
    return Form(
      key: _formKey,
      //autovalidate: true,
      child: Column(
        children: [
          SizedBox(height: 30),
          inputField(_nameFocusNode, cName, TextInputAction.next, TextInputType.name, StringResources.userName, Icons.person,
              'name', cPassword, context, _nameFocusNode, _emailFocusNode, _phoneNumberFocusNode, _passwordFocusNode, _confirmPasswordFocusNode),
          SizedBox(height: 30),
          inputField(_emailFocusNode, cEmail, TextInputAction.next, TextInputType.emailAddress, StringResources.userEmail, Icons.email_rounded,
              'email', cPassword, context, _nameFocusNode, _emailFocusNode, _phoneNumberFocusNode, _passwordFocusNode, _confirmPasswordFocusNode),
          SizedBox(height: 30),
          inputField(_phoneNumberFocusNode, cPhoneNumber, TextInputAction.next, TextInputType.phone, StringResources.userPhoneNumber, Icons.phone,
              'phone_number', cPassword, context, _nameFocusNode, _emailFocusNode, _phoneNumberFocusNode, _passwordFocusNode, _confirmPasswordFocusNode),
          SizedBox(height: 30),
          inputField(_passwordFocusNode, cPassword, TextInputAction.done, TextInputType.text, StringResources.userPassword, Icons.vpn_key_rounded,
              'password', cPassword, context, _nameFocusNode, _emailFocusNode, _phoneNumberFocusNode, _passwordFocusNode, _confirmPasswordFocusNode),
          SizedBox(height: 30),
          inputField(_confirmPasswordFocusNode, cConfirmPassword, TextInputAction.done, TextInputType.text, StringResources.userConfirmPassword, Icons.vpn_key_rounded,
              're-enter', cPassword, context, _nameFocusNode, _emailFocusNode, _phoneNumberFocusNode, _passwordFocusNode, _confirmPasswordFocusNode),
          SizedBox(height: 50),
          DefaultButton(
            text: 'Sign Up',
            onPress: () async {
              if (_formKey.currentState.validate()) {
                _formKey.currentState.save();
                await pr.show();
                widget.storage.readData().then((value) async {
                  if(value != ""){
                    User user = User.fromJson(json.decode(value));
                    if(user.email != StringResources.email){
                      User user = new User(
                          id: "user101",
                          name: StringResources.name,
                          email: StringResources.email,
                          phoneNumber: StringResources.phoneNumber,
                          password: StringResources.password
                      );
                      await widget.storage.writeData(json.encode(user));
                      addBoolToSF('login', true);
                      await pr.hide();
                      Navigator.of(context).pop();
                    }
                    else{
                      await pr.hide();
                      Fluttertoast.showToast(
                          msg: "Error: Email already exists.",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: ColorResources.heartColor,
                          textColor: ColorResources.whiteColor,
                          fontSize: 16.0
                      );
                    }
                  }
                  else{
                    User user = new User(
                        id: "user101",
                        name: StringResources.name,
                        email: StringResources.email,
                        phoneNumber: StringResources.phoneNumber,
                        password: StringResources.password
                    );
                    await widget.storage.writeData(json.encode(user));
                    addBoolToSF('login', true);
                    await pr.hide();
                    Navigator.of(context).pop();
                  }
                });

                // User user = new User(name: StringResources.name, email: StringResources.email, phoneNumber: StringResources.phoneNumber, password: StringResources.password);
                // signUpPostRequest('CREATE_signUpPost_URL', body: user.toJson()).then((value){
                //   pr.hide();
                // });
              }
            },
          )
        ],
      ),
    );
  }
}
