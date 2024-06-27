// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ionicons/ionicons.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:tasel_frontend/theme/colors.dart';

class ProviderInfoCard extends StatelessWidget {
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
  final String areaName;
  final String streetName;
  final String buildingNameorNumber;
  final String floor;
  const ProviderInfoCard({
    super.key,
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
    required this.areaName,
    required this.streetName,
    required this.buildingNameorNumber,
    required this.floor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Card(
        elevation: 4,
        color: AppColors.grey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                alignment: Alignment.center,
                child: Text(
                  name,
                  style: TextStyle(
                    fontFamily: 'Cairo',
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                    color: AppColors.yellow,
                  ),
                ),
              ),
              ListTile(
                onTap: () async {
                  final url = Uri(
                    scheme: 'tel',
                    path: phoneNumbers.first.toString(),
                  );
                  if (await canLaunchUrl(url)) {
                    launchUrl(url);
                  }
                },
                leading: const Icon(
                  Icons.phone,
                  color: Colors.white,
                ),
                title: Text('Phone Numbers',
                    style: TextStyle(
                      color: AppColors.yellow,
                    )),
                subtitle: Text(phoneNumbers.join(' , '),
                    style: const TextStyle(
                      color: Colors.white,
                    )),
              ),
              ListTile(
                onTap: () {},
                leading: const FaIcon(
                  FontAwesomeIcons.addressBook,
                  color: Colors.white,
                ),
                title: Text('Landlines',
                    style: TextStyle(
                      color: AppColors.yellow,
                    )),
                subtitle: Text(landlines.join(' , '),
                    style: const TextStyle(
                      color: Colors.white,
                    )),
              ),
              ListTile(
                onTap: () {},
                leading: const Icon(
                  Icons.category,
                  color: Colors.white,
                ),
                title: Text('Category',
                    style: TextStyle(
                      color: AppColors.yellow,
                    )),
                subtitle: Text(category,
                    style: const TextStyle(
                      color: Colors.white,
                    )),
              ),
              ListTile(
                onTap: () {},
                leading: const Icon(
                  Icons.location_on,
                  color: Colors.white,
                ),
                title: Text('Address',
                    style: TextStyle(
                      color: AppColors.yellow,
                    )),
                subtitle: Text(areaName,
                    style: const TextStyle(
                      color: Colors.white,
                    )),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: const Icon(Ionicons.logo_facebook),
                    color: AppColors.yellow,
                    iconSize: 40,
                    onPressed: () {
                      launchUrl(
                        Uri.parse('https://www.facebook.com'),
                        mode: LaunchMode.inAppWebView,
                      );
                    },
                  ),
                  IconButton(
                    icon: const Icon(Ionicons.logo_instagram),
                    color: AppColors.yellow,
                    iconSize: 40,
                    onPressed: () {
                      // Handle Instagram button press
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.link),
                    color: AppColors.yellow,
                    iconSize: 40,
                    onPressed: () {
                      // Handle Instagram button press
                    },
                  ),
                  IconButton(
                    icon: const Icon(Ionicons.logo_whatsapp),
                    color: AppColors.yellow,
                    iconSize: 40,
                    onPressed: () {
                      // Handle Twitter button press
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.mail),
                    color: AppColors.yellow,
                    iconSize: 40,
                    onPressed: () {
                      // Handle LinkedIn button press
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
