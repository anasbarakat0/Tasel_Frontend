import 'dart:convert';

UpdateUserModel updateUserModelFromMap(String str) =>
    UpdateUserModel.fromMap(json.decode(str));

String updateUserModelToMap(UpdateUserModel data) => json.encode(data.toMap());

class UpdateUserModel {
  String name;
  String phone;
  String address;

  UpdateUserModel({
    required this.name,
    required this.phone,
    required this.address,
  });

  factory UpdateUserModel.fromMap(Map<String, dynamic> json) => UpdateUserModel(
        name: json["name"],
        phone: json["phone"],
        address: json["address"],
      );

  Map<String, dynamic> toMap() => {
        "name": name,
        "phone": phone,
        "address": address,
      };
}
