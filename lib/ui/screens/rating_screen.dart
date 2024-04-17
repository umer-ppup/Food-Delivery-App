import 'package:flutter/material.dart';
import 'package:food_delivery_app/resources/color_resources.dart';
import 'package:food_delivery_app/resources/font_resources.dart';
import 'package:food_delivery_app/resources/string_resources.dart';
import 'package:food_delivery_app/widgets/custom_widgets.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

// ignore: must_be_immutable
class RatingScreen extends StatefulWidget {
  String title;
  String restaurantId;
  RatingScreen({this.title, this.restaurantId});
  @override
  _RatingScreenState createState() => _RatingScreenState();
}

class _RatingScreenState extends State<RatingScreen> {
  final _formKey = GlobalKey<FormState>();
  bool visible = true;

  TextEditingController cComment = TextEditingController();
  FocusNode _commentFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: Scaffold(
        backgroundColor: ColorResources.whiteColor,
        appBar: AppBar(
          iconTheme: IconThemeData(color: ColorResources.darkGreyColor),
          brightness: Brightness.light,
          elevation: 0.0,
          title: textRegular('Rating', TextAlign.start),
          backgroundColor: Colors.white,
        ),

        body: Container(
          width: MediaQuery.of(context).size.width,
          child: SingleChildScrollView(
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //region title of restaurant
                  Container(
                    margin: EdgeInsets.only(top: 50.0),
                    child: Text(
                      widget.title != null ? widget.title : "",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 22,
                        letterSpacing: 2.0,
                        color: ColorResources.darkGreyColor,
                        fontFamily: FontResources.bold,
                      ),
                    ),
                  ),
                  //endregion

                  //region rating bar code
                  Container(
                    margin: EdgeInsets.only(top: 50.0),
                    child: RatingBar.builder(
                        initialRating: 0.0,
                        allowHalfRating: true,
                        itemBuilder: (context, index) => Icon(
                          Icons.star,
                          color: ColorResources.heartColor,
                        ),
                        itemCount: 5,
                        itemSize: 48.0,
                        direction: Axis.horizontal,
                        onRatingUpdate: (rating){
                          print(rating);
                        }),
                  ),
                  //endregion

                  //region review text input code
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.fromLTRB(30.0, 50.0, 30.0, 0.0),
                          child: TextFormField(
                            focusNode: _commentFocusNode,
                            controller: cComment,
                            textInputAction: TextInputAction.newline,
                            autofocus: false,
                            maxLines: 5,
                            maxLength: 200,
                            keyboardType: TextInputType.multiline,
                            obscureText: false,
                            style: TextStyle(
                              fontSize: 16,
                              color: ColorResources.darkGreyColor,
                              fontFamily: FontResources.regular,
                            ),
                            cursorColor: ColorResources.darkGreyColor,
                            decoration: InputDecoration(
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
                              border: OutlineInputBorder(
                                  borderRadius: const BorderRadius.all(const Radius.circular(10.0))),
                              alignLabelWithHint: true,
                              counterStyle: TextStyle(
                                fontSize: 14,
                                color: ColorResources.heartColor,
                                fontFamily: FontResources.regular,
                              ),
                              labelText: "Comment",
                              labelStyle: TextStyle(
                                fontSize: 16,
                                color: ColorResources.darkGreyColor,
                                fontFamily: FontResources.regular,
                              ),
                              hintText: "Comment...",
                              hintStyle: TextStyle(
                                fontSize: 16,
                                color: ColorResources.lightGreyColor,
                                fontFamily: FontResources.regular,
                              ),
                              floatingLabelBehavior: FloatingLabelBehavior.never,
                            ),
                            validator: (value){
                              if (value.isEmpty) {
                                return 'Please write some comment.';
                              }
                              else {
                                return null;
                              }
                            },
                            onSaved: (value){
                              StringResources.comment = value;
                            },
                            onFieldSubmitted: (_){},
                          ),
                        ),
                        Visibility(
                          visible: visible,
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 60.0, vertical: 50.0),
                            child: DefaultButton(
                              text: 'Save',
                              onPress: () {
                                if (_formKey.currentState.validate()) {
                                  _formKey.currentState.save();
                                  Navigator.of(context).pop();
                                }
                              },
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                  //endregion
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
