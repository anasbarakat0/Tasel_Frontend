// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import 'package:tasel_frontend/Model/response_login_model.dart';
import 'package:tasel_frontend/Model/update_user_profile.dart';
import 'package:tasel_frontend/Widgets/my_text_field.dart';
import 'package:tasel_frontend/bloc/profile_info_bloc.dart';
import 'package:tasel_frontend/service/update_user_profile.dart';
import 'package:tasel_frontend/theme/colors.dart';

class UpdateProfilePage extends StatefulWidget {
  final VoidCallback refresh;
  final TokenModel tokenId;
  final String id;
  final String name;
  final int phone;
  final String address;
  const UpdateProfilePage({
    Key? key,
    required this.refresh,
    required this.tokenId,
    required this.id,
    required this.name,
    required this.phone,
    required this.address,
  }) : super(key: key);

  @override
  State<UpdateProfilePage> createState() => _UpdateProfilePageState();
}

class _UpdateProfilePageState extends State<UpdateProfilePage> {
  late TextEditingController name;
  late TextEditingController address;
  late TextEditingController phone;
  File? _image;
  // ignore: prefer_typing_uninitialized_variables
  late var updated;

  @override
  void initState() {
    name = TextEditingController(text: widget.name);
    address = TextEditingController(text: widget.address);
    phone = TextEditingController(text: widget.phone.toString());
    super.initState();
  }

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {}
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.yellow,
        foregroundColor: AppColors.grey,
        onPressed: () async {
          updated = await updateProfileUser(
            widget.tokenId,
            UpdateUserModel(
              name: name.text,
              phone: phone.text,
              address: address.text,
            ),
          );
          if (updated) {
            print('----------------------54263425348-----');
            print(updated);

            Navigator.pop(context);
            widget.refresh;
          } else {
            // ignore: use_build_context_synchronously
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Error Updating Data")));
            print("Error Updating Data");
            print(updated);
          }
        },
        child: const Icon(Icons.save),
      ),
      body: Stack(
        children: [
          Column(
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
                'Edit Your Info...',
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
                      title: 'UserName',
                      keyboardType: TextInputType.name,
                      prefixIcon: const Icon(Icons.person),
                    ),
                    MyPhoneTextField(
                      controller: phone,
                    ),
                    const SizedBox(height: 16),
                    MyTextField(
                      ontap: (p0) {},
                      controller: address,
                      title: 'Address',
                      keyboardType: TextInputType.name,
                      prefixIcon: const Icon(Icons.home),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            top: 20,
            left: 20,
            child: BackButton(
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ],
      ),
    );
  }
}
