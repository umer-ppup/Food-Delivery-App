import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:food_delivery_app/models/address_model.dart';
import 'package:food_delivery_app/models/restaurant.dart';
import 'package:food_delivery_app/resources/font_resources.dart';
import 'package:food_delivery_app/resources/string_resources.dart';
import 'package:food_delivery_app/ui/screens/detail_screen.dart';
import 'package:food_delivery_app/ui/screens/wishlist_screen.dart';
import 'package:food_delivery_app/util/util.dart';
import 'package:food_delivery_app/widgets/all_restaurant_list.dart';
import 'package:food_delivery_app/widgets/custom_widgets.dart';
import 'package:food_delivery_app/widgets/feature_restaurant_list.dart';
import 'package:food_delivery_app/resources/color_resources.dart';

class HomeScreen extends StatefulWidget {
  List<RestaurantModel> restaurantModels = new List<RestaurantModel>();
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //region popup bottom sheet code
  void settingModalBottomSheet() {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext buildContext) {
          return StatefulBuilder(
              builder: (BuildContext mContext, StateSetter setState) {
                return Container(
                  color: ColorResources.whiteColor,
                  child: FutureBuilder(
                    future: readJson("URL", "addressData"),
                    builder: (BuildContext context, snapshot) {
                      if(snapshot.hasData){
                        return ListView.builder(
                          shrinkWrap: true,
                          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
                          scrollDirection: Axis.vertical,
                          itemCount: snapshot.data.length,
                          itemBuilder: (BuildContext context, int index) {
                            AddressModel addressModel = snapshot.data[index];
                            return GestureDetector(
                              onTap: (){
                                Navigator.of(context).pop();
                              },
                              child: Container(
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
                                    Icon(
                                      Icons.home,
                                      color: ColorResources.dodgerBlueColor,
                                    ),
                                    SizedBox(
                                      width: 10.0,
                                    ),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        textBold(addressModel.field.toString(), TextAlign.start),
                                        SizedBox(
                                          height: 10.0,
                                        ),
                                        textRegular(addressModel.address != null ? addressModel.address : "", TextAlign.start)
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      }
                      else if(snapshot.hasError){
                        return Center(child: textBold("${snapshot.error}", TextAlign.start));
                      }

                      // By default, show a loading spinner.
                      return Center(child: CircularProgressIndicator());
                    },
                  ),
                );
              });
        });
  }
  //endregion

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    readJson("URL", "restaurantData").then((value){
      setState(() {
        widget.restaurantModels = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerWidget(),
      appBar: AppBar(
        iconTheme: IconThemeData(color: ColorResources.darkGreyColor),
        brightness: Brightness.light,
        elevation: 0.0,
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.0),
            child: InkWell(
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => WishlistScreen(),
                  ),
                );
              },
              child: Icon(
                Icons.favorite_rounded,
                color: ColorResources.heartColor,
              ),
            ),
          ),
        ],
        title: GestureDetector(
          onTap: (){
            settingModalBottomSheet();
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              textRegular('Current Location', TextAlign.start),
              textRegular('123', TextAlign.start),
            ],
          ),
        ),
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 10.0,
              ),
              searchWidget(context, widget.restaurantModels),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
                    child: Text(
                      StringResources.feature,
                      style: TextStyle(
                        fontSize: 18,
                        color: ColorResources.darkGreyColor,
                        fontFamily: FontResources.bold,
                      ),
                    ),
                  ),
                ],
              ),

              //region feature restaurant list
              Container(
                height: 220.0,
                child: FutureBuilder(
                  future: readJson("URL", "restaurantData"),
                  builder: (context, snapshot) {
                    if(snapshot.hasData){
                      return ListView.builder(
                        shrinkWrap: true,
                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                        scrollDirection: Axis.horizontal,
                        itemCount: snapshot.data.length,
                        itemBuilder: (BuildContext context, int index) {
                          RestaurantModel restaurantModel = snapshot.data[index];
                          return GestureDetector(
                            child: FeatureRestaurantList(
                              imagePath: restaurantModel.imagePath,
                              title: restaurantModel.title,
                              delivery: restaurantModel.delivery,
                              deliveryFee: restaurantModel.deliveryFee,
                              averageReview: restaurantModel.averageReview,
                              reviewPeopleCount: restaurantModel.reviewPeopleCount,
                            ),
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      DetailScreen(restaurantModel: restaurantModel)));
                            },
                          );
                        },
                      );
                    }
                    else if(snapshot.hasError){
                      return Center(child: textBold("${snapshot.error}", TextAlign.start));
                    }

                    // By default, show a loading spinner.
                    return Center(child: Container(child: CircularProgressIndicator()));
                  },
                ),
              ),
              //endregion

              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
                    child: Text(
                      StringResources.allRes,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 18,
                        color: ColorResources.darkGreyColor,
                        fontFamily: FontResources.bold,
                      ),
                    ),
                  ),
                ],
              ),

              //region all restaurant list
              Container(
                child: FutureBuilder(
                  future: readJson("URL", "restaurantData"),
                  builder: (context, snapshot) {
                    if(snapshot.hasData){
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.symmetric(horizontal: 10.0),
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
                              color: ColorResources.darkGreyColor,
                            ),
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => DetailScreen(restaurantModel: restaurantModel)));
                            },
                          );
                        },
                      );
                    }
                    else if(snapshot.hasError){
                      return Center(child: textBold("${snapshot.error}", TextAlign.start));
                    }
                    // By default, show a loading spinner.
                    return Center(child: CircularProgressIndicator());
                  },
                ),
              )
              //endregion
            ],
          ),
        ),
      ),
    );
  }
}
