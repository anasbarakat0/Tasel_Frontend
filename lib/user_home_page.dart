import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasel_frontend/Widgets/leading.dart';
import 'package:tasel_frontend/Widgets/my_text_field.dart';
import 'package:tasel_frontend/Widgets/provider_card.dart';
import 'package:tasel_frontend/bloc/show_providers_bloc.dart';
import 'package:tasel_frontend/contact_page.dart';
import 'package:tasel_frontend/login.dart';
import 'package:tasel_frontend/map_sample.dart';
import 'package:tasel_frontend/profile_page.dart';
import 'package:tasel_frontend/theme/colors.dart';

class UserHomePage extends StatefulWidget {
  const UserHomePage({super.key});

  @override
  State<UserHomePage> createState() => _UserHomePageState();
}

class _UserHomePageState extends State<UserHomePage> {
  TextEditingController searchController = TextEditingController();
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
                              child: Image.asset('tasel.png')),
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
                    title: 'Profile',
                    icon: Icons.person,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ProfilePage()),
                      );
                    }),
                leadingButtons(
                    title: 'Contact Us',
                    icon: Icons.contact_support,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ContactUsPage()),
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
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: MyTextField(
                  controller: searchController,
                  title: 'Search',
                  keyboardType: TextInputType.name,
                  prefixIcon: const Padding(
                    padding: EdgeInsets.only(left: 5),
                    child: Icon(Icons.search),
                  ),
                  ontap: (String val) {
                    context
                        .read<ShowProvidersBloc>()
                        .add(SearchEvent(lexem: val));
                  },
                ),
              ),
              BlocBuilder<ShowProvidersBloc, ShowProvidersState>(
                builder: (context, state) {
                  if (state is LoadingFetching) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is SuccessShowProviders) {
                    print('ggggggggggggggggggggggggggggggggggg');
                    return Expanded(
                      child: ListView.builder(
                        itemCount: state.providers.length,
                        itemBuilder: (context, index) {
                          return ProviderCard(
                            name: state.providers[index].name,
                            image: state.providers[index].profileImage,
                            category: state.providers[index].category,
                            address: state.providers[index].address.areaName,
                            id: state.providers[index].id,
                          );
                        },
                      ),
                    );
                  } else if (state is ErrorFetchingData) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'There is an Error',
                          ),
                          ElevatedButton.icon(
                            onPressed: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const UserHomePage(),
                                ),
                              );
                            },
                            label: const Text('Try Again'),
                            icon: const Icon(Icons.autorenew_rounded),
                          ),
                        ],
                      ),
                    );
                  } else if (state is SearchResutl) {
                    print('searchhhhhhhhhh');
                    return Expanded(
                      child: ListView.builder(
                        itemCount: state.providers.length,
                        itemBuilder: (context, index) {
                          return ProviderCard(
                            name: state.providers[index].name,
                            image: state.providers[index].profileImage,
                            category: state.providers[index].category,
                            address: state.providers[index].address.areaName,
                            id: state.providers[index].id,
                          );
                        },
                      ),
                    );
                  } else {
                    return const Center(
                      child: LinearProgressIndicator(),
                    );
                  }
                },
              ),
            ],
          ),
        );
      }),
    );
  }
}
