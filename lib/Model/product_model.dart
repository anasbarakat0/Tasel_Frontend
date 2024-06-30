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

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'picture': picture,
      'name': name,
      'price': price,
      'description': description,
      'storeId': storeId,
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      id: map['id'] ?? '',
      picture: map['picture'] ?? '',
      name: map['name'] ?? '',
      price: (map['price'] is int)
          ? (map['price'] as int).toDouble()
          : map['price'] ?? 0.0,
      description: map['description'] ?? '',
      storeId: map['storeId'] ?? '',
    );
  }
}
