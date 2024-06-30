// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tasel_frontend/Model/response_login_model.dart';
import 'package:tasel_frontend/Widgets/my_text_field.dart';
import 'package:tasel_frontend/service/add_product.dart';
import 'package:tasel_frontend/theme/colors.dart';

// ignore: must_be_immutable
class AddProductPage extends StatefulWidget {
  TokenModel tokenId;
  AddProductPage({
    super.key,
    required this.tokenId,
  });

  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  TextEditingController name = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController price = TextEditingController();
  File? _image;

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add Product',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        backgroundColor: AppColors.yellow,
        foregroundColor: AppColors.grey,
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          bool response = await addProduct(
            widget.tokenId,
            name.text,
            double.parse(price.text),
            description.text,
          );
          if (response) {
            // ignore: use_build_context_synchronously
            Navigator.pop(context);
            // ignore: use_build_context_synchronously
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text("Success Adding Product"),
              backgroundColor: Colors.green,
            ));
          } else {
            // ignore: use_build_context_synchronously
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Error Adding Product")));
          }
        },
        child: const Icon(Icons.add),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: _pickImage,
            child: CircleAvatar(
              radius: 60,
              backgroundImage: _image != null
                  ? FileImage(_image!)
                  : const AssetImage('assets/tasel.png') as ImageProvider,
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Adding Your Product...',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MyTextField(
                  ontap: (p0) {},
                  controller: name,
                  title: 'Product Name',
                  keyboardType: TextInputType.name,
                  prefixIcon: const Icon(Icons.person),
                ),
                const SizedBox(height: 16),
                MyTextField(
                  ontap: (p0) {},
                  controller: description,
                  title: 'Description',
                  keyboardType: TextInputType.name,
                  prefixIcon: const Icon(Icons.home),
                ),
                const SizedBox(height: 16),
                MyTextField(
                  ontap: (p0) {},
                  controller: price,
                  title: 'Price',
                  keyboardType: TextInputType.number,
                  prefixIcon: const Icon(Icons.home),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
