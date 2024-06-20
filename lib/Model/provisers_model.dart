// ignore_for_file: public_member_api_docs, sort_constructors_first
class Address {
  final String areaName;
  final String streetName;
  final String buildingNameorNumber;
  final String floor;

  Address({
    required this.areaName,
    required this.streetName,
    required this.buildingNameorNumber,
    required this.floor,
  });

  factory Address.fromMap(Map<String, dynamic> map) {
    return Address(
      areaName: map['areaName'] as String,
      streetName: map['streetName'] as String,
      buildingNameorNumber: map['buildingNameorNumber'] as String,
      floor: map['floor'] as String,
    );
  }
}

class ProvidersModel {
  final Address address;
  final String id;
  final String profileImage;
  final String name;
  final double longitude;
  final double latitude;
  final List<int> phoneNumbers;
  final List<int> landlines;
  final int whatsappNumber;
  final String category;
  final String email;
  final String facebookPage;
  final String facebookUsername;
  final String instagramAccount;
  final String instagramUsername;
  final String websiteUrl;
  final String websiteTitle;

  ProvidersModel({
    required this.address,
    required this.id,
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
    required this.websiteTitle,
  });

  factory ProvidersModel.fromMap(Map<String, dynamic> map) {
    print('Mapping ProvidersModel from map: $map');

    return ProvidersModel(
      profileImage: map['profileImage'] as String,
      id: map['_id'] as String,
      name: map['name'] as String,
      address: Address.fromMap(map['address'] as Map<String, dynamic>),
      longitude: map['longitude'] as double,
      latitude: map['latitude'] as double,
      phoneNumbers: List<int>.from(map['phoneNumbers'] as List<dynamic>),
      landlines: List<int>.from(map['landlines'] as List<dynamic>),
      whatsappNumber: map['whatsappNumber'] as int,
      category: map['category'] as String,
      email: map['email'] as String,
      facebookPage: map['facebookPage'] as String,
      facebookUsername: map['facebookUsername'] as String,
      instagramAccount: map['instagramAccount'] as String,
      instagramUsername: map['instagramUsername'] as String,
      websiteUrl: map['WebsiteUrl'] as String,
      websiteTitle: map['WebsiteTitle'] as String,
    );
  }
}
