import 'package:flutter/material.dart';
import 'package:food_delivery_app/models/restaurant.dart';
import 'package:food_delivery_app/resources/color_resources.dart';
import 'package:food_delivery_app/resources/font_resources.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_delivery_app/resources/image_resources.dart';
import 'package:food_delivery_app/resources/string_resources.dart';
import 'package:food_delivery_app/ui/screens/address_screen.dart';
import 'package:food_delivery_app/ui/screens/cart_screen.dart';
import 'package:food_delivery_app/ui/screens/detail_screen.dart';
import 'package:food_delivery_app/ui/screens/login_screen.dart';
import 'package:food_delivery_app/ui/screens/order_history_screen.dart';
import 'package:food_delivery_app/ui/screens/payment_screen.dart';
import 'package:food_delivery_app/ui/screens/profile_screen.dart';
import 'package:food_delivery_app/ui/screens/wishlist_screen.dart';
import 'package:food_delivery_app/util/util.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:progress_dialog/progress_dialog.dart';

//region this is a widget to indicate page index i.e., in the tutorial screen
Widget pageIndexIndicator(bool isCurrent) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 2.0),
    width: isCurrent ? 16.0 : 8.0,
    height: isCurrent ? 16.0 : 8.0,
    decoration: BoxDecoration(
      color: isCurrent ? ColorResources.darkGreyColor : ColorResources.lightGreyColor,
      borderRadius: BorderRadius.circular(12.0),
    ),
  );
}
//endregion

//region widget for sliding page content
// ignore: must_be_immutable
class SlideTile extends StatelessWidget {
  String imagePath, title, desc;

  SlideTile({this.imagePath, this.title, this.desc});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height * 0.5,
              width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                child: Image.asset(imagePath, fit: BoxFit.contain,)),
            SizedBox(
              height: 40,
            ),
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                color: ColorResources.darkGreyColor,
                fontFamily: FontResources.bold,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 40.0),
              child: Text(
                desc,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: ColorResources.darkGreyColor,
                  fontFamily: FontResources.regular,
                ),
              ),
            ),
            SizedBox(
              height: 40,
            ),
          ],
        ),
      ),
    );
  }
}
//endregion

//region widget for bold text
Widget textBold(String text, TextAlign textAlign){
  return Text(
    text,
    textAlign: textAlign,
    style: TextStyle(
      fontSize: 16,
      color: ColorResources.darkGreyColor,
      fontFamily: FontResources.bold,
    ),
  );
}
//endregion

//region widget for regular text
Widget textRegular(String text, TextAlign textAlign){
  return Text(
    text,
    textAlign: textAlign,
    style: TextStyle(
      fontSize: 16,
      color: ColorResources.darkGreyColor,
      fontFamily: FontResources.regular,
    ),
  );
}
//endregion

//region class for button
class DefaultButton extends StatelessWidget {
  const DefaultButton({
    Key key,
    this.text,
    this.onPress,
  }) : super(key: key);

  final String text;
  final Function onPress;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56.0,
      child: FlatButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        color: ColorResources.darkGreyColor,
        onPressed: onPress,
        child: Text(
          text,
          style: TextStyle(
            fontSize: 16,
            color: ColorResources.whiteColor,
            fontFamily: FontResources.bold,
          )
        ),
      ),
    );
  }
}
//endregion

//region a widget class to show OR with divider line
class OrDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: size.height * 0.02),
      width: size.width * 0.8,
      child: Row(
        children: [
          Expanded(
            child: Divider(
              color: ColorResources.darkGreyColor,
              height: 2,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              "OR",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: ColorResources.darkGreyColor,
                fontFamily: FontResources.bold,
              ),
            ),
          ),
          Expanded(
            child: Divider(
              color: ColorResources.darkGreyColor,
              height: 2,
            ),
          ),
        ],
      ),
    );
  }
}
//endregion

//region this is a widget class to show social platform icons
class SocialCardWidget extends StatelessWidget {
  const SocialCardWidget({
    Key key,
    this.icon,
    this.onPressed,
  }) : super(key: key);

  final String icon;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10.0),
        padding: EdgeInsets.all(12.0),
        height: 50.0,
        width: 50.0,
        decoration: BoxDecoration(
          color: ColorResources.smokeWhiteColor,
          shape: BoxShape.circle,
        ),
        child: SvgPicture.asset(icon),
      ),
    );
  }
}
//endregion

//region this is a widget for input field for forms
Widget inputField(FocusNode focusNode, TextEditingController tController, TextInputAction action, TextInputType textType, String label, IconData icon, String validatorTxt, TextEditingController tControllerPassword, BuildContext context,
    FocusNode nameFocusNode, FocusNode emailFocusNode, FocusNode phoneNumberFocusNode, FocusNode passwordFocusNode, FocusNode cPasswordFocusNode){
  return TextFormField(
    focusNode: focusNode,
    controller: tController,
    textInputAction: action,
    autofocus: false,
    keyboardType: textType,
    obscureText: validatorTxt == 'password' || validatorTxt == 're-enter' ? true : false,
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
      labelText: label,
      labelStyle: TextStyle(
        fontSize: 16,
        color: ColorResources.darkGreyColor,
        fontFamily: FontResources.regular,
      ),
      floatingLabelBehavior: FloatingLabelBehavior.auto,
      suffixIcon: Icon(icon, color: ColorResources.darkGreyColor,),
    ),
    validator: (value){
      if(validatorTxt == 'name'){
        if (value.isEmpty) {
          return 'Please enter your name.';
        }
        else {
          return null;
        }
      }
      else if(validatorTxt == 'email'){
        if (value.isEmpty) {
          return 'Please enter an email address.';
        } else if (!StringResources.kEmailValidatorRegExp.hasMatch(value)) {
          return 'Please enter valid email address.';
        } else {
          return null;
        }
      }
      else if(validatorTxt == 'phone_number'){
        if (value.isEmpty) {
          return 'Please enter your phone number.';
        } else if (!StringResources.kPhoneValidatorRegExp.hasMatch(value)) {
          return 'Please enter valid phone number.';
        } else {
          return null;
        }
      }
      else if(validatorTxt == 'password'){
        if(value.isEmpty)
        {
          return 'Please enter password.';
        }
        else if (value.length < 8)
        {
          return 'Password cannot less than 8 characters.';
        }
        else
        {
          return null;
        }
      }
      else if(validatorTxt == 're-enter'){
        if(value.isEmpty)
        {
          return 'Please enter password.';
        }
        else if (tControllerPassword.text != tController.text)
        {
          return 'Please enter same password.';
        }
        else
        {
          return null;
        }
      }
      else{
        return null;
      }
    },
    onSaved: (value){
      if(validatorTxt == 'name'){
        StringResources.name = value;
      }
      else if(validatorTxt == 'email'){
        StringResources.email = value;
      }
      else if(validatorTxt == 'phone_number'){
        StringResources.phoneNumber = value;
      }
      else if(validatorTxt == 'password'){
        StringResources.password = value;
      }
      else if(validatorTxt == 're-enter'){
        StringResources.confirmPassword = value;
      }
    },
    onFieldSubmitted: (_){
      if(validatorTxt == 'name'){
        fieldFocusChange(context, nameFocusNode, emailFocusNode);
      }
      else if(validatorTxt == 'email'){
        fieldFocusChange(context, emailFocusNode, phoneNumberFocusNode);
      }
      else if(validatorTxt == 'phone_number'){
        fieldFocusChange(context, phoneNumberFocusNode, passwordFocusNode);
      }
      else if(validatorTxt == 'password'){
        fieldFocusChange(context, passwordFocusNode, cPasswordFocusNode);
      }
    },
  );
}
//endregion

//region this is a widget for profile header
Widget profileHeaderWidget() {
  return Container(
    height: 150.0,
    width: 150.0,
    child: Stack(
      fit: StackFit.expand,
      overflow: Overflow.visible,
      children: [
        CircleAvatar(
          backgroundImage: AssetImage(ImageResources.profile),
        ),
        Positioned(
            right: -16,
            bottom: 0,
            child: SizedBox(
              height: 60,
              width: 60,
              child: FlatButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50.0),
                  side: BorderSide(color: ColorResources.whiteColor, width: 5.0),
                ),
                color: ColorResources.smokeWhiteColor,
                child: SvgPicture.asset(ImageResources.camera, color: ColorResources.darkGreyColor),
                onPressed: () {},
              ),
            ))
      ],
    ),
  );
}
//endregion

//region this is a widget for profile menu
Widget profileMenuWidget(BuildContext context, String text, String textValue, IconData icon, VoidCallback press) {
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
    margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
    padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
    child: Row(
      children: [
        Icon(
          icon,
          size: 32.0,
          color: ColorResources.darkGreyColor,
        ),
        SizedBox(width: 20),
        Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  text,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 16,
                    color: ColorResources.darkGreyColor,
                    fontFamily: FontResources.bold,
                  ),
                ),
                SizedBox(
                  height: 5.0,
                ),
                Text(
                  textValue,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 16,
                    color: ColorResources.darkGreyColor,
                    fontFamily: FontResources.regular,
                  ),
                )
              ]
            )
        )
      ],
    ),
  );

}
//endregion

//region this is a widget for product list of a restaurant
Widget productWidget(BuildContext context, String imagePath, String title, String subTitle, String amount){
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
    margin: EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 10.0),
    padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
    child: Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title != null ? title : "",
              style: TextStyle(
                fontSize: 16,
                color: ColorResources.darkGreyColor,
                fontFamily: FontResources.bold,
              ),
            ),
            SizedBox(
              height: 5.0,
            ),
            Text(
              subTitle != null ? subTitle : "",
              style: TextStyle(
                fontSize: 16,
                color: ColorResources.darkGreyColor,
                fontFamily: FontResources.regular,
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(
              getRupeesString(amount),
              style: TextStyle(
                fontSize: 16,
                color: ColorResources.darkGreyColor,
                fontFamily: FontResources.regular,
              ),
            ),
          ],
        ),
        Spacer(),
        ClipRRect(
          borderRadius: BorderRadius.circular(7.0),
          child: Image.asset(
            imagePath,
            fit: BoxFit.cover,
            width: 70.0,
            height: 70.0,
          ),
        ),
      ],
    ),
  );
}
//endregion

//region this is a widget for reviews list of a restaurant
Widget reviewWidget(BuildContext context, String name, String reviewText, String dateText, String review){
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
    padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              name != null ? name : "",
              style: TextStyle(
                fontSize: 16,
                color: ColorResources.darkGreyColor,
                fontFamily: FontResources.bold,
              ),
            ),
            Spacer(),
            RatingBarIndicator(
              rating: double.parse(review),
              itemBuilder: (context, index) => Icon(
                Icons.star,
                color: ColorResources.heartColor,
              ),
              itemCount: 5,
              itemSize: 18.0,
              direction: Axis.horizontal,
            ),
          ],
        ),
        SizedBox(
          height: 5.0,
        ),
        Text(
          reviewText != null ? reviewText : "",
          style: TextStyle(
            fontSize: 16,
            color: ColorResources.darkGreyColor,
            fontFamily: FontResources.regular,
          ),
        ),
        SizedBox(
          height: 10.0,
        ),
        Text(
          dateText != null ? dateText : "",
          style: TextStyle(
            fontSize: 16,
            color: ColorResources.darkGreyColor,
            fontFamily: FontResources.regular,
          ),
        ),
      ],
    ),
  );
}
//endregion

//region this is a widget for navigation drawer
class DrawerWidget extends StatefulWidget {
  @override
  _DrawerWidgetState createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  bool login = false;
  bool logout = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkKey('login').then((value) async {
      if (value == false) {
        setState(() {
          logout = false;
          login = true;
        });
      }
      else{
        if (!await getBoolValuesSF('login')) {
          setState(() {
            logout = false;
            login = true;
          });
        } else {
          setState(() {
            logout = true;
            login = false;
          });
        }
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    final ProgressDialog pr = ProgressDialog(context,type: ProgressDialogType.Normal, isDismissible: false, showLogs: false);
    return Container(
      width: MediaQuery.of(context).size.width * 0.65,
      child: Drawer(
        child: Container(
          color: ColorResources.whiteColor,
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              createDrawerHeader(),
              Visibility(
                visible: logout,
                child: InkWell(
                  onTap: (){
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProfileScreen(),
                      ),
                    );
                  },
                  child: ListTile(
                    leading: Icon(Icons.person, color: ColorResources.darkGreyColor,),
                    title: Text(
                      'Profile',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 16,
                        color: ColorResources.darkGreyColor,
                        fontFamily: FontResources.regular,
                      ),
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: (){
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddressScreen(),
                    ),
                  );
                },
                child: ListTile(
                  leading: Icon(Icons.home, color: ColorResources.darkGreyColor,),
                  title: Text(
                    'Addresses',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 16,
                      color: ColorResources.darkGreyColor,
                      fontFamily: FontResources.regular,
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: (){
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => WishlistScreen(),
                    ),
                  );
                },
                child: ListTile(
                  leading: Icon(
                    Icons.favorite_rounded,
                    color: ColorResources.darkGreyColor,
                  ),
                  title: Text(
                    'Wishlist',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 16,
                      color: ColorResources.darkGreyColor,
                      fontFamily: FontResources.regular,
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: (){
                  Navigator.pop(context);
                  Navigator.push(context, MaterialPageRoute(builder: (context) => CartScreen(restaurantModel: new RestaurantModel(),),),
                  );
                },
                child: ListTile(
                  leading: Icon(Icons.shopping_cart_rounded, color: ColorResources.darkGreyColor,),
                  title: Text(
                    'Cart',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 16,
                      color: ColorResources.darkGreyColor,
                      fontFamily: FontResources.regular,
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: (){
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => OrderHistoryScreen(),
                    ),
                  );
                },
                child: ListTile(
                  leading: Icon(Icons.history_rounded, color: ColorResources.darkGreyColor,),
                  title: Text(
                    'Order History',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 16,
                      color: ColorResources.darkGreyColor,
                      fontFamily: FontResources.regular,
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: (){
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PaymentScreen(),
                    ),
                  );
                },
                child: ListTile(
                  leading: Icon(Icons.payment_rounded, color: ColorResources.darkGreyColor,),
                  title: Text(
                    'Payment',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 16,
                      color: ColorResources.darkGreyColor,
                      fontFamily: FontResources.regular,
                    ),
                  ),
                ),
              ),
              Divider(
                color: ColorResources.darkGreyColor,
                //height: 20,
                thickness: 0.2,
                indent: 0,
                endIndent: 0,
              ),
              Visibility(
                visible: login,
                child: InkWell(
                  onTap: (){
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginScreen(),
                      ),
                    );
                  },
                  child: ListTile(
                    leading: Icon(Icons.login, color: ColorResources.darkGreyColor,),
                    title: Text(
                      'Login',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 16,
                        color: ColorResources.darkGreyColor,
                        fontFamily: FontResources.regular,
                      ),
                    ),
                  ),
                ),
              ),
              Visibility(
                visible: logout,
                child: InkWell(
                  onTap: () async {
                    // change app state...
                    await pr.show();
                    await addBoolToSF('login', false);
                    await pr.hide();
                    Navigator.pop(context); // close the drawer
                  },
                  child: ListTile(
                    leading: Icon(Icons.logout, color: ColorResources.darkGreyColor,),
                    title: Text(
                      'Logout',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 16,
                        color: ColorResources.darkGreyColor,
                        fontFamily: FontResources.regular,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
//endregion

//region this is a widget for navigation drawer header
Widget createDrawerHeader() {
  return Container(
    color: ColorResources.whiteColor,
    child: DrawerHeader(
      padding: EdgeInsets.zero,
      margin: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 10.0,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
            child: CircleAvatar(
              radius: 55.0,
              backgroundColor: ColorResources.smokeWhiteColor,
              child: Image.asset(
                "asset/images/atrule_icon.png",
                fit: BoxFit.fill,
              ),
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
            child: textBold('ATRULE Technologies', TextAlign.start),
          ),
        ],
      ),
    ),
  );
}
//endregion

//region this is a widget for searching
Widget searchWidget(BuildContext context, List<RestaurantModel> restaurantModels){
  return GestureDetector(
    onTap: (){
      showSearch(context: context, delegate: Restaurant(restaurantModels: restaurantModels));
    },
    child: Container(
      width: MediaQuery.of(context).size.width * 0.9,
      decoration: BoxDecoration(
        color: ColorResources.smokeWhiteColor,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          IconButton(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onPressed: () {},
            icon: Icon(
              Icons.search,
              color: ColorResources.darkGreyColor,
            ),
          ),
          Text(
            'Search',
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: 16,
              color: ColorResources.darkGreyColor,
              fontFamily: FontResources.regular,
            ),
          ),
        ],
      ),
    ),
  );
}
//endregion

//region delegate class for search functionality
class Restaurant extends SearchDelegate<RestaurantModel> {
  List<RestaurantModel> restaurantModels = new List<RestaurantModel>();
  Restaurant({this.restaurantModels});

  @override
  List<Widget> buildActions(BuildContext context) {
    // TODO: implement buildActions
    return [
      IconButton(
        icon: Icon(Icons.clear, color: ColorResources.darkGreyColor),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return IconButton(
      icon: Icon(Icons.arrow_back, color: ColorResources.darkGreyColor),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    return Center(
      child: ListTile(
        title: Text(
          query,
          style: TextStyle(
            fontSize: 16,
            color: ColorResources.darkGreyColor,
            fontFamily: FontResources.regular,
          ),
        ),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    final myList = query.isEmpty
        ? restaurantModels
        : restaurantModels
        .where((element) =>
        element.title.toLowerCase().contains(query.toLowerCase()))
        .toList();
    return myList.isEmpty
        ? ListTile(
      title: Text(
        "No results found.",
        style: TextStyle(
          fontSize: 16,
          color: ColorResources.darkGreyColor,
          fontFamily: FontResources.regular,
        ),
      ),
    )
        : ListView.builder(
      itemCount: myList.length,
      itemBuilder: (context, index) {
        final RestaurantModel restaurantModel = myList[index];
        return ListTile(
          onTap: () {
            Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (BuildContext context) => DetailScreen(restaurantModel: restaurantModel,)));
            showResults(context);
          },
          title: Text(
            restaurantModel.title,
            style: TextStyle(
              fontSize: 16,
              color: ColorResources.darkGreyColor,
              fontFamily: FontResources.regular,
            ),
          ),
        );
      },
    );
  }
}
//endregion

