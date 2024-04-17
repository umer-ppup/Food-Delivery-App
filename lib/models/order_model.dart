class OrderModel{
  int id;
  String restaurantName;
  String dateTime;
  String price;

  OrderModel({this.id, this.restaurantName, this.dateTime, this.price});

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: int.parse(json["id"]),
      restaurantName: json["restaurantName"],
      dateTime: json["dateTime"],
      price: json["price"]
    );
  }
}