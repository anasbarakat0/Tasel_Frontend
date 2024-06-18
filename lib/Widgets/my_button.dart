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
    this.fontSize = 30,
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
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          backgroundColor: MaterialStateProperty.all<Color>(AppColors.yellow),
          foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
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
