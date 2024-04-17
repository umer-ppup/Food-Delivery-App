import 'package:flutter/material.dart';
import 'package:food_delivery_app/models/restaurant.dart';
import 'package:food_delivery_app/resources/color_resources.dart';
import 'package:food_delivery_app/util/util.dart';
import 'package:food_delivery_app/widgets/all_restaurant_list.dart';
import 'package:food_delivery_app/widgets/custom_widgets.dart';

import 'detail_screen.dart';

class WishlistScreen extends StatefulWidget {
  @override
  _WishlistScreenState createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
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
            textRegular('Wishlist', TextAlign.start),
          ],
        ),
        backgroundColor: Colors.white,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                //region liked restaurant list builder
                child: FutureBuilder(
                  future: readJson("URL", "restaurantData"),
                  builder: (context, snapshot) {
                    if(snapshot.hasData){
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
                        scrollDirection: Axis.vertical,
                        itemCount: snapshot.data.length,
                        itemBuilder: (BuildContext context, int index) {
                          RestaurantModel restaurantModel = snapshot.data[index];
                          return GestureDetector(
                            child: AllRestaurantList(
                              imagePath: restaurantModel.imagePath,
                              title: restaurantModel.title,
                              delivery: restaurantModel.delivery,
                              deliveryFee: restaurantModel.deliveryFee,
                              averageReview: restaurantModel.averageReview,
                              reviewPeopleCount: restaurantModel.reviewPeopleCount,
                              color: ColorResources.heartColor,
                            ),
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      DetailScreen(restaurantModel: restaurantModel,)));
                            },
                          );
                        },
                      );
                    }
                    else if(snapshot.hasError) {
                      return Center(child: textBold("${snapshot.error}", TextAlign.start));
                    }
                    // By default, show a loading spinner.
                    return CircularProgressIndicator();
                  },
                ),
                //endregion
              )
            ],
          ),
        ),
      ),
    );
  }
}
