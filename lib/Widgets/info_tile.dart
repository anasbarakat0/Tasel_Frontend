import 'package:flutter/material.dart';
import 'package:tasel_frontend/theme/colors.dart';

class InfoTile extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;

  const InfoTile({
    super.key,
    required this.label,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(boxShadow: [Shadow.myShadow]),
      child: Card(
        color: Colors.white,
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        child: ListTile(
          leading: Icon(icon, color: AppColors.yellow),
          title: Text(
            value,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: AppColors.grey,
            ),
          ),
          subtitle: Text(
            label,
            style: TextStyle(
              color: AppColors.lightGrey,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
      ),
    );
  }
}
