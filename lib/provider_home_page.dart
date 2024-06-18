import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ionicons/ionicons.dart';
import 'package:tasel_frontend/Model/provider_info.dart';
import 'package:tasel_frontend/Widgets/leading.dart';
import 'package:tasel_frontend/Widgets/my_text_field.dart';
import 'package:tasel_frontend/bloc/show_providers_bloc.dart';
import 'package:tasel_frontend/contact_page.dart';
import 'package:tasel_frontend/login.dart';
import 'package:tasel_frontend/map_sample.dart';
import 'package:tasel_frontend/profile_page.dart';
import 'package:tasel_frontend/theme/colors.dart';
import 'package:url_launcher/url_launcher.dart';

class ProviderHomePage extends StatefulWidget {
  final ProviderInfo providerInfo;
  const ProviderHomePage({
    super.key,
    required this.providerInfo,
  });

  @override
  State<ProviderHomePage> createState() => _ProviderHomePageState();
}

class _ProviderHomePageState extends State<ProviderHomePage> {
  TextEditingController searchController = TextEditingController();

  ProviderInfo get providerInfo => widget.providerInfo;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShowProvidersBloc(),
      child: Builder(builder: (context) {
        context.read<ShowProvidersBloc>().add(ShowProviders());

        return Scaffold(
          appBar: AppBar(
            title: const Text(
              'Tasel',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            backgroundColor: AppColors.yellow,
            foregroundColor: AppColors.grey,
            centerTitle: true,
          ),
          drawerEnableOpenDragGesture: true,
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const MapSample()),
              );
            },
            backgroundColor: AppColors.yellow,
            foregroundColor: AppColors.grey,
            child: const Icon(Icons.location_pin),
          ),
          drawer: Drawer(
            child: ListView(
              children: [
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        AppColors.grey,
                        Colors.black,
                      ],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 60, bottom: 30, left: 20, right: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding:
                              const EdgeInsets.only(bottom: 10.0, left: 20),
                          child: Container(
                              width: 80,
                              height: 80,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                              ),
                              child: Image.asset('images/tasel.png')),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 12, top: 20),
                          child: Text(
                            'Wellcome',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 25,
                                color: Colors.white),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 12),
                          child: Text(
                            'userName',
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                leadingButtons(
                    title: 'Contact Us',
                    icon: Icons.contact_support,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ContactUsPage()),
                      );
                    }),
                leadingButtons(
                    title: 'Log Out',
                    icon: Icons.logout_rounded,
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginPage()),
                      );
                    }),
              ],
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    top: 16.0,
                  ),
                  child: Image.network(
                    providerInfo.profileImage,
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
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
                              providerInfo.name,
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
                                  path: providerInfo.phoneNumbers.first
                                      .toString());
                              if (await canLaunchUrl(url)) {
                                launchUrl(url);
                              }
                            },
                            leading: Icon(Icons.phone, color: AppColors.yellow),
                            title: const Text('Phone Numbers'),
                            subtitle: Text(providerInfo.phoneNumbers.join(', '),
                                style: const TextStyle(color: Colors.white)),
                          ),
                          ListTile(
                            onTap: () {},
                            leading: FaIcon(FontAwesomeIcons.addressBook,
                                color: AppColors.yellow),
                            title: const Text('Landlines'),
                            subtitle: Text(providerInfo.landlines.join(', '),
                                style: const TextStyle(color: Colors.white)),
                          ),
                          ListTile(
                            onTap: () {},
                            leading: Icon(Ionicons.logo_whatsapp,
                                color: AppColors.yellow),
                            title: const Text('WhatsApp Number'),
                            subtitle: Text(
                                providerInfo.whatsappNumber.toString(),
                                style: const TextStyle(color: Colors.white)),
                          ),
                          ListTile(
                            onTap: () {},
                            leading: Icon(Icons.email, color: AppColors.yellow),
                            title: const Text('Email'),
                            subtitle: Text(providerInfo.email,
                                style: const TextStyle(color: Colors.white)),
                          ),
                          ListTile(
                            onTap: () {},
                            leading:
                                Icon(Icons.category, color: AppColors.yellow),
                            title: const Text('Category'),
                            subtitle: Text(providerInfo.category,
                                style: const TextStyle(color: Colors.white)),
                          ),
                          ListTile(
                            onTap: () {
                              launchUrl(
                                Uri.parse('https://www.facebook.com'),
                                mode: LaunchMode.inAppWebView,
                              );
                            },
                            leading: Icon(Ionicons.logo_facebook,
                                color: AppColors.yellow),
                            title: const Text('Facebook Page'),
                            subtitle: Text(
                              providerInfo.facebookPage,
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                          ListTile(
                            onTap: () {},
                            leading: Icon(Ionicons.logo_instagram,
                                color: AppColors.yellow),
                            title: const Text('Instagram Account'),
                            subtitle: Text(providerInfo.instagramAccount,
                                style: const TextStyle(color: Colors.white)),
                          ),
                          ListTile(
                            onTap: () {},
                            leading: Icon(Icons.location_on,
                                color: AppColors.yellow),
                            title: const Text('Address'),
                            subtitle: Text(providerInfo.address.toString(),
                                style: const TextStyle(color: Colors.white)),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
