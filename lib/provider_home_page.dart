import 'package:flutter/material.dart';
import 'package:tasel_frontend/login.dart';
import 'package:tasel_frontend/theme/colors.dart';

class ProviderHomePage extends StatelessWidget {
  const ProviderHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Tasel',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        backgroundColor: AppColors.yellow,
        foregroundColor: AppColors.grey,
        centerTitle: true,
      ),
      drawerEnableOpenDragGesture: true,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const LoginPage()));
        },
        child: const Icon(
          Icons.add_circle_outline_sharp,
        ),
      ),
      body: const Center(
        child: Column(
          children: [
            TextField(),
            TextField(),
            TextField(),
          ],
        ),
      ),
    );
  }
}
