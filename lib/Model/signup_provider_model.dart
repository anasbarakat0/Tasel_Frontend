// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';

class SignupProviderModel {
  File image;
  String name;
  double latitude;
  double longitude;
  List<int> phoneNumbers;
  List<int> landlines;
  String areaName;
  String streetName;
  String buildingNameorNumber;
  String floor;
  String email;
  String whatsappNumber;
  String instagramAccount;
  String instagramUsername;
  String facebookPage;
  String facebookUsername;
  String websiteUrl;
  String websiteTitle;
  String category;
  String password;
  SignupProviderModel({
    required this.image,
    required this.name,
    required this.latitude,
    required this.longitude,
    required this.phoneNumbers,
    required this.landlines,
    required this.areaName,
    required this.streetName,
    required this.buildingNameorNumber,
    required this.floor,
    required this.email,
    required this.whatsappNumber,
    required this.instagramAccount,
    required this.instagramUsername,
    required this.facebookPage,
    required this.facebookUsername,
    required this.websiteUrl,
    required this.websiteTitle,
    required this.category,
    required this.password,
  });

  SignupProviderModel copyWith({
    File? image,
    String? name,
    double? latitude,
    double? longitude,
    List<int>? phoneNumbers,
    List<int>? landlines,
    String? areaName,
    String? streetName,
    String? buildingNameorNumber,
    String? floor,
    String? email,
    String? whatsappNumber,
    String? instagramAccount,
    String? instagramUsername,
    String? facebookPage,
    String? facebookUsername,
    String? websiteUrl,
    String? websiteTitle,
    String? category,
    String? password,
  }) {
    return SignupProviderModel(
      image: image ?? this.image,
      name: name ?? this.name,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      phoneNumbers: phoneNumbers ?? this.phoneNumbers,
      landlines: landlines ?? this.landlines,
      areaName: areaName ?? this.areaName,
      streetName: streetName ?? this.streetName,
      buildingNameorNumber: buildingNameorNumber ?? this.buildingNameorNumber,
      floor: floor ?? this.floor,
      email: email ?? this.email,
      whatsappNumber: whatsappNumber ?? this.whatsappNumber,
      instagramAccount: instagramAccount ?? this.instagramAccount,
      instagramUsername: instagramUsername ?? this.instagramUsername,
      facebookPage: facebookPage ?? this.facebookPage,
      facebookUsername: facebookUsername ?? this.facebookUsername,
      websiteUrl: websiteUrl ?? this.websiteUrl,
      websiteTitle: websiteTitle ?? this.websiteTitle,
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
      'areaName': areaName,
      'streetName': streetName,
      'buildingNameorNumber': buildingNameorNumber,
      'floor': floor,
      'email': email,
      'whatsappNumber': whatsappNumber,
      'instagramAccount': instagramAccount,
      'instagramUsername': instagramUsername,
      'facebookPage': facebookPage,
      'facebookUsername': facebookUsername,
      'websiteUrl': websiteUrl,
      'websiteTitle': websiteTitle,
      'category': category,
      'password': password,
    };
  }

  factory SignupProviderModel.fromMap(Map<String, dynamic> map) {
    return SignupProviderModel(
      image: map['image'] as File,
      name: map['name'] as String,
      latitude: map['latitude'] as double,
      longitude: map['longitude'] as double,
      phoneNumbers: List<int>.from((map['phoneNumbers'] as List<int>)),
      landlines: List<int>.from((map['landlines'] as List<int>)),
      areaName: map['areaName'] as String,
      streetName: map['streetName'] as String,
      buildingNameorNumber: map['buildingNameorNumber'] as String,
      floor: map['floor'] as String,
      email: map['email'] as String,
      whatsappNumber: map['whatsappNumber'] as String,
      instagramAccount: map['instagramAccount'] as String,
      instagramUsername: map['instagramUsername'] as String,
      facebookPage: map['facebookPage'] as String,
      facebookUsername: map['facebookUsername'] as String,
      websiteUrl: map['websiteUrl'] as String,
      websiteTitle: map['websiteTitle'] as String,
      category: map['category'] as String,
      password: map['password'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory SignupProviderModel.fromJson(String source) =>
      SignupProviderModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'SignupProviderModel(image: $image, name: $name, latitude: $latitude, longitude: $longitude, phoneNumbers: $phoneNumbers, landlines: $landlines, areaName: $areaName, streetName: $streetName, buildingNameorNumber: $buildingNameorNumber, floor: $floor, email: $email, whatsappNumber: $whatsappNumber, instagramAccount: $instagramAccount, instagramUsername: $instagramUsername, facebookPage: $facebookPage, facebookUsername: $facebookUsername, websiteUrl: $websiteUrl, websiteTitle: $websiteTitle, category: $category, password: $password)';
  }

  @override
  bool operator ==(covariant SignupProviderModel other) {
    if (identical(this, other)) return true;

    return other.image == image &&
        other.name == name &&
        other.latitude == latitude &&
        other.longitude == longitude &&
        listEquals(other.phoneNumbers, phoneNumbers) &&
        listEquals(other.landlines, landlines) &&
        other.areaName == areaName &&
        other.streetName == streetName &&
        other.buildingNameorNumber == buildingNameorNumber &&
        other.floor == floor &&
        other.email == email &&
        other.whatsappNumber == whatsappNumber &&
        other.instagramAccount == instagramAccount &&
        other.instagramUsername == instagramUsername &&
        other.facebookPage == facebookPage &&
        other.facebookUsername == facebookUsername &&
        other.websiteUrl == websiteUrl &&
        other.websiteTitle == websiteTitle &&
        other.category == category &&
        other.password == password;
  }

  @override
  int get hashCode {
    return image.hashCode ^
        name.hashCode ^
        latitude.hashCode ^
        longitude.hashCode ^
        phoneNumbers.hashCode ^
        landlines.hashCode ^
        areaName.hashCode ^
        streetName.hashCode ^
        buildingNameorNumber.hashCode ^
        floor.hashCode ^
        email.hashCode ^
        whatsappNumber.hashCode ^
        instagramAccount.hashCode ^
        instagramUsername.hashCode ^
        facebookPage.hashCode ^
        facebookUsername.hashCode ^
        websiteUrl.hashCode ^
        websiteTitle.hashCode ^
        category.hashCode ^
        password.hashCode;
  }
}
