// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class ProviderInfo {
  Address address;
  String profileImage;
  String name;
  double longitude;
  double latitude;
  List<int> phoneNumbers;
  List<int> landlines;
  int whatsappNumber;
  String category;
  String email;
  String facebookPage;
  String facebookUsername;
  String instagramAccount;
  String instagramUsername;
  String websiteUrl;
  ProviderInfo({
    required this.address,
    required this.profileImage,
    required this.name,
    required this.longitude,
    required this.latitude,
    required this.phoneNumbers,
    required this.landlines,
    required this.whatsappNumber,
    required this.category,
    required this.email,
    required this.facebookPage,
    required this.facebookUsername,
    required this.instagramAccount,
    required this.instagramUsername,
    required this.websiteUrl,
  });

  ProviderInfo copyWith({
    Address? address,
    String? profileImage,
    String? name,
    double? longitude,
    double? latitude,
    List<int>? phoneNumbers,
    List<int>? landlines,
    int? whatsappNumber,
    String? category,
    String? email,
    String? facebookPage,
    String? facebookUsername,
    String? instagramAccount,
    String? instagramUsername,
    String? websiteUrl,
  }) {
    return ProviderInfo(
      address: address ?? this.address,
      profileImage: profileImage ?? this.profileImage,
      name: name ?? this.name,
      longitude: longitude ?? this.longitude,
      latitude: latitude ?? this.latitude,
      phoneNumbers: phoneNumbers ?? this.phoneNumbers,
      landlines: landlines ?? this.landlines,
      whatsappNumber: whatsappNumber ?? this.whatsappNumber,
      category: category ?? this.category,
      email: email ?? this.email,
      facebookPage: facebookPage ?? this.facebookPage,
      facebookUsername: facebookUsername ?? this.facebookUsername,
      instagramAccount: instagramAccount ?? this.instagramAccount,
      instagramUsername: instagramUsername ?? this.instagramUsername,
      websiteUrl: websiteUrl ?? this.websiteUrl,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'address': address.toMap(),
      'profileImage': profileImage,
      'name': name,
      'longitude': longitude,
      'latitude': latitude,
      'phoneNumbers': phoneNumbers,
      'landlines': landlines,
      'whatsappNumber': whatsappNumber,
      'category': category,
      'email': email,
      'facebookPage': facebookPage,
      'facebookUsername': facebookUsername,
      'instagramAccount': instagramAccount,
      'instagramUsername': instagramUsername,
    };
  }

  factory ProviderInfo.fromMap(Map<String, dynamic> map) {
    return ProviderInfo(
      address: Address.fromMap(map['address'] as Map<String, dynamic>),
      profileImage: map['profileImage'] as String,
      name: map['name'] as String,
      longitude: map['longitude'] as double,
      latitude: map['latitude'] as double,
      phoneNumbers: List<int>.from(map['phoneNumbers']),
      landlines: List<int>.from(map['landlines']),
      whatsappNumber: map['whatsappNumber'] as int,
      category: map['category'] as String,
      email: map['email'] as String,
      facebookPage: map['facebookPage'] as String,
      facebookUsername: map['facebookUsername'] as String,
      instagramAccount: map['instagramAccount'] as String,
      instagramUsername: map['instagramUsername'] as String,
      websiteUrl: map['WebsiteUrl'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProviderInfo.fromJson(String source) =>
      ProviderInfo.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Provider(address: $address, profileImage: $profileImage, name: $name, longitude: $longitude, latitude: $latitude, phoneNumbers: $phoneNumbers, landlines: $landlines, whatsappNumber: $whatsappNumber, category: $category, email: $email, facebookPage: $facebookPage, facebookUsername: $facebookUsername, instagramAccount: $instagramAccount, instagramUsername: $instagramUsername)';
  }

  @override
  bool operator ==(covariant ProviderInfo other) {
    if (identical(this, other)) return true;

    return other.address == address &&
        other.profileImage == profileImage &&
        other.name == name &&
        other.longitude == longitude &&
        other.latitude == latitude &&
        listEquals(other.phoneNumbers, phoneNumbers) &&
        listEquals(other.landlines, landlines) &&
        other.whatsappNumber == whatsappNumber &&
        other.category == category &&
        other.email == email &&
        other.facebookPage == facebookPage &&
        other.facebookUsername == facebookUsername &&
        other.instagramAccount == instagramAccount &&
        other.instagramUsername == instagramUsername;
  }

  @override
  int get hashCode {
    return address.hashCode ^
        profileImage.hashCode ^
        name.hashCode ^
        longitude.hashCode ^
        latitude.hashCode ^
        phoneNumbers.hashCode ^
        landlines.hashCode ^
        whatsappNumber.hashCode ^
        category.hashCode ^
        email.hashCode ^
        facebookPage.hashCode ^
        facebookUsername.hashCode ^
        instagramAccount.hashCode ^
        instagramUsername.hashCode;
  }
}

class Address {
  String areaName;
  String streetName;
  String buildingNameorNumber;
  String floor;
  Address({
    required this.areaName,
    required this.streetName,
    required this.buildingNameorNumber,
    required this.floor,
  });

  Address copyWith({
    String? areaName,
    String? streetName,
    String? buildingNameorNumber,
    String? floor,
  }) {
    return Address(
      areaName: areaName ?? this.areaName,
      streetName: streetName ?? this.streetName,
      buildingNameorNumber: buildingNameorNumber ?? this.buildingNameorNumber,
      floor: floor ?? this.floor,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'areaName': areaName,
      'streetName': streetName,
      'buildingNameorNumber': buildingNameorNumber,
      'floor': floor,
    };
  }

  factory Address.fromMap(Map<String, dynamic> map) {
    return Address(
      areaName: map['areaName'] as String,
      streetName: map['streetName'] as String,
      buildingNameorNumber: map['buildingNameorNumber'] as String,
      floor: map['floor'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Address.fromJson(String source) =>
      Address.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Address(areaName: $areaName, streetName: $streetName, buildingNameorNumber: $buildingNameorNumber, floor: $floor)';
  }

  @override
  bool operator ==(covariant Address other) {
    if (identical(this, other)) return true;

    return other.areaName == areaName &&
        other.streetName == streetName &&
        other.buildingNameorNumber == buildingNameorNumber &&
        other.floor == floor;
  }

  @override
  int get hashCode {
    return areaName.hashCode ^
        streetName.hashCode ^
        buildingNameorNumber.hashCode ^
        floor.hashCode;
  }
}
