// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class ProvidersModel {
  final String id;
  final String name;
  final String address;
  final int longitude;
  final int latitude;
  final List<int> phoneNumbers;
  final List<int> landlines;
  final int whatsappNumber;
  final String category;
  final String email;
  final String facebookPage;
  final String facebookUsername;
  final String instagramAccount;
  final String instagramUsername;
  ProvidersModel({
    required this.id,
    required this.name,
    required this.address,
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
  });

  ProvidersModel copyWith({
    String? id,
    String? name,
    String? address,
    int? longitude,
    int? latitude,
    List<int>? phoneNumbers,
    List<int>? landlines,
    int? whatsappNumber,
    String? category,
    String? email,
    String? facebookPage,
    String? facebookUsername,
    String? instagramAccount,
    String? instagramUsername,
  }) {
    return ProvidersModel(
      id: id ?? this.id,
      name: name ?? this.name,
      address: address ?? this.address,
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
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'address': address,
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

  factory ProvidersModel.fromMap(Map<String, dynamic> map) {
    return ProvidersModel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      address: map['address'] ?? '',
      longitude: map['longitude']?.toInt() ?? 0,
      latitude: map['latitude']?.toInt() ?? 0,
      phoneNumbers: List<int>.from(map['phoneNumbers'] ?? []),
      landlines: List<int>.from(map['landlines'] ?? []),
      whatsappNumber: map['whatsappNumber']?.toInt() ?? 0,
      category: map['category'] ?? '',
      email: map['email'] ?? '',
      facebookPage: map['facebookPage'] ?? '',
      facebookUsername: map['facebookUsername'] ?? '',
      instagramAccount: map['instagramAccount'] ?? '',
      instagramUsername: map['instagramUsername'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ProvidersModel.fromJson(String source) =>
      ProvidersModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ProvidersModel(id: $id, name: $name, address: $address, longitude: $longitude, latitude: $latitude, phoneNumbers: $phoneNumbers, landlines: $landlines, whatsappNumber: $whatsappNumber, category: $category, email: $email, facebookPage: $facebookPage, facebookUsername: $facebookUsername, instagramAccount: $instagramAccount, instagramUsername: $instagramUsername)';
  }

  @override
  bool operator ==(covariant ProvidersModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.address == address &&
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
    return id.hashCode ^
        name.hashCode ^
        address.hashCode ^
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
