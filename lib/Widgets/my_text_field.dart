// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

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
          boxShadow: [Shadow.myShadow],
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
                color: AppColors.lightGrey,
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
            fillColor: Colors.white,
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

class MyPhoneTextField extends StatelessWidget {
  final TextEditingController controller;
  const MyPhoneTextField({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 3),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          boxShadow: [Shadow.myShadow],
        ),
        child: IntlPhoneField(
          showCountryFlag: false,
          style: AppFont.textFieldStyle,
          controller: controller,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.all(
                  Radius.circular(10),
                ),
                borderSide: BorderSide(
                  color: AppColors.lightGrey,
                ),
              ),
              hintText: 'Phone Number',
              counterText: '',
              hintStyle: TextStyle(
                color: AppColors.lightGrey,
                fontFamily: 'Cairo',
                fontWeight: FontWeight.w400,
                fontSize: 18,
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: AppColors.darkYellow,
                ),
                borderRadius: const BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              fillColor: Colors.white,
              filled: true),
          initialCountryCode: 'SY',
          cursorColor: AppColors.darkYellow,
        ),
      ),
    );
  }
}
