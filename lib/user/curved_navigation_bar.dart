import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

import 'package:tasel_frontend/Model/response_login_model.dart';
import 'package:tasel_frontend/favorite_page.dart';
import 'package:tasel_frontend/home_page.dart';
import 'package:tasel_frontend/map_page.dart';
import 'package:tasel_frontend/search_page.dart';
import 'package:tasel_frontend/theme/colors.dart';
import 'package:tasel_frontend/user/profile_page.dart';

class HomePageUser extends StatefulWidget {
  final TokenModel tokenId;
  const HomePageUser({
    super.key,
    required this.tokenId,
  });

  @override
  State<HomePageUser> createState() => _HomePageUserState();
}

class _HomePageUserState extends State<HomePageUser> {
  int currentIndex = 2;

  List<Widget> pages = [];

  @override
  void initState() {
    super.initState();
    pages = [
      ProfilePage(tokenId: widget.tokenId),
      FavoritePage(),
      HomePage(
        tokenId: widget.tokenId,
        onSeeAllPressed: () {
          setState(
            () {
              currentIndex = 3;
            },
          );
        },
        Provider: false,
      ),
      SearchPage(),
      const MapPage(),
    ];
  }

  void _changeItem(int value) {
    setState(() {
      currentIndex = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: const Color.fromARGB(255, 229, 229, 229),
        buttonBackgroundColor: AppColors.yellow,
        color: Colors.white,
        items: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                (currentIndex == 0) ? Icons.person : Icons.person_outline,
                color: AppColors.grey,
              ),
              if (currentIndex != 0)
                Text(
                  'Profile',
                  style: TextStyle(
                    color: AppColors.grey,
                  ),
                ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                (currentIndex == 1)
                    ? Icons.favorite_rounded
                    : Icons.favorite_outline_rounded,
                color: AppColors.grey,
              ),
              if (currentIndex != 1)
                Text(
                  'Favorites',
                  style: TextStyle(
                    color: AppColors.grey,
                  ),
                ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                (currentIndex == 2) ? Icons.home : Icons.home_outlined,
                color: AppColors.grey,
              ),
              if (currentIndex != 2)
                Text(
                  'Home',
                  style: TextStyle(
                    color: AppColors.grey,
                  ),
                ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                (currentIndex == 3) ? Icons.search : Icons.search_outlined,
                color: AppColors.grey,
              ),
              if (currentIndex != 3)
                Text(
                  'Search',
                  style: TextStyle(
                    color: AppColors.grey,
                  ),
                ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                (currentIndex == 4) ? Icons.map : Icons.map_outlined,
                color: AppColors.grey,
              ),
              if (currentIndex != 4)
                Text(
                  'Map',
                  style: TextStyle(
                    color: AppColors.grey,
                  ),
                ),
            ],
          ),
        ],
        onTap: _changeItem,
        index: currentIndex,
      ),
      body: pages[currentIndex],
    );
  }
}
