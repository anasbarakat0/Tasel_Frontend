// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class SignupProviderModel {
  String name;
  String latitude;
  String longitude;
  String phoneNumbers;
  String landlines;
  String address;
  String email;
  String whatsappNumber;
  String instagramAccount;
  String instagramUsername;
  String facebookPage;
  String facebookUsername;
  String category;
  String password;
  SignupProviderModel({
    required this.name,
    required this.latitude,
    required this.longitude,
    required this.phoneNumbers,
    required this.landlines,
    required this.address,
    required this.email,
    required this.whatsappNumber,
    required this.instagramAccount,
    required this.instagramUsername,
    required this.facebookPage,
    required this.facebookUsername,
    required this.category,
    required this.password,
  });

  SignupProviderModel copyWith({
    String? name,
    String? latitude,
    String? longitude,
    String? phoneNumbers,
    String? landlines,
    String? address,
    String? email,
    String? whatsappNumber,
    String? instagramAccount,
    String? instagramUsername,
    String? facebookPage,
    String? facebookUsername,
    String? category,
    String? password,
  }) {
    return SignupProviderModel(
      name: name ?? this.name,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      phoneNumbers: phoneNumbers ?? this.phoneNumbers,
      landlines: landlines ?? this.landlines,
      address: address ?? this.address,
      email: email ?? this.email,
      whatsappNumber: whatsappNumber ?? this.whatsappNumber,
      instagramAccount: instagramAccount ?? this.instagramAccount,
      instagramUsername: instagramUsername ?? this.instagramUsername,
      facebookPage: facebookPage ?? this.facebookPage,
      facebookUsername: facebookUsername ?? this.facebookUsername,
      category: category ?? this.category,
      password: password ?? this.password,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'latitude': latitude,
      'longitude': longitude,
      'phoneNumbers': phoneNumbers,
      'landlines': landlines,
      'address': address,
      'email': email,
      'whatsappNumber': whatsappNumber,
      'instagramAccount': instagramAccount,
      'instagramUsername': instagramUsername,
      'facebookPage': facebookPage,
      'facebookUsername': facebookUsername,
      'category': category,
      'password': password,
    };
  }

  factory SignupProviderModel.fromMap(Map<String, dynamic> map) {
    return SignupProviderModel(
      name: map['name'] as String,
      latitude: map['latitude'] as String,
      longitude: map['longitude'] as String,
      phoneNumbers: map['phoneNumbers'] as String,
      landlines: map['landlines'] as String,
      address: map['address'] as String,
      email: map['email'] as String,
      whatsappNumber: map['whatsappNumber'] as String,
      instagramAccount: map['instagramAccount'] as String,
      instagramUsername: map['instagramUsername'] as String,
      facebookPage: map['facebookPage'] as String,
      facebookUsername: map['facebookUsername'] as String,
      category: map['category'] as String,
      password: map['password'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory SignupProviderModel.fromJson(String source) =>
      SignupProviderModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'SignupProviderModel(name: $name, latitude: $latitude, longitude: $longitude, phoneNumbers: $phoneNumbers, landlines: $landlines, address: $address, email: $email, whatsappNumber: $whatsappNumber, instagramAccount: $instagramAccount, instagramUsername: $instagramUsername, facebookPage: $facebookPage, facebookUsername: $facebookUsername, category: $category, password: $password)';
  }

  @override
  bool operator ==(covariant SignupProviderModel other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.latitude == latitude &&
        other.longitude == longitude &&
        other.phoneNumbers == phoneNumbers &&
        other.landlines == landlines &&
        other.address == address &&
        other.email == email &&
        other.whatsappNumber == whatsappNumber &&
        other.instagramAccount == instagramAccount &&
        other.instagramUsername == instagramUsername &&
        other.facebookPage == facebookPage &&
        other.facebookUsername == facebookUsername &&
        other.category == category &&
        other.password == password;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        latitude.hashCode ^
        longitude.hashCode ^
        phoneNumbers.hashCode ^
        landlines.hashCode ^
        address.hashCode ^
        email.hashCode ^
        whatsappNumber.hashCode ^
        instagramAccount.hashCode ^
        instagramUsername.hashCode ^
        facebookPage.hashCode ^
        facebookUsername.hashCode ^
        category.hashCode ^
        password.hashCode;
  }
}
