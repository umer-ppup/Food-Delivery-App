class Review {
  String name;
  String reviewText;
  String reviewDate;
  String review;

  Review({
    this.name,
    this.reviewText,
    this.reviewDate,
    this.review,
  });

  factory Review.fromJson(Map<String, dynamic> json) => Review(
    name: json["name"],
    reviewText: json["reviewText"],
    reviewDate: json["reviewDate"],
    review: json["review"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "reviewText": reviewText,
    "reviewDate": reviewDate,
    "review": review,
  };
}