
import 'package:credit_card_slider/card_background.dart';
import 'package:credit_card_slider/credit_card_slider.dart';
import 'package:credit_card_slider/credit_card_widget.dart';
import 'package:credit_card_slider/validity.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/resources/color_resources.dart';
import 'package:food_delivery_app/resources/font_resources.dart';
import 'package:food_delivery_app/ui/screens/add_card_screen.dart';
import 'package:food_delivery_app/widgets/custom_widgets.dart';

import 'add_card_screen.dart';

class PaymentScreen extends StatefulWidget {
  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  //region default card list
  var _creditCards = [
    CreditCard(
      cardBackground: SolidColorCardBackground(ColorResources.darkGreyColor),
      cardHolderName: 'Name ABC',
      cardNumber: '1234 1234 1234 1234',
      validity: Validity(
        validFromMonth: 12,
        validFromYear: 20,
        validThruMonth: 12,
        validThruYear: 21,
      ),
    ),
    CreditCard(
      cardBackground: SolidColorCardBackground(ColorResources.dodgerBlueColor),
      cardHolderName: 'Name ABC',
      cardNumber: '2434 2434 **** ****',
      validity: Validity(
        validFromMonth: 12,
        validFromYear: 20,
        validThruMonth: 12,
        validThruYear: 21,
      ),
    ),
    CreditCard(
      cardBackground: SolidColorCardBackground(ColorResources.heartColor),
      cardHolderName: 'Name ABC',
      cardNumber: '4567',
      validity: Validity(
        validFromMonth: 12,
        validFromYear: 20,
        validThruMonth: 12,
        validThruYear: 21,
      ),
    ),
    CreditCard(
      cardBackground: SolidColorCardBackground(ColorResources.darkGreyColor),
      cardHolderName: 'Name ABC',
      cardNumber: '2434 2434 **** ****',
      validity: Validity(
        validFromMonth: 12,
        validFromYear: 20,
        validThruMonth: 12,
        validThruYear: 21,
      ),
    ),
    CreditCard(
      cardBackground: SolidColorCardBackground(ColorResources.lightGreyColor),
      cardHolderName: 'Name ABC',
      cardNumber: '2434 2434 **** ****',
      validity: Validity(
        validFromMonth: 12,
        validFromYear: 20,
        validThruMonth: 12,
        validThruYear: 21,
      ),
    ),
  ];
  //endregion
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
            textRegular('Card Payment', TextAlign.start),
          ],
        ),
        backgroundColor: Colors.white,
      ),
      body: CreditCardSlider(
        _creditCards,
        initialCard: 0,
        repeatCards: RepeatCards.none,
        onCardClicked: (index) {
          showDialog(
              context: context,
              builder: (BuildContext context){
                //region pop up dialog code
                return Dialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  elevation: 0,
                  backgroundColor: ColorResources.whiteColor,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 60.0),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          DefaultButton(
                            text: "Delete",
                            onPress: (){
                              Navigator.of(context).pop();
                              setState(() {
                                if(_creditCards.length != 1){
                                  _creditCards.removeAt(index);
                                }
                                else{
                                  Navigator.of(context).pop();
                                }
                              });
                              }
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          DefaultButton(
                              text: "Edit",
                              onPress: (){
                                Navigator.of(context).pop();
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => AddCardPage()),
                                );
                              }
                          ),
                        ],
                      ),
                    ),
                  ),
                );
                //endregion
              });
        },
      ),

      //region add card button
      floatingActionButton: Padding(
        padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
        child: FloatingActionButton.extended(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddCardPage(),
              ),
            );
          },
          icon: Icon(
            Icons.payment_rounded,
            color: ColorResources.whiteColor,
          ),
          label: Text(
            "Add Card",
            style: TextStyle(
              fontSize: 16,
              color: ColorResources.whiteColor,
              fontFamily: FontResources.bold,
            ),
          ),
          backgroundColor: ColorResources.dodgerBlueColor,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      //endregion
    );
  }
}
