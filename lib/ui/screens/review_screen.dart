import 'package:flutter/material.dart';
import 'package:food_delivery_app/models/restaurant.dart';
import 'package:food_delivery_app/models/review.dart';
import 'package:food_delivery_app/resources/color_resources.dart';
import 'package:food_delivery_app/resources/font_resources.dart';
import 'package:food_delivery_app/resources/string_resources.dart';
import 'package:food_delivery_app/util/util.dart';
import 'package:food_delivery_app/widgets/custom_widgets.dart';


// ignore: must_be_immutable
class ReviewScreen extends StatefulWidget {
  int tab = 0;
  RestaurantModel restaurantModel = new RestaurantModel();
  ReviewScreen({this.restaurantModel, this.tab});

  @override
  _ReviewScreenState createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorResources.whiteColor,
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                //region top image with back arrow
                Stack(
                  children: [
                    Image.asset(
                      widget.restaurantModel.imagePath,
                      fit: BoxFit.cover,
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.3,
                    ),
                    Positioned(
                      left: 10.0,
                      top: 10.0,
                      child: GestureDetector(
                        child: Container(
                          padding: EdgeInsets.all(5.0),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: ColorResources.whiteColor,
                          ),
                          child: Icon(
                            Icons.arrow_back_rounded,
                            color: ColorResources.darkGreyColor,
                            size: 24.0,
                            semanticLabel: 'Favourite.',
                          ),
                        ),
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                  ],
                ),
                //endregion

                //region middle area title and rating etc
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                  width: MediaQuery.of(context).size.width,
                  child: Text(
                    widget.restaurantModel.title != null ? widget.restaurantModel.title : "",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: 18,
                      color: ColorResources.darkGreyColor,
                      fontFamily: FontResources.bold,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                  child: Row(
                    children: [
                      Icon(
                        Icons.star_border_rounded,
                        color: ColorResources.heartColor,
                        size: 36.0,
                        semanticLabel: 'Rating icon.',
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.restaurantModel.averageReview != null ? widget.restaurantModel.averageReview : "",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontSize: 16,
                              color: ColorResources.darkGreyColor,
                              fontFamily: FontResources.bold,
                            ),
                          ),
                          Text(
                            "${widget.restaurantModel.reviewPeopleCount} people rated",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontSize: 16,
                              color: ColorResources.darkGreyColor,
                              fontFamily: FontResources.regular,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                //endregion

                SizedBox(
                  height: 10.0,
                ),

                //region about and review tabs code
                Container(
                  height: MediaQuery.of(context).size.height * 0.53,
                  child: DefaultTabController(
                      length: 2, // length of tabs
                      initialIndex: widget.tab,
                      child: Scaffold(
                        backgroundColor: ColorResources.whiteColor,
                        appBar: AppBar(
                          backgroundColor: ColorResources.whiteColor,
                          elevation: 0.0,
                          automaticallyImplyLeading: false,
                          flexibleSpace: TabBar(
                            indicatorColor: ColorResources.heartColor,
                            indicatorWeight: 3.0,
                            isScrollable: false,
                            labelColor: ColorResources.heartColor,
                            labelStyle: TextStyle(
                              fontSize: 16,
                              color: ColorResources.heartColor,
                              fontFamily: FontResources.bold,
                            ),
                            unselectedLabelColor: ColorResources.darkGreyColor,
                            unselectedLabelStyle: TextStyle(
                              fontSize: 16,
                              color: ColorResources.darkGreyColor,
                              fontFamily: FontResources.bold,
                            ),
                            tabs: [
                              Tab(text: StringResources.about,),
                              Tab(text: StringResources.reviews,)
                            ],
                          ),
                        ),
                        body: TabBarView(
                          children: <Widget>[
                            //region about tab content
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                              width: MediaQuery.of(context).size.width,
                              child: Column(
                                children: [
                                  SizedBox(
                                    width: 10.0,
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.location_on_outlined,
                                        color: ColorResources.heartColor,
                                        size: 24.0,
                                        semanticLabel: 'Restaurant address.',
                                      ),
                                      SizedBox(
                                        width: 10.0,
                                      ),
                                      Text(
                                        widget.restaurantModel.address != null ? widget.restaurantModel.address : "",
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: ColorResources.darkGreyColor,
                                          fontFamily: FontResources.regular,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  Image.asset(
                                    widget.restaurantModel.locationImagePath,
                                    fit: BoxFit.cover,
                                    width: MediaQuery.of(context).size.width * 0.9,
                                    height: MediaQuery.of(context).size.height * 0.25,
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                ],
                              ),
                            ),
                            //endregion

                            //region review tab content
                            Container(
                              child: FutureBuilder(
                                future: readJson("URL", "reviewData"),
                                builder: (context, snapshot) {
                                  if(snapshot.hasData){
                                    return ListView.builder(
                                      shrinkWrap: true,
                                      padding: EdgeInsets.symmetric(horizontal: 5.0),
                                      scrollDirection: Axis.vertical,
                                      itemCount: snapshot.data.length,
                                      itemBuilder: (BuildContext context, int index) {
                                        Review review = snapshot.data[index];
                                        return reviewWidget(context, review.name, review.reviewText, review.reviewDate, review.review,);
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
                            ),
                            //endregion
                          ],
                        ),
                      ),
                  ),
                ),
                //endregion
              ],
            ),
          ),
        ),
      ),
    );
  }
}
