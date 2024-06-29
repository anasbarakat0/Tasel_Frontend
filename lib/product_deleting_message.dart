import 'package:flutter/material.dart';
import 'package:tasel_frontend/Model/product_model.dart';
import 'package:tasel_frontend/Model/response_login_model.dart';
import 'package:tasel_frontend/Widgets/my_button.dart';
import 'package:tasel_frontend/product_page.dart';
import 'package:tasel_frontend/service/delete_product.dart';

void showMyDialog(
    BuildContext context, ProductModel product, TokenModel tokenId) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.white,
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
              height: 30,
            ),
            const Text(
              'Do you want to delete this Product?',
              style: TextStyle(
                color: Color(0xFF414141),
                fontFamily: 'Cairo',
                fontSize: 24,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 40,
            ),
            SizedBox(
              width: 320,
              height: 54,
              child: Button(
                text: 'Delete',
                onPressed: () {
                  deleteProduct(product, tokenId);
                  Navigator.of(context).pop();
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProductPage(
                        tokenId: tokenId,
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: 320,
              height: 54,
              child: Button(
                text: 'Cancel',
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
          ],
        ),
      );
    },
  );
}
