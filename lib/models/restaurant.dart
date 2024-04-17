import 'category.dart';

class RestaurantModel {
  String restaurantId;
  String imagePath;
  String locationImagePath;
  String title;
  String address;
  String latitude;
  String longitude;
  String delivery;
  String deliveryFee;
  String averageReview;
  String reviewPeopleCount;
  List<Category> categories;

  RestaurantModel({
    this.restaurantId,
    this.imagePath,
    this.locationImagePath,
    this.title,
    this.address,
    this.latitude,
    this.longitude,
    this.delivery,
    this.deliveryFee,
    this.averageReview,
    this.reviewPeopleCount,
    this.categories,
  });

  factory RestaurantModel.fromJson(Map<String, dynamic> json) => RestaurantModel(
    restaurantId: json["restaurantId"],
    imagePath: json["imagePath"],
    locationImagePath: json["locationImagePath"],
    title: json["title"],
    address: json["address"],
    latitude: json["latitude"],
    longitude: json["longitude"],
    delivery: json["delivery"],
    deliveryFee: json["deliveryFee"],
    averageReview: json["averageReview"],
    reviewPeopleCount: json["reviewPeopleCount"],
    categories: List<Category>.from(json["categories"].map((x) => Category.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "restaurantId": restaurantId,
    "imagePath": imagePath,
    "locationImagePath": locationImagePath,
    "title": title,
    "address": address,
    "latitude": latitude,
    "longitude": longitude,
    "delivery": delivery,
    "deliveryFee": deliveryFee,
    "averageReview": averageReview,
    "reviewPeopleCount": reviewPeopleCount,
    "categories": List<dynamic>.from(categories.map((x) => x.toJson())),
  };
}