class Product{
  Product({
    this.imagePath,
    this.title,
    this.subTitle,
    this.quantity,
    this.amount,
  });

  String imagePath;
  String title;
  String subTitle;
  String quantity;
  String amount;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    imagePath: json["imagePath"],
    title: json["title"],
    subTitle: json["subTitle"],
    quantity: json["quantity"],
    amount: json["amount"],
  );

  Map<String, dynamic> toJson() => {
    "imagePath": imagePath,
    "title": title,
    "subTitle": subTitle,
    "quantity": quantity,
    "amount": amount,
  };
}