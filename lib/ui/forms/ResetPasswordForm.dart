import 'package:flutter/material.dart';
import 'package:food_delivery_app/widgets/custom_widgets.dart';

class ResetPasswordForm extends StatefulWidget {
  @override
  _ResetPasswordFormState createState() => _ResetPasswordFormState();
}

class _ResetPasswordFormState extends State<ResetPasswordForm> {
  final _formKey = GlobalKey<FormState>();
  String _email;

  TextEditingController cEmail = TextEditingController();
  FocusNode _nameFocusNode = FocusNode();
  FocusNode _emailFocusNode = FocusNode();
  FocusNode _phoneNumberFocusNode = FocusNode();
  FocusNode _passwordFocusNode = FocusNode();
  FocusNode _confirmPasswordFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          inputField(_emailFocusNode, cEmail, TextInputAction.next, TextInputType.emailAddress, 'Email', Icons.email_rounded,
              'email', cEmail, context, _nameFocusNode, _emailFocusNode, _phoneNumberFocusNode, _passwordFocusNode, _confirmPasswordFocusNode),
          SizedBox(height: 30),
          DefaultButton(
            text: 'RESET PASSWORD',
            onPress: () {
              if (_formKey.currentState.validate()) {
                _formKey.currentState.save();
              }
            },
          )
        ],
      ),
    );
  }
}
