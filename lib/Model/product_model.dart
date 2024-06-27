import 'dart:convert';

ProductModel productModelFromMap(String str) =>
    ProductModel.fromMap(json.decode(str));

String productModelToMap(ProductModel data) => json.encode(data.toMap());

class ProductModel {
  String id;
  String picture;
  String name;
  double price;
  String description;
  String storeId;

  ProductModel({
    required this.id,
    required this.picture,
    required this.name,
    required this.price,
    required this.description,
    required this.storeId,
  });

  factory ProductModel.fromMap(Map<String, dynamic> json) => ProductModel(
        id: json["_id"],
        picture: json["picture"],
        name: json["name"],
        price: json["price"],
        description: json["description"],
        storeId: json["storeId"],
      );

  Map<String, dynamic> toMap() => {
        "_id": id,
        "picture": picture,
        "name": name,
        "price": price,
        "description": description,
        "storeId": storeId,
      };
}
