import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:food_delivery_app/models/address_model.dart';
import 'package:food_delivery_app/models/order_model.dart';
import 'package:food_delivery_app/models/restaurant.dart';
import 'package:food_delivery_app/models/review.dart';
import 'package:food_delivery_app/resources/string_resources.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as https;
import 'package:path_provider/path_provider.dart';

//region function to store a boolean into shared preferences
addBoolToSF(String key, bool c) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setBool(key, c);
}
//endregion

//region function to read a boolean from shared preferences
Future<bool> getBoolValuesSF(String key) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool boolValue = prefs.getBool(key);
  return boolValue;
}
//endregion

//region function to check key contains inside shared preferences
Future<bool> checkKey(String key) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool b = false;
  if(prefs.containsKey(key)){
    b = true;
  }
  return b;
}
//endregion

//region api call function to fetch json data
Future readJson(String url, String type) async {
  if (StringResources.isOnline) {
    return https.get(Uri.parse(url)).then((https.Response response) {
      final int statusCode = response.statusCode;

      if (statusCode < 200 || statusCode > 400 || json == null) {
        throw new Exception("Error while fetching data");
      }

      if (type == "restaurantData") {
        return RestaurantModel.fromJson(json.decode(response.body));
      } else if (type == "orderData") {
        return OrderModel.fromJson(json.decode(response.body));
      } else if (type == "addressData") {
        return AddressModel.fromJson(json.decode(response.body));
      } else if (type == "reviewData") {
        return Review.fromJson(json.decode(response.body));
      }
    });
  }
  else {
    List dataList;

    final String response = await rootBundle.loadString("asset/data.json");
    var data = await json.decode(response);

    if (type == "restaurantData") {
      var result = data["restaurantData"] as List;
      dataList = result
          .map<RestaurantModel>((json) => RestaurantModel.fromJson(json))
          .toList();
    } else if (type == "orderData") {
      var result = data["orderData"] as List;
      dataList = result
          .map<OrderModel>((json) => OrderModel.fromJson(json))
          .toList();
    } else if (type == "addressData") {
      var result = data["addressData"] as List;
      dataList = result
          .map<AddressModel>((json) => AddressModel.fromJson(json))
          .toList();
    } else if (type == "reviewData") {
      var result = data["reviewData"] as List;
      dataList = result
          .map<Review>((json) => Review.fromJson(json))
          .toList();
    }

    return dataList;
  }
}
//endregion

//region longin post request function
Future loginPostRequest(String url, {Map body}) async {
  if(StringResources.isOnline){
    return https.post(Uri.parse(url), body: body).then((https.Response response) {
      final int statusCode = response.statusCode;

      if (statusCode < 200 || statusCode > 400 || json == null) {
        throw new Exception("Error while fetching data");
      }
      return response.body;
    });
  }else{
    // Secrets.prefs = await SharedPreferences.getInstance();
    // Secrets.prefs.setString('userInfo',body.toString());
  }
}
//endregion

//region signUp post request function
Future signUpPostRequest(String url, {Map body}) async {
  if(StringResources.isOnline){
    return https.post(Uri.parse(url), body: body).then((https.Response response) {
      final int statusCode = response.statusCode;

      if (statusCode < 200 || statusCode > 400 || json == null) {
        throw new Exception("Error while fetching data");
      }
      return response.body;
    });
  }else{
    // Secrets.prefs = await SharedPreferences.getInstance();
    // Secrets.prefs.setString('userInfo',body.toString());
  }
}
//endregion

//region delivery fee string making function
String getDeliveryFeeString(String fee, String currency) {
  String s = "";
  if(int.parse(fee) == 0){
    s = "Free Delivery";
  }
  else{
    s = "Delivery Fee: $currency $fee";
  }
  return s;
}
//endregion

//region fee string making function
String getRupeesString(String fee) {
  String s = "";
  if(int.parse(fee) == 0){
    s = "Free";
  }
  else{
    s = "Rs. $fee";
  }
  return s;
}
//endregion

//region input focus change function
void fieldFocusChange(BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
  currentFocus.unfocus();
  FocusScope.of(context).requestFocus(nextFocus);
}
//endregion

//region storage write and read code
class Storage {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/user.txt');
  }

  Future<String> readData() async {
    try {
      final file = await _localFile;

      // Read the file
      String contents = await file.readAsString();

      return contents;
    } catch (e) {
      // If encountering an error, return 0
      return "";
    }
  }

  Future<File> writeData(String data) async {
    final file = await _localFile;

    // Write the file
    return file.writeAsString(data);
  }
}
//endregion
