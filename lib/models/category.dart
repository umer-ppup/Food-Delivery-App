import 'package:food_delivery_app/models/product.dart';

class Category{
  String categoryId;
  String categoryName;
  List<Product> products;

  Category({
    this.categoryId,
    this.categoryName,
    this.products,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    categoryId: json["categoryId"],
    categoryName: json["categoryName"],
    products: List<Product>.from(json["products"].map((x) => Product.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "categoryId": categoryId,
    "categoryName": categoryName,
    "products": List<dynamic>.from(products.map((x) => x.toJson())),
  };
}