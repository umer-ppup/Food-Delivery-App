class User{
  String id;
  String name;
  String email;
  String phoneNumber;
  String password;

  User({this.id, this.name, this.email, this.phoneNumber, this.password});

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    phoneNumber: json["phoneNumber"],
    password: json["password"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "phoneNumber": phoneNumber,
    "password": password,
  };
}