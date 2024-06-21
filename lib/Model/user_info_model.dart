// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserInfo {
  String id;
  String name;
  int phone;
  String email;
  String address;
  UserInfo({
    required this.id,
    required this.name,
    required this.phone,
    required this.email,
    required this.address,
  });

  UserInfo copyWith({
    String? id,
    String? name,
    int? phone,
    String? email,
    String? address,
  }) {
    return UserInfo(
      id: id ?? this.id,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      address: address ?? this.address,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'phone': phone,
      'email': email,
      'address': address,
    };
  }

  factory UserInfo.fromMap(Map<String, dynamic> map) {
    return UserInfo(
      id: map['_id'] as String,
      name: map['name'] as String,
      phone: map['phone'] as int,
      email: map['email'] as String,
      address: map['address'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserInfo.fromJson(String source) =>
      UserInfo.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserInfo(id: $id, name: $name, phone: $phone, email: $email, address: $address)';
  }

  @override
  bool operator ==(covariant UserInfo other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.phone == phone &&
        other.email == email &&
        other.address == address;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        phone.hashCode ^
        email.hashCode ^
        address.hashCode;
  }
}
