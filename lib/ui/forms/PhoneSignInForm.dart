import 'package:flutter/material.dart';
import 'package:food_delivery_app/resources/color_resources.dart';
import 'package:food_delivery_app/resources/font_resources.dart';
import 'package:food_delivery_app/resources/string_resources.dart';
import 'package:food_delivery_app/widgets/custom_widgets.dart';

class PhoneSignInForm extends StatefulWidget {
  @override
  _PhoneSignInFormState createState() => _PhoneSignInFormState();
}

class _PhoneSignInFormState extends State<PhoneSignInForm> {

  final _formKey = GlobalKey<FormState>();
  String _phone;

  TextEditingController cPhone = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
          children: [
            phoneFormField(),
            SizedBox(height: 30),
            DefaultButton(
              text: 'Okay',
              onPress: () {
                //_showToast(context, 'Sign In Button Pressed');
                if (_formKey.currentState.validate()) {
                  _formKey.currentState.save();
                }
              },
            )
          ],
        ));
  }

  TextFormField phoneFormField() {
    return TextFormField(
      controller: cPhone,
      textInputAction: TextInputAction.done,
      autofocus: true,
      keyboardType: TextInputType.phone,
      decoration: InputDecoration(
        border: OutlineInputBorder(
            borderRadius: const BorderRadius.all(const Radius.circular(10.0))),
        labelText: 'Phone Number',
        alignLabelWithHint: true,
        hintText: 'Phone Number',
        hintStyle: TextStyle(
          fontSize: 16,
          color: ColorResources.lightGreyColor,
          fontFamily: FontResources.regular,
        ),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        // suffixIcon: SvgIconWidget(
        //   svgIcon: Assets.iconsMail,
        // ),
      ),
      validator: (phone) {
        if (phone.isEmpty || phone.length == 0)
        {
          return 'Please enter phone number.';
        }
        else if (!StringResources.kPhoneValidatorRegExp.hasMatch(phone))
        {
          return 'Please enter a valid phone number.';
        }
        else
        {
          return null;
        }
      },
      onSaved: (phone) => _phone = phone,
    );
  }

}
