// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ionicons/ionicons.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:tasel_frontend/theme/colors.dart';

class ProviderInfoCard extends StatelessWidget {
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
  final String websiteUrl;
  const ProviderInfoCard({
    super.key,
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
    required this.websiteUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [Shadow.myShadow],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
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
                leading: Icon(
                  Icons.phone,
                  color: AppColors.yellow,
                ),
                title: Text(phoneNumbers.join(' , '),
                    style: TextStyle(
                      color: AppColors.grey,
                    )),
                subtitle: Text('Phone Numbers',
                    style: TextStyle(
                      color: AppColors.lightGrey,
                    )),
              ),
              ListTile(
                onTap: () {},
                leading: FaIcon(
                  FontAwesomeIcons.addressBook,
                  color: AppColors.yellow,
                ),
                title: Text(landlines.join(' , '),
                    style: TextStyle(
                      color: AppColors.grey,
                    )),
                subtitle: Text('Landlines',
                    style: TextStyle(
                      color: AppColors.lightGrey,
                    )),
              ),
              ListTile(
                onTap: () {},
                leading: Icon(
                  Icons.category,
                  color: AppColors.yellow,
                ),
                title: Text(category,
                    style: TextStyle(
                      color: AppColors.grey,
                    )),
                subtitle: Text('Category',
                    style: TextStyle(
                      color: AppColors.lightGrey,
                    )),
              ),
              ListTile(
                onTap: () {},
                leading: Icon(
                  Icons.location_searching,
                  color: AppColors.yellow,
                ),
                title: Text(areaName,
                    style: TextStyle(
                      color: AppColors.grey,
                    )),
                subtitle: Text('Area Name',
                    style: TextStyle(
                      color: AppColors.lightGrey,
                    )),
              ),
              ListTile(
                onTap: () {},
                leading: Icon(
                  Icons.edit_road_rounded,
                  color: AppColors.yellow,
                ),
                title: Text(streetName,
                    style: TextStyle(
                      color: AppColors.grey,
                    )),
                subtitle: Text('Street Name',
                    style: TextStyle(
                      color: AppColors.lightGrey,
                    )),
              ),
              ListTile(
                onTap: () {},
                leading: Icon(
                  Icons.location_city_outlined,
                  color: AppColors.yellow,
                ),
                title: Text(buildingNameorNumber,
                    style: TextStyle(
                      color: AppColors.grey,
                    )),
                subtitle: Text('Building Name or Number',
                    style: TextStyle(
                      color: AppColors.lightGrey,
                    )),
              ),
              ListTile(
                onTap: () {},
                leading: Icon(
                  Icons.stairs,
                  color: AppColors.yellow,
                ),
                title: Text(floor,
                    style: TextStyle(
                      color: AppColors.grey,
                    )),
                subtitle: Text('Floor',
                    style: TextStyle(
                      color: AppColors.lightGrey,
                    )),
              ),
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: const Icon(Ionicons.logo_facebook),
                    color: AppColors.yellow,
                    iconSize: 30,
                    onPressed: () {
                      launchUrl(
                        Uri.parse(facebookPage),
                        mode: LaunchMode.inAppWebView,
                      );
                    },
                  ),
                  IconButton(
                    icon: const Icon(Ionicons.logo_instagram),
                    color: AppColors.yellow,
                    iconSize: 30,
                    onPressed: () {
                      if (instagramAccount.isNotEmpty) {
                        print('instagramAccount');
                        print(instagramAccount);
                        launchUrl(
                          Uri.parse(instagramAccount),
                          mode: LaunchMode.inAppWebView,
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Link is invalid")),
                        );
                      }
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.link),
                    color: AppColors.yellow,
                    iconSize: 30,
                    onPressed: () {
                      launchUrl(
                        Uri.parse(websiteUrl),
                        mode: LaunchMode.inAppWebView,
                      );
                    },
                  ),
                  IconButton(
                    icon: const Icon(Ionicons.logo_whatsapp),
                    color: AppColors.yellow,
                    iconSize: 30,
                    onPressed: () {
                      // Handle Twitter button press
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.mail),
                    color: AppColors.yellow,
                    iconSize: 30,
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
