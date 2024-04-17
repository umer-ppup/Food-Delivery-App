import 'package:flutter/material.dart';
import 'package:food_delivery_app/models/product.dart';
import 'package:food_delivery_app/resources/color_resources.dart';
import 'package:food_delivery_app/resources/font_resources.dart';
import 'package:food_delivery_app/ui/screens/cart_screen.dart';
import 'package:food_delivery_app/ui/screens/login_screen.dart';
import 'package:food_delivery_app/ui/screens/review_screen.dart';
import 'package:food_delivery_app/widgets/custom_widgets.dart';
import 'package:food_delivery_app/util/util.dart';
import 'package:badges/badges.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:food_delivery_app/models/restaurant.dart';

// ignore: must_be_immutable
class DetailScreen extends StatefulWidget {
  bool visible = false;
  int tap = 0;
  RestaurantModel restaurantModel = new RestaurantModel();
  DetailScreen({this.restaurantModel});

  List<Product> products = new List<Product>();

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(widget.restaurantModel.categories != null){
      for(int cat = 0; cat < widget.restaurantModel.categories.length; cat++){
        for(int pro = 0; pro < widget.restaurantModel.categories[cat].products.length; pro++){
          if(int.parse(widget.restaurantModel.categories[cat].products[pro].quantity) != 0){
            widget.visible = true;
          }
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final ProgressDialog pr = ProgressDialog(context,type: ProgressDialogType.Normal, isDismissible: false, showLogs: false);
    return Scaffold(
      backgroundColor: ColorResources.whiteColor,
      body: Container(
        child: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [

                //region top image with back array and review button stack
                Stack(
                  children: [
                    Image.asset(
                      widget.restaurantModel.imagePath,
                      fit: BoxFit.cover,
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.3,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.3,
                      color: ColorResources.darkGreyColor.withOpacity(0.7),
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
                    Positioned(
                      right: 10.0,
                      top: 10.0,
                      child: GestureDetector(
                        child: Container(
                          padding: EdgeInsets.all(5.0),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: ColorResources.whiteColor,
                          ),
                          child: Icon(
                            Icons.info_outline_rounded,
                            color: ColorResources.darkGreyColor,
                            size: 24.0,
                            semanticLabel: 'Favourite.',
                          ),
                        ),
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => ReviewScreen(restaurantModel: widget.restaurantModel, tab: 0,),),
                          );
                        },
                      ),
                    ),
                    Positioned.fill(
                      child: Align(
                        alignment: Alignment.center,
                        child: Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                widget.restaurantModel.title != null ? widget.restaurantModel.title : "",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontSize: 22,
                                  letterSpacing: 2.0,
                                  color: ColorResources.whiteColor,
                                  fontFamily: FontResources.bold,
                                ),
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.star_border_rounded,
                                    color: ColorResources.whiteColor,
                                    size: 24.0,
                                    semanticLabel: 'Rating icon.',
                                  ),
                                  SizedBox(
                                    width: 5.0,
                                  ),
                                  GestureDetector(
                                    child: Text(
                                      "${widget.restaurantModel.averageReview}(${widget.restaurantModel.reviewPeopleCount})",
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: ColorResources.whiteColor,
                                        fontFamily: FontResources.bold,
                                      ),
                                    ),
                                    onTap: () {
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => ReviewScreen(restaurantModel: widget.restaurantModel, tab: 1,),),
                                      );
                                    },
                                  ),
                                  SizedBox(
                                    width: 10.0,
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 7.0),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        width: 0.0,
                                        color: ColorResources.whiteColor,
                                      ),
                                      borderRadius: BorderRadius.all(Radius.circular(7.0)),
                                      color: ColorResources.whiteColor,
                                    ),
                                    child: Text(
                                      widget.restaurantModel.delivery != null ? widget.restaurantModel.delivery : "",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: ColorResources.darkGreyColor,
                                        fontFamily: FontResources.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              Text(
                                getDeliveryFeeString(widget.restaurantModel.deliveryFee, "Rs."),
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: ColorResources.whiteColor,
                                  fontFamily: FontResources.bold,
                                ),
                              ),

                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                //endregion

                //region tab bar code
                Container(
                  height: MediaQuery.of(context).size.height * 0.7,
                  child: DefaultTabController(
                      length: widget.restaurantModel.categories.length, // length of tabs
                      initialIndex: 0,
                      child: Scaffold(
                        backgroundColor: ColorResources.whiteColor,
                        appBar: AppBar(
                          backgroundColor: ColorResources.whiteColor,
                          elevation: 0.0,
                          automaticallyImplyLeading: false,
                          flexibleSpace: TabBar(
                            indicatorColor: ColorResources.darkGreyColor,
                            indicatorWeight: 3.0,
                            isScrollable: true,
                            labelColor: ColorResources.darkGreyColor,
                            unselectedLabelColor: ColorResources.lightGreyColor,
                            labelStyle: TextStyle(
                              fontSize: 16,
                              color: ColorResources.darkGreyColor,
                              fontFamily: FontResources.bold,
                            ),
                            unselectedLabelStyle: TextStyle(
                              fontSize: 16,
                              color: ColorResources.lightGreyColor,
                              fontFamily: FontResources.bold,
                            ),
                            tabs: List<Widget>.generate(widget.restaurantModel.categories.length, (int index){
                              return new Tab(text: widget.restaurantModel.categories[index].categoryName);
                            }),
                          ),
                        ),
                        body: TabBarView(children: List<Widget>.generate(widget.restaurantModel.categories.length, (int index){
                          return new Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                                  child: Text(
                                    widget.restaurantModel.categories[index].categoryName != null ? widget.restaurantModel.categories[index].categoryName : "",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: ColorResources.darkGreyColor,
                                      fontFamily: FontResources.bold,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    padding: EdgeInsets.fromLTRB(15.0, 5.0, 15.0, 70.0),
                                    scrollDirection: Axis.vertical,
                                    itemCount: widget.restaurantModel.categories[index].products.length,
                                    itemBuilder: (BuildContext context, int index2) {
                                      Product product = widget.restaurantModel.categories[index].products[index2];
                                      return GestureDetector(
                                        child: Badge(
                                          showBadge: int.parse(widget.restaurantModel.categories[index].products[index2].quantity) != 0 ? true : false,
                                          badgeContent: Text(
                                            widget.restaurantModel.categories[index].products[index2].quantity,
                                            style: TextStyle(
                                                color: ColorResources.whiteColor),
                                          ),
                                          badgeColor: ColorResources.heartColor,
                                          child: productWidget(context, product.imagePath, product.title, product.subTitle, product.amount,),
                                        ),
                                        onTap: () async {
                                          if(widget.tap == 0){
                                            await pr.show();
                                            if (!await getBoolValuesSF('login')) {
                                              await pr.hide();
                                              Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()),);
                                            } else {
                                              await pr.hide();
                                              setState(() {
                                                widget.tap = widget.tap + 1;
                                                widget.visible = true;
                                                widget.restaurantModel.categories[index].products[index2].quantity = (int.parse(widget.restaurantModel.categories[index].products[index2].quantity) + 1).toString();
                                              });
                                            }
                                          }
                                          else{
                                            setState(() {
                                              widget.visible = true;
                                              widget.restaurantModel.categories[index].products[index2].quantity = (int.parse(widget.restaurantModel.categories[index].products[index2].quantity) + 1).toString();
                                            });
                                          }
                                        },
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          );

                        }),),
                      ),
                  ),
                ),
                //endregion
              ],
            ),
          ),
        ),
      ),

      //region check cart button
      floatingActionButton: Visibility(
        visible: widget.visible,
        child: FloatingActionButton.extended(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => CartScreen(restaurantModel: widget.restaurantModel,),
              ),
            );
          },
          label: Text(
            'Check Cart',
            style: TextStyle(
              fontSize: 16,
              color: ColorResources.whiteColor,
              fontFamily: FontResources.bold,
            ),
          ),
          icon: Icon(
            Icons.shopping_cart_rounded,
            color: ColorResources.whiteColor,
          ),
          backgroundColor: ColorResources.dodgerBlueColor,
          materialTapTargetSize: MaterialTapTargetSize.padded,
        ),
      ),
      //endregion
    );
  }
}
