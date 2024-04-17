import 'dart:io';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/models/slider_model.dart';
import 'package:food_delivery_app/resources/color_resources.dart';
import 'package:food_delivery_app/resources/string_resources.dart';
import 'package:food_delivery_app/resources/font_resources.dart';
import 'package:food_delivery_app/ui/screens/location_screen.dart';
import 'package:food_delivery_app/util/util.dart';
import 'package:food_delivery_app/widgets/custom_widgets.dart';

class TutorialScreen extends StatefulWidget {
  @override
  _TutorialScreenState createState() => _TutorialScreenState();
}

class _TutorialScreenState extends State<TutorialScreen> {
  List<SliderModel> slides = new List<SliderModel>();

  int currentState = 0;

  PageController pageController = new PageController(initialPage: 0);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SliderModel sliderModel = new SliderModel();
    slides = sliderModel.getSlides();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorResources.whiteColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height - 70,
                //region page view builder
                child: PageView.builder(
                    controller: pageController,
                    onPageChanged: (val) {
                      setState(() {
                        currentState = val;
                      });
                    },
                    itemCount: slides.length,
                    itemBuilder: (context, index) {
                      return SlideTile(
                        imagePath: slides[index].getImageAssetPath(),
                        title: slides[index].getTitle(),
                        desc: slides[index].getDesc(),
                      );
                    }),
                //endregion
              ),
            ],
          ),
        ),
      ),
      //region bottom sheet(bottom tabs)
      bottomSheet: currentState != slides.length - 1
      //region bottom container to show texts and page indicator
          ? Container(
              color: ColorResources.smokeWhiteColor,
              height: Platform.isIOS ? 70 : 60,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //region SKIP text
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                    child: TextButton(
                      style: ButtonStyle(
                        overlayColor: MaterialStateProperty.all(ColorResources.lightGreyColor),
                      ),
                      onPressed: () {
                        pageController.animateToPage(slides.length - 1, duration: Duration(milliseconds: 400), curve: Curves.linear);
                      },
                      child: Text(
                        StringResources.skip,
                        style: TextStyle(
                          fontSize: 16,
                          color: ColorResources.darkGreyColor,
                          fontFamily: FontResources.regular,
                        ),
                      ),
                    ),
                  ),
                  //endregion

                  //region page indicator
                  Row(
                    children: [
                      for (int i = 0; i < slides.length; i++)
                        currentState == i ? pageIndexIndicator(true) : pageIndexIndicator(false)
                    ],
                  ),
                  //endregion

                  //region NEXT text
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                    child: TextButton(
                      style: ButtonStyle(
                        overlayColor: MaterialStateProperty.all(ColorResources.lightGreyColor),
                      ),
                      onPressed: () {
                        pageController.animateToPage(currentState + 1, duration: Duration(milliseconds: 400), curve: Curves.linear);
                      },
                      child: Text(
                        StringResources.next,
                        style: TextStyle(
                          fontSize: 16,
                          color: ColorResources.darkGreyColor,
                          fontFamily: FontResources.regular,
                        ),
                      ),
                    ),
                  ),
                  //endregion
                ],
              ),
            )
      //endregion

      //region get started text
          : InkWell(
              onTap: () {
                addBoolToSF('tutorial', true);
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => LocationScreen()));
              },
              child: Container(
                color: Colors.blue,
                width: MediaQuery.of(context).size.width,
                height: Platform.isIOS ? 70 : 60,
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Center(
                  child: Text(
                    StringResources.getStarted,
                    style: TextStyle(
                      fontSize: 16,
                      color: ColorResources.whiteColor,
                      fontFamily: FontResources.regular,
                    ),
                  ),
                ),
              ),
            ),
      //endregion
      //endregion
    );
  }
}
