import 'package:flutter/material.dart';
import 'package:food_delivery_app/models/order_model.dart';
import 'package:food_delivery_app/models/restaurant.dart';
import 'package:food_delivery_app/resources/color_resources.dart';
import 'package:food_delivery_app/resources/font_resources.dart';
import 'package:food_delivery_app/ui/screens/cart_screen.dart';
import 'package:food_delivery_app/util/util.dart';
import 'package:food_delivery_app/widgets/custom_widgets.dart';


// ignore: must_be_immutable
class OrderHistoryScreen extends StatefulWidget {
  @override
  _OrderHistoryScreenState createState() => _OrderHistoryScreenState();
}

class _OrderHistoryScreenState extends State<OrderHistoryScreen> {
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
            textRegular('Order History', TextAlign.start),
          ],
        ),
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          margin: EdgeInsets.symmetric(horizontal: 10.0),

          //region order history list builder
          child: FutureBuilder(
            future: readJson("URL", "orderData"),
            builder: (context, snapshot) {
              if(snapshot.hasData){
                return ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    OrderModel orderModel = snapshot.data[index];
                    return Container(
                      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 0.0,
                          color: ColorResources.smokeWhiteColor,
                        ),
                        borderRadius:
                        BorderRadius.all(Radius.circular(7.0)),
                        color: ColorResources.smokeWhiteColor,
                      ),
                      margin: EdgeInsets.symmetric(vertical: 10.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            orderModel.id.toString() != null ? orderModel.id.toString() : "",
                            style: TextStyle(
                              fontSize: 16,
                              color: ColorResources.darkGreyColor,
                              fontFamily: FontResources.bold,
                            ),
                          ),
                          SizedBox(
                            width: 10.0,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                orderModel.restaurantName != null ? orderModel.restaurantName : "",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: ColorResources.darkGreyColor,
                                  fontFamily: FontResources.bold,
                                ),
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              Text(
                                orderModel.dateTime != null ? orderModel.dateTime : "",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: ColorResources.darkGreyColor,
                                  fontFamily: FontResources.regular,
                                ),
                              ),
                            ],
                          ),
                          Spacer(),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                orderModel.price != null ? orderModel.price : "",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: ColorResources.darkGreyColor,
                                  fontFamily: FontResources.bold,
                                ),
                              ),
                              RaisedButton(
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                color: ColorResources.heartColor,
                                onPressed: (){
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => CartScreen(restaurantModel: new RestaurantModel(),),
                                    ),
                                  );
                                },
                                child: Text(
                                    'Re-Order',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: ColorResources.whiteColor,
                                      fontFamily: FontResources.bold,
                                    )
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                );
              }
              else if(snapshot.hasError){
                return Center(child: textBold("${snapshot.error}", TextAlign.start));
              }

              // By default, show a loading spinner.
              return CircularProgressIndicator();
            },
          ),
          //endregion
        ),
      ),
    );
  }
}
