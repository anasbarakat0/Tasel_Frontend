import 'package:flutter/material.dart';
import 'package:tasel_frontend/main.dart';
import 'package:tasel_frontend/provider_page.dart';
import 'package:tasel_frontend/theme/colors.dart';

class ResultPanel extends StatelessWidget {
  final String id;
  final String name;
  final String image;
  const ResultPanel(
      {super.key, required this.id, required this.name, required this.image});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 7, 15, 0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [Shadow.myShadow],
        ),
        child: ListTile(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          contentPadding: const EdgeInsets.all(8),
          tileColor: AppColors.grey,
          style: ListTileStyle.list,
          title: SizedBox(
            height: 27,
            child: Text(
              name,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: AppColors.grey,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
          leading: Expanded(
            child: CircleAvatar(
              radius: 50,
              backgroundColor: Colors.transparent,
              child: ClipOval(
                child: SizedBox(
                  height: 50,
                  width: 50,
                  child: Image.network(
                    "$baseurl/$image",
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Image.asset(
                        'blank-profile.png',
                        fit: BoxFit.contain,
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
          isThreeLine: false,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProviderPage(
                  id: id,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class ResultLocationPanel extends StatelessWidget {
  final String id;
  final String name;
  final String image;
  final double longitude;
  final double latitude;
  final VoidCallback? onTap;
  const ResultLocationPanel(
      {super.key,
      required this.id,
      required this.name,
      required this.image,
      required this.longitude,
      required this.latitude,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 7, 15, 0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [Shadow.myShadow],
        ),
        child: ListTile(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          contentPadding: const EdgeInsets.all(8),
          tileColor: AppColors.grey,
          style: ListTileStyle.list,
          title: Text(
            name,
            style: TextStyle(
              color: AppColors.grey,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          leading: Expanded(
            child: CircleAvatar(
              radius: 50,
              backgroundColor: Colors.transparent,
              child: ClipOval(
                child: SizedBox(
                  height: 50,
                  width: 50,
                  child: Image.network(
                    "$baseurl/$image",
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Image.asset(
                        'blank-profile.png',
                        fit: BoxFit.contain,
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
          onTap: onTap,
        ),
      ),
    );
  }
}
