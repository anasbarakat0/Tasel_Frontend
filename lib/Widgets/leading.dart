import 'package:flutter/material.dart';
import 'package:tasel_frontend/theme/colors.dart';

class leadingButtons extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  const leadingButtons({
    required this.title,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        title,
      ),
      leading: Icon(
        icon,
        color: AppColors.darkYellow,
      ),
      onTap: onTap,
    );
  }
}
