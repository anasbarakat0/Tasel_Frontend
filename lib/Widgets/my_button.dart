import 'package:flutter/material.dart';
import 'package:tasel_frontend/theme/colors.dart';

// ignore: must_be_immutable
class Button extends StatelessWidget {
  final String text;
  double fontSize;
  final VoidCallback? onPressed;

  Button({
    super.key,
    required this.text,
    this.fontSize = 20,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 2,
      height: 60,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          backgroundColor: WidgetStateProperty.all<Color>(AppColors.yellow),
          foregroundColor: WidgetStateProperty.all<Color>(Colors.white),
        ),
        child: Text(
          text,
          style: TextStyle(
            // Remove the const keyword here
            fontFamily: 'Cairo',
            fontSize: fontSize,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}

class LogoutButton extends StatelessWidget {
  final VoidCallback? onPressed;

  LogoutButton({
    super.key,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 50,
      height: 50,
      child: ElevatedButton(
          onPressed: onPressed,
          style: ButtonStyle(
            padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
              const EdgeInsets.only(right: 1),
            ),
            shape: WidgetStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            backgroundColor: WidgetStateProperty.all<Color>(Colors.white),
            foregroundColor: WidgetStateProperty.all<Color>(AppColors.grey),
          ),
          child: const Icon(
            Icons.logout_outlined,
          )),
    );
  }
}
