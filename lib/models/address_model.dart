class AddressModel{
  int field;
  String address;
  double longitude;
  double latitude;

  AddressModel({this.field, this.address, this.longitude, this.latitude});

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      field: int.parse(json["field"]),
      address: json["address"],
      longitude: double.parse(json["longitude"]),
      latitude: double.parse(json["latitude"])
    );
  }

  Map<String, dynamic> toJson() => {
    "field": field,
    "address": address,
    "longitude": longitude,
    "latitude": latitude,
  };
}