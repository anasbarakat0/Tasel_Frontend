import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tasel_frontend/Widgets/provider_card.dart';
import 'package:tasel_frontend/Widgets/scaffold_gradient.dart';
import 'dart:convert';

import 'package:tasel_frontend/provider_page.dart';

class FavoritePage extends StatefulWidget {
  @override
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  List<Map<String, String>> favoriteProviders = [];

  @override
  void initState() {
    super.initState();
    _loadFavorites();
  }

  Future<void> _loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final favoriteProvidersList = prefs.getStringList('favorites') ?? [];
    setState(() {
      favoriteProviders = favoriteProvidersList
          .map((providerJson) =>
              Map<String, String>.from(jsonDecode(providerJson)))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return GradientScaffold(
      body: favoriteProviders.isEmpty
          ? const Center(child: Text('No favorites added.'))
          : Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 20,
                  childAspectRatio: 0.8,
                ),
                itemCount: favoriteProviders.length,
                itemBuilder: (context, index) {
                  final provider = favoriteProviders[index];
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProviderPage(
                            id: provider['id']!,
                          ),
                        ),
                      );
                    },
                    child: FittedBox(
                      child: ProviderCard(
                        id: provider['id']!,
                        name: provider['name']!,
                        image: provider['image']!,
                        category: provider['category']!,
                        address: provider['address']!,
                      ),
                    ),
                  );
                },
              ),
            ),
    );
  }
}
