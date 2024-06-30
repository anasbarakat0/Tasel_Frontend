// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:tasel_frontend/Model/product_model.dart';
import 'package:tasel_frontend/Widgets/my_text_field.dart';

// ignore: must_be_immutable
class EditProduct extends StatefulWidget {
  ProductModel product;
  EditProduct({
    super.key,
    required this.product,
  });

  @override
  State<EditProduct> createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct> {
  late TextEditingController name;
  late TextEditingController price;
  late TextEditingController description;

  @override
  void initState() {
    name = TextEditingController(text: widget.product.name);
    price = TextEditingController(text: widget.product.price.toString());
    description =
        TextEditingController(text: widget.product.description.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            const Text("Edit Product"),
            CircleAvatar(
              radius: 100,
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
            MyTextField(
              controller: name,
              title: 'Product Name',
              keyboardType: TextInputType.name,
              ontap: (context) {},
            ),
            MyTextField(
              controller: price,
              title: 'Price',
              keyboardType: TextInputType.number,
              ontap: (context) {},
            ),
            MyTextField(
              controller: description,
              title: 'Description',
              keyboardType: TextInputType.name,
              ontap: (context) {},
            ),
          ],
        ),
      ),
    );
  }
}
