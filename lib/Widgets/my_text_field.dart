// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../theme/colors.dart';

class MyTextField extends StatelessWidget {
  final TextEditingController controller;
  final String title;
  final TextInputType keyboardType;
  final Widget? prefixIcon;
  final Widget? suffix;
  final void Function(String) ontap;
  final int? maxLength;
  const MyTextField({
    super.key,
    required this.controller,
    required this.title,
    required this.keyboardType,
    this.prefixIcon,
    this.suffix,
   required this.ontap,
    this.maxLength,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              spreadRadius: 2.0,
              blurRadius: 5.0,
              color: Colors.black.withOpacity(0.2),
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: TextField(
          style: AppFont.textFieldStyle,
          controller: controller,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.all(
                Radius.circular(10),
              ),
              borderSide: BorderSide(
                color: AppColors.grey,
              ),
            ),
            hintText: title,
            hintStyle: TextStyle(
              color: AppColors.lightGrey,
              fontFamily: 'Cairo',
              fontWeight: FontWeight.w400,
              fontSize: 18,
            ),
            alignLabelWithHint: true,
            prefixIcon: prefixIcon,
            prefixIconColor: AppColors.yellow,
            suffix: suffix,
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.darkYellow),
              borderRadius: const BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            fillColor: Colors.grey[850],
            filled: true,
            counterText: '',
          ),
          textAlign: TextAlign.start,
          cursorColor: AppColors.darkYellow,
          onChanged: ontap,
          maxLength: maxLength,
        ),
      ),
    );
  }
}
