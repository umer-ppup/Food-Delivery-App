import 'package:flutter/material.dart';
import 'package:food_delivery_app/resources/color_resources.dart';
import 'package:food_delivery_app/resources/font_resources.dart';
import 'package:food_delivery_app/ui/screens/login_screen.dart';
import 'package:food_delivery_app/util/util.dart';
import 'package:progress_dialog/progress_dialog.dart';

// ignore: must_be_immutable
class AllRestaurantList extends StatefulWidget {
  String imagePath, title, delivery, deliveryFee, averageReview, reviewPeopleCount;
  var color;

  AllRestaurantList({this.imagePath, this.title, this.delivery, this.deliveryFee, this.averageReview, this.reviewPeopleCount, this.color});

  @override
  _AllRestaurantListState createState() => _AllRestaurantListState();
}

class _AllRestaurantListState extends State<AllRestaurantList> {
  @override
  Widget build(BuildContext context) {
    final ProgressDialog pr = ProgressDialog(context, type: ProgressDialogType.Normal, isDismissible: false, showLogs: false);
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          width: 0.0,
          color: ColorResources.smokeWhiteColor,
        ),
        borderRadius: BorderRadius.all(Radius.circular(7.0)),
        color: ColorResources.smokeWhiteColor,
      ),
      margin: EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 10.0),
      //padding: EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            //fit: StackFit.loose,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(7.0),
                child: Image.asset(
                  widget.imagePath,
                  fit: BoxFit.cover,
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.width * 0.4,
                ),
              ),
              Positioned(
                right: 5.0,
                top: 5.0,
                child: GestureDetector(
                  child: Container(
                    padding: EdgeInsets.all(5.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: ColorResources.whiteColor,
                    ),
                    child: Icon(
                      Icons.favorite_rounded,
                      color: widget.color,
                      size: 24.0,
                      semanticLabel: 'Favourite.',
                    ),
                  ),
                  onTap: () async {
                    await pr.show();
                    if (!await getBoolValuesSF('login')) {
                      await pr.hide();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => LoginScreen()),
                      );
                    } else {
                      await pr.hide();
                      setState(() {
                        widget.color = widget.color == ColorResources.darkGreyColor ? ColorResources.heartColor : ColorResources.darkGreyColor;
                      });
                    }
                  },
                ),
              ),
              Positioned(
                left: 5.0,
                bottom: 5.0,
                child: Container(
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
                    widget.delivery != null ? widget.delivery : "",
                    style: TextStyle(
                      fontSize: 14,
                      color: ColorResources.darkGreyColor,
                      fontFamily: FontResources.regular,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget.title != null ? widget.title : "",
                  style: TextStyle(
                    fontSize: 16,
                    color: ColorResources.darkGreyColor,
                    fontFamily: FontResources.bold,
                  ),
                ),
                Spacer(),
                Icon(
                  Icons.star_border_rounded,
                  color: ColorResources.darkGreyColor,
                  size: 24.0,
                  semanticLabel: 'Rating icon.',
                ),
                SizedBox(
                  width: 5.0,
                ),
                Text(
                  "${widget.averageReview}(${widget.reviewPeopleCount})",
                  style: TextStyle(
                    fontSize: 16,
                    color: ColorResources.darkGreyColor,
                    fontFamily: FontResources.bold,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 10.0),
            child: Text(
              getDeliveryFeeString(widget.deliveryFee, "Rs."),
              style: TextStyle(
                fontSize: 14,
                color: ColorResources.darkGreyColor,
                fontFamily: FontResources.regular,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
