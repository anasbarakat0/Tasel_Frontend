// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:tasel_frontend/Model/product_model.dart';
import 'package:tasel_frontend/theme/colors.dart';

// ignore: must_be_immutable
class MyProducts extends StatelessWidget {
  ProductModel product;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  MyProducts({
    super.key,
    required this.product,
    this.onTap,
    this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 16,
      ),
      child: Container(
        color: AppColors.grey,
        child: ListTile(
          onTap: onTap,
          onLongPress: onLongPress,
          leading: Expanded(
            child: CircleAvatar(
              radius: 50,
              backgroundColor: Colors.transparent,
              child: ClipOval(
                child: SizedBox(
                  height: 50,
                  child: Image.network(
                    'product.picture',
                    fit: BoxFit.contain,
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
          title: Text(
            product.name,
            style: TextStyle(
                color: AppColors.yellow,
                fontFamily: 'Cairo',
                fontSize: 24,
                fontWeight: FontWeight.w500),
          ),
          subtitle: Text(
            product.description,
            style: TextStyle(
              color: AppColors.lightGrey,
              fontFamily: 'Cairo',
              fontSize: 16,
              // fontWeight: FontWeight.w500
            ),
          ),
          trailing: Text(
            " ${product.price.toStringAsFixed(2)} S.P",
            style: TextStyle(
                color: AppColors.yellow,
                fontFamily: 'Cairo',
                fontSize: 16,
                fontWeight: FontWeight.w500),
          ),
          isThreeLine: true,
        ),
      ),
    );
  }
}
