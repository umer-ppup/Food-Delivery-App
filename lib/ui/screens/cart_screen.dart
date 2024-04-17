import 'package:flutter/material.dart';
import 'package:food_delivery_app/models/product.dart';
import 'package:food_delivery_app/models/restaurant.dart';
import 'package:food_delivery_app/resources/color_resources.dart';
import 'package:food_delivery_app/resources/font_resources.dart';
import 'package:food_delivery_app/resources/image_resources.dart';
import 'package:food_delivery_app/util/util.dart';
import 'package:food_delivery_app/widgets/custom_widgets.dart';

import 'order_screen.dart';

// ignore: must_be_immutable
class CartScreen extends StatefulWidget {
  int subTotal = 0;
  bool cart = true;
  bool emptyCart = false;
  RestaurantModel restaurantModel = new RestaurantModel();
  List<Product> products = new List<Product>();

  CartScreen({this.restaurantModel});

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if(widget.restaurantModel.categories != null){
      for(int cat = 0; cat < widget.restaurantModel.categories.length; cat++){
        for(int pro = 0; pro < widget.restaurantModel.categories[cat].products.length; pro++){
          if(int.parse(widget.restaurantModel.categories[cat].products[pro].quantity) != 0){
            widget.products.add(widget.restaurantModel.categories[cat].products[pro]);
          }
        }
      }
    }

    if(widget.products.isEmpty){
      widget.cart = false;
      widget.emptyCart = true;
    }
  }
  @override
  Widget build(BuildContext context) {
    if(widget.subTotal != 0){
      widget.subTotal = 0;
    };
    for(int i = 0; i < widget.products.length; i++){
      int amount = int.parse(widget.products[i].quantity) * int.parse(widget.products[i].amount);
      widget.subTotal = widget.subTotal + amount;
    };
    return Scaffold(
      backgroundColor: ColorResources.whiteColor,
      appBar: AppBar(
        iconTheme: IconThemeData(color: ColorResources.darkGreyColor),
        brightness: Brightness.light,
        elevation: 0.0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            textRegular('Cart', TextAlign.start),
            Visibility(
                visible: widget.cart,
                child: textRegular(widget.restaurantModel.title != null ? widget.restaurantModel.title : "", TextAlign.start)),
          ],
        ),
        backgroundColor: Colors.white,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              //region empty cart image
              Visibility(
                visible: widget.emptyCart,
                child: Align(
                  alignment: Alignment.center,
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 50.0),
                    child: Image.asset(ImageResources.emptyCart, width: MediaQuery.of(context).size.width, height: MediaQuery.of(context).size.height * 0.5, fit: BoxFit.contain,),
                  ),
                ),
              ),
              //endregion

              //region cart product list
              Visibility(
                visible: widget.cart,
                child: Container(
                  // height: 300.0,
                  child: FutureBuilder<List<Product>>(
                    builder: (BuildContext context, AsyncSnapshot<List<Product>> snapshot) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.waiting:
                          return Text('Loading....');
                        default:
                          if (snapshot.hasError)
                            return Text('Error: ${snapshot.error}');
                          else
                            //region product list builder
                            return ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              padding: EdgeInsets.symmetric(horizontal: 5.0),
                              scrollDirection: Axis.vertical,
                              itemCount: widget.products.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Container(
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      width: 0.0,
                                      color: ColorResources.smokeWhiteColor,
                                    ),
                                    borderRadius: BorderRadius.all(Radius.circular(7.0)),
                                    color: ColorResources.smokeWhiteColor,
                                  ),
                                  margin: EdgeInsets.fromLTRB(10.0, 5.0, 5.0, 10.0),
                                  padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                                  child: Row(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(7.0),
                                        child: Image.asset(
                                          widget.products[index].imagePath,
                                          fit: BoxFit.cover,
                                          width: 80.0,
                                          height: 80.0,
                                        ),
                                      ),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              margin: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 10.0),
                                              child: Text(
                                                widget.products[index].title != null ? widget.products[index].title : "",
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  color: ColorResources.darkGreyColor,
                                                  fontFamily: FontResources.bold,
                                                ),
                                              ),
                                            ),
                                            Container(
                                              child: Row(
                                                children: [
                                                  IconButton(
                                                    splashColor: Colors.transparent,
                                                    highlightColor: Colors.transparent,
                                                    onPressed: (){
                                                      if(int.parse(widget.products[index].quantity) != 0){
                                                        setState(() {
                                                          widget.products[index].quantity = (int.parse(widget.products[index].quantity) - 1).toString();
                                                          if(int.parse(widget.products[index].quantity) == 0){
                                                            setState(() {
                                                              widget.products.removeAt(index);
                                                              if(widget.products.isEmpty){
                                                                widget.cart = false;
                                                                widget.emptyCart = true;
                                                              }
                                                            });
                                                          }
                                                        });
                                                      }
                                                    },
                                                    icon: Icon(Icons.remove, color: ColorResources.darkGreyColor, size: 24.0,),
                                                  ),
                                                  Container(
                                                    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                                                    decoration: BoxDecoration(
                                                      border: Border.all(
                                                        width: 0.0,
                                                        color: ColorResources.dodgerBlueColor,
                                                      ),
                                                      borderRadius: BorderRadius.all(Radius.circular(7.0)),
                                                      color: ColorResources.dodgerBlueColor,
                                                    ),
                                                    child: Text(
                                                      widget.products[index].quantity,
                                                      style: TextStyle(
                                                        fontSize: 16,
                                                        color: ColorResources.whiteColor,
                                                        fontFamily: FontResources.bold,
                                                      ),
                                                    ),
                                                  ),
                                                  IconButton(
                                                    splashColor: Colors.transparent,
                                                    highlightColor: Colors.transparent,
                                                    onPressed: (){
                                                      setState(() {
                                                        widget.products[index].quantity = (int.parse(widget.products[index].quantity) + 1).toString();
                                                      });
                                                    },
                                                    icon: Icon(Icons.add, color: ColorResources.darkGreyColor, size: 24.0,),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        child: Text(
                                          getRupeesString(widget.products[index].amount),
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: ColorResources.dodgerBlueColor,
                                            fontFamily: FontResources.bold,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          //endregion
                      }
                    },
                  ),
                ),
              ),
              //endregion

              Visibility(
                visible: widget.cart,
                child: SizedBox(
                  height: 20.0,
                ),
              ),
              Visibility(
                visible: widget.cart,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Divider(
                    color: ColorResources.darkGreyColor,
                    height: 1.0,
                  ),
                ),
              ),
              Visibility(
                visible: widget.cart,
                child: SizedBox(
                  height: 20.0,
                ),
              ),

              //region sub-total, delivery and total list
              Visibility(
                visible: widget.cart,
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 10.0),
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 0.0,
                      color: ColorResources.whiteColor,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(7.0)),
                    color: ColorResources.whiteColor,
                    boxShadow: [BoxShadow(
                      offset: Offset(0, 0),
                      blurRadius: 3,
                      color: ColorResources.darkGreyColor.withOpacity(0.2),
                    )],
                  ),
                  child: Column(
                    children: [
                      Visibility(
                        visible: widget.cart,
                        child: SizedBox(
                          height: 20.0,
                        ),
                      ),
                      Visibility(
                        visible: widget.cart,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10.0),
                                child: Text(
                                  'Sub-Total',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: ColorResources.darkGreyColor,
                                    fontFamily: FontResources.regular,
                                  ),
                                ),
                              ),
                              Spacer(),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10.0),
                                child: Text(
                                  'Rs. ' + widget.subTotal.toString(),
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: ColorResources.darkGreyColor,
                                    fontFamily: FontResources.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Visibility(
                        visible: widget.cart,
                        child: SizedBox(
                          height: 10.0,
                        ),
                      ),
                      Visibility(
                        visible: widget.cart,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10.0),
                                child: Text(
                                  'Delivery-Fee',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: ColorResources.darkGreyColor,
                                    fontFamily: FontResources.regular,
                                  ),
                                ),
                              ),
                              Spacer(),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10.0),
                                child: Text(
                                  widget.restaurantModel.deliveryFee != null ? 'Rs. ' + widget.restaurantModel.deliveryFee : "",
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: ColorResources.darkGreyColor,
                                    fontFamily: FontResources.regular,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Visibility(
                        visible: widget.cart,
                        child: SizedBox(
                          height: 10.0,
                        ),
                      ),
                      Visibility(
                        visible: widget.cart,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10.0),
                                child: Text(
                                  'Total-Payable',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: ColorResources.darkGreyColor,
                                    fontFamily: FontResources.regular,
                                  ),
                                ),
                              ),
                              Spacer(),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10.0),
                                child: Text(
                                    widget.restaurantModel.deliveryFee != null ? 'Rs. ' + (widget.subTotal + int.parse(widget.restaurantModel.deliveryFee)).toString() : "",
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: ColorResources.heartColor,
                                    fontFamily: FontResources.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Visibility(
                        visible: widget.cart,
                        child: SizedBox(
                          height: 20.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              //endregion

              Visibility(
                visible: widget.cart,
                child: SizedBox(
                  height: 20.0,
                ),
              ),

              //region button to make order
              Visibility(
                visible: widget.cart,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.symmetric(horizontal: 30.0),
                  child: RaisedButton(
                    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    color: ColorResources.heartColor,
                    onPressed: (){
                      Map<String, String> map = {
                        "sub_total": 'Rs. ' + widget.subTotal.toString(),
                        "delivery_fee": widget.restaurantModel.deliveryFee != null ? 'Rs. ' + widget.restaurantModel.deliveryFee : "",
                        "total": widget.restaurantModel.deliveryFee != null ? 'Rs. ' + (widget.subTotal + int.parse(widget.restaurantModel.deliveryFee)).toString() : "",
                        "title": widget.restaurantModel.title != null ? widget.restaurantModel.title : "",
                        "restaurantId": widget.restaurantModel.restaurantId != null ? widget.restaurantModel.restaurantId : "",
                      };
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => OrderScreen(map: map,),
                        ),
                      );
                    },
                    child: Text(
                        widget.restaurantModel.deliveryFee != null ? 'Make Your Order('+'Rs. ' + (widget.subTotal + int.parse(widget.restaurantModel.deliveryFee)).toString()+')' : "",
                        style: TextStyle(
                          fontSize: 16,
                          color: ColorResources.whiteColor,
                          fontFamily: FontResources.bold,
                        )
                    ),
                  ),
                ),
              ),
              //endregion

              Visibility(
                visible: widget.cart,
                child: SizedBox(
                  height: 20.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
