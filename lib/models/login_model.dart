class Login{
  String id;
  String email;
  String password;

  Login({this.id, this.email, this.password});

  factory Login.fromJson(Map<String, dynamic> json) => Login(
    id: json["id"],
    email: json["email"],
    password: json["password"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "email": email,
    "password": password,
  };
}