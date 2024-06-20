// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:tasel_frontend/Model/provider_info.dart';
import 'package:tasel_frontend/main.dart';
import 'package:tasel_frontend/provider_page.dart';
import 'package:tasel_frontend/theme/colors.dart';

class ProviderCard extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 7, 15, 0),
      child: ListTile(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
        contentPadding: const EdgeInsets.all(8),
        tileColor: AppColors.grey,
        style: ListTileStyle.list,
        title: Text(
          name,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        leading: Expanded(
          child: CircleAvatar(
            backgroundImage: const AssetImage('blank-profile.png'),
            child: Image.network('$baseurl/$image'),
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  'Adress: ',
                  style: TextStyle(
                    color: AppColors.yellow,
                    fontSize: 15,
                  ),
                ),
                Text(
                  address,
                  style: TextStyle(
                    color: Colors.grey[300],
                    fontSize: 15,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  'Category: ',
                  style: TextStyle(
                    color: AppColors.yellow,
                    fontSize: 15,
                  ),
                ),
                Text(
                  category,
                  style: TextStyle(
                    color: Colors.grey[300],
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ],
        ),
        isThreeLine: true,
        onTap: () {
          print('$baseurl/$image');
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //     builder: (context) => ProviderPage(
          //       id: id,
          //     ),
          //   ),
          // );
        },
      ),
    );
  }
}
