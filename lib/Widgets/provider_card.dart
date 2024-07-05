import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:tasel_frontend/main.dart';
import 'package:tasel_frontend/theme/colors.dart';

class ProviderCard extends StatefulWidget {
  final String id;
  final String name;
  final String image;
  final String category;
  final String address;

  const ProviderCard({
    super.key,
    required this.id,
    required this.name,
    required this.image,
    required this.category,
    required this.address,
  });

  @override
  _ProviderCardState createState() => _ProviderCardState();
}

class _ProviderCardState extends State<ProviderCard> {
  bool isFavorite = false;

  @override
  void initState() {
    super.initState();
    _loadFavoriteStatus();
  }

  Future<void> _loadFavoriteStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final favoriteProviders = prefs.getStringList('favorites') ?? [];

    final providerJson = jsonEncode({
      'id': widget.id,
      'name': widget.name,
      'image': widget.image,
      'category': widget.category,
      'address': widget.address,
    });

    if (favoriteProviders.contains(providerJson)) {
      setState(() {
        isFavorite = true;
      });
    }
  }

  Future<void> _toggleFavorite() async {
    final prefs = await SharedPreferences.getInstance();
    final favoriteProviders = prefs.getStringList('favorites') ?? [];

    final providerJson = jsonEncode({
      'id': widget.id,
      'name': widget.name,
      'image': widget.image,
      'category': widget.category,
      'address': widget.address,
    });

    if (isFavorite) {
      favoriteProviders.remove(providerJson);
    } else {
      favoriteProviders.add(providerJson);
    }

    await prefs.setStringList('favorites', favoriteProviders);

    setState(() {
      isFavorite = !isFavorite;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 285,
        width: 200,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            Shadow.myShadow,
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              Container(
                alignment: Alignment.center,
                height: 140,
                // width: 140,
                child: Image.network(
                  '$baseurl/${widget.image}',
                  fit: BoxFit.cover,
                  alignment: Alignment.center,
                  loadingBuilder: (
                    BuildContext context,
                    Widget child,
                    ImageChunkEvent? loadingProgress,
                  ) {
                    if (loadingProgress == null) {
                      return child;
                    }
                    return Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                (loadingProgress.expectedTotalBytes ?? 1)
                            : null,
                      ),
                    );
                  },
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      alignment: Alignment.center,
                      height: 140,
                      // width: 140,
                      child: Image.asset(
                        'blank-profile.png',
                        fit: BoxFit.cover,
                        alignment: Alignment.center,
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(
                height: 6,
              ),
              Text(
                widget.name,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                    color: AppColors.grey),
              ),
              Text(
                widget.category,
                style: TextStyle(fontSize: 16, color: AppColors.grey),
              ),
              const SizedBox(
                height: 6,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.address,
                    style: const TextStyle(fontSize: 14, color: Colors.amber),
                  ),
                  ElevatedButton(
                    onPressed: _toggleFavorite,
                    child: Icon(
                      isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: isFavorite ? Colors.red : AppColors.yellow,
                    ),
                    style: ElevatedButton.styleFrom(
                      shape: CircleBorder(),
                      padding: EdgeInsets.all(10),
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.amber,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
