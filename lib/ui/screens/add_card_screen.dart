import 'package:food_delivery_app/resources/color_resources.dart';
import 'package:food_delivery_app/resources/font_resources.dart';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/credit_card_form.dart';
import 'package:flutter_credit_card/credit_card_model.dart';
import 'package:flutter_credit_card/credit_card_widget.dart';
import 'package:food_delivery_app/resources/string_resources.dart';
import 'package:food_delivery_app/widgets/custom_widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AddCardPage extends StatefulWidget {
  @override
  _AddCardPageState createState() => _AddCardPageState();
}

class _AddCardPageState extends State<AddCardPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String cardNumber = "";
  String cardHolderName = "";
  String expiryDate = "";
  String cvvCode = "";
  bool isCvvFocused = false;
  FocusNode _focusNode;

  void onCreditCardModelChange(CreditCardModel creditCardModel) {
    setState(() {
      cardNumber = creditCardModel.cardNumber;
      expiryDate = creditCardModel.expiryDate;
      cardHolderName = creditCardModel.cardHolderName;
      cvvCode = creditCardModel.cvvCode;
      isCvvFocused = creditCardModel.isCvvFocused;
    });
  }

  @override
  void initState() {
    super.initState();
    _focusNode = new FocusNode();
    _focusNode.addListener(() {
      setState(() {
        _focusNode.hasFocus ? isCvvFocused = true : isCvvFocused = false;
      });
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
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
            textRegular('Add Card', TextAlign.start),
          ],
        ),
        backgroundColor: Colors.white,
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              //region card widget
              CreditCardWidget(
                cardNumber: cardNumber,
                expiryDate: expiryDate,
                cardHolderName: cardHolderName,
                cvvCode: cvvCode,
                showBackView: isCvvFocused,
                cardBgColor: ColorResources.darkGreyColor,
                obscureCardNumber: true,
                obscureCardCvv: true,
                height: 175,
                textStyle: TextStyle(
                  fontSize: 16,
                  color: ColorResources.whiteColor,
                  fontFamily: FontResources.regular,
                ),
                width: MediaQuery.of(context).size.width,
                animationDuration: Duration(milliseconds: 1000),
              ),
              //endregion

              //region card form
              CreditCardForm(
                formKey: _formKey, // Required
                onCreditCardModelChange: onCreditCardModelChange, // Required
                themeColor: ColorResources.dodgerBlueColor,
                obscureCvv: true,
                cardNumber: cardNumber,
                expiryDate: expiryDate,
                cardHolderName: cardHolderName,
                cvvCode: cvvCode,
                cardNumberDecoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: ColorResources.darkGreyColor,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: ColorResources.darkGreyColor,
                    ),
                  ),
                  disabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: ColorResources.heartColor,
                      )
                  ),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: ColorResources.darkGreyColor,
                      ),
                      borderRadius: const BorderRadius.all(const Radius.circular(10.0))
                  ),
                  alignLabelWithHint: true,
                  labelText: StringResources.kLabelCardNumber,
                  labelStyle: TextStyle(
                    fontSize: 16,
                    color: ColorResources.darkGreyColor,
                    fontFamily: FontResources.regular,
                  ),
                  hintText: StringResources.kHintCardNumber,
                  hintStyle: TextStyle(
                    fontSize: 16,
                    color: ColorResources.lightGreyColor,
                    fontFamily: FontResources.regular,
                  ),
                ),
                expiryDateDecoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: ColorResources.darkGreyColor,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: ColorResources.darkGreyColor,
                    ),
                  ),
                  disabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: ColorResources.heartColor,
                      )
                  ),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: ColorResources.darkGreyColor,
                      ),
                      borderRadius: const BorderRadius.all(const Radius.circular(10.0))
                  ),
                  alignLabelWithHint: true,
                  labelText: StringResources.kLabelCardExpiryDate,
                  labelStyle: TextStyle(
                    fontSize: 16,
                    color: ColorResources.darkGreyColor,
                    fontFamily: FontResources.regular,
                  ),
                  hintText: StringResources.kHintCardExpiryDate,
                  hintStyle: TextStyle(
                    fontSize: 16,
                    color: ColorResources.lightGreyColor,
                    fontFamily: FontResources.regular,
                  ),
                ),
                cvvCodeDecoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: ColorResources.darkGreyColor,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: ColorResources.darkGreyColor,
                    ),
                  ),
                  disabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: ColorResources.heartColor,
                      )
                  ),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: ColorResources.darkGreyColor,
                      ),
                      borderRadius: const BorderRadius.all(const Radius.circular(10.0))
                  ),
                  alignLabelWithHint: true,
                  labelText: StringResources.kLabelCardCVV,
                  labelStyle: TextStyle(
                    fontSize: 16,
                    color: ColorResources.darkGreyColor,
                    fontFamily: FontResources.regular,
                  ),
                  hintText: StringResources.kHintCardCVV,
                  hintStyle: TextStyle(
                    fontSize: 16,
                    color: ColorResources.lightGreyColor,
                    fontFamily: FontResources.regular,
                  ),
                ),
                cardHolderDecoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: ColorResources.darkGreyColor,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: ColorResources.darkGreyColor,
                    ),
                  ),
                  disabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: ColorResources.heartColor,
                      )
                  ),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: ColorResources.darkGreyColor,
                      ),
                      borderRadius: const BorderRadius.all(const Radius.circular(10.0))
                  ),
                  alignLabelWithHint: true,
                  labelText: StringResources.kLabelCardHolder,
                  labelStyle: TextStyle(
                    fontSize: 16,
                    color: ColorResources.darkGreyColor,
                    fontFamily: FontResources.regular,
                  ),
                  hintText: StringResources.kHintCardHolder,
                  hintStyle: TextStyle(
                    fontSize: 16,
                    color: ColorResources.lightGreyColor,
                    fontFamily: FontResources.regular,
                  ),
                ),
              ),
              //endregion

              SizedBox(
                height: 20,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 30.0),
                child: DefaultButton(
                  text: "Add This Card",
                  onPress: () {
                    if (_formKey.currentState.validate()) {
                      _formKey.currentState.save();
                      if(cardHolderName == ""){
                        Fluttertoast.showToast(
                            msg: "Error: Holder name is necessary.",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: ColorResources.heartColor,
                            textColor: ColorResources.whiteColor,
                            fontSize: 16.0
                        );
                      }
                      else{
                        Navigator.pop(context);
                      }
                    }
                  },
                ),
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
