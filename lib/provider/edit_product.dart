import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:tasel_frontend/Model/product_model.dart';
import 'package:tasel_frontend/Widgets/my_text_field.dart';
import 'package:tasel_frontend/Widgets/scaffold_gradient.dart';
import 'package:tasel_frontend/theme/colors.dart';
import 'package:universal_io/io.dart';

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
    return Stack(
      children: [
        GradientScaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: () {},
            child: const Icon(Icons.save),
          ),
          body: Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Edit Your Product...',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: AppColors.grey,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Stack(
                    children: [
                      GestureDetector(
                        onTap: _pickImage,
                        child: CircleAvatar(
                          radius: 75,
                          backgroundImage: _image != null
                              ? FileImage(_image!)
                              : const AssetImage('assets/tasel_icon.png')
                                  as ImageProvider,
                        ),
                      ),
                      if (_image == null)
                        Positioned(
                          bottom: 5,
                          right: 5,
                          child: IconButton(
                              onPressed: _pickImage,
                              icon: Icon(
                                Icons.add_a_photo,
                                color: AppColors.grey,
                                size: 35,
                              )),
                        )
                    ],
                  ),
                  const SizedBox(height: 16),
                  MyTextField(
                    controller: name,
                    title: 'Product Name',
                    keyboardType: TextInputType.name,
                    prefixIcon: const Icon(Icons.local_offer),
                    ontap: (context) {},
                  ),
                  MyTextField(
                    controller: price,
                    title: 'Price',
                    keyboardType: TextInputType.number,
                    prefixIcon: const Icon(Icons.description),
                    ontap: (context) {},
                  ),
                  MyTextField(
                    controller: description,
                    title: 'Description',
                    keyboardType: TextInputType.name,
                    prefixIcon: const Icon(Icons.monetization_on),
                    ontap: (context) {},
                  ),
                ],
              ),
            ),
          ),
        ),
        const Positioned(
          top: 20,
          left: 20,
          child: BackButton(),
        ),
      ],
    );
  }
}
