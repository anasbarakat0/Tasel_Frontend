import 'package:flutter/material.dart';
import 'package:spincircle_bottom_bar/modals.dart';
import 'package:spincircle_bottom_bar/spincircle_bottom_bar.dart';
import 'package:tasel_frontend/Model/response_login_model.dart';
import 'package:tasel_frontend/favorite_page.dart';
import 'package:tasel_frontend/home_page.dart';
import 'package:tasel_frontend/map_page.dart';
import 'package:tasel_frontend/provider/Provider_profile_page.dart';
import 'package:tasel_frontend/provider/add_product_page.dart';
import 'package:tasel_frontend/provider/product_page.dart';
import 'package:tasel_frontend/provider/provider_update_info.dart';
import 'package:tasel_frontend/search_page.dart';
import 'package:tasel_frontend/theme/colors.dart';

class HomePageProvider extends StatefulWidget {
  final TokenModel tokenId;
  const HomePageProvider({super.key, required this.tokenId});

  @override
  State<HomePageProvider> createState() => _HomePageProviderState();
}

class _HomePageProviderState extends State<HomePageProvider> {
  int currentIndex = 5;
  List<Widget> pages = [];
  @override
  initState() {
    super.initState();
    pages = [
      ProviderProfilePage(tokenId: widget.tokenId),
      const MapPage(),
      AddProductPage(tokenId: widget.tokenId),
      ProductPage(tokenId: widget.tokenId),
      ProviderUpdateInfoPage(tokenId: widget.tokenId),
      HomePage(tokenId: widget.tokenId, Provider: true),
      SearchPage(),
      FavoritePage(),
    ];
  }

  void _changeItem(int value) {
    setState(
      () {
        currentIndex = value;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SpinCircleBottomBarHolder(
      bottomNavigationBar: SCBottomBarDetails(
        backgroundColor: Colors.white,
        actionButtonDetails: SCActionButtonDetails(
            color: AppColors.yellow,
            icon: const Icon(Icons.person),
            elevation: 1),
        iconTheme: const IconThemeData(),
        items: [
          SCBottomBarItem(
              icon: Icons.home,
              onPressed: () {
                _changeItem(5);
              }),
          SCBottomBarItem(
              icon: Icons.favorite,
              onPressed: () {
                _changeItem(7);
              }),
          SCBottomBarItem(
              icon: Icons.search,
              onPressed: () {
                _changeItem(6);
              }),
          SCBottomBarItem(
              icon: Icons.map,
              onPressed: () {
                _changeItem(1);
              }),
        ],
        circleItems: [
          SCItem(
              icon: const Icon(Icons.person_outline_rounded),
              onPressed: () {
                _changeItem(0);
              }),
          SCItem(
              icon: const Icon(Icons.add_box_outlined),
              onPressed: () {
                _changeItem(2);
              }),
          SCItem(
              icon: const Icon(Icons.list_rounded),
              onPressed: () {
                _changeItem(3);
              }),
          SCItem(
              icon: const Icon(Icons.edit_outlined),
              onPressed: () {
                _changeItem(4);
              }),
        ],
        circleColors: [
          Colors.white,
          AppColors.lightYellow,
          AppColors.yellow,
          AppColors.darkYellow
        ],
        elevation: 1,
      ),
      child: pages[currentIndex],
    ));
  }
}
