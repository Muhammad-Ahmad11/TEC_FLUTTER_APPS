import 'dart:io';

import 'package:auth_with_biometric/model/user.dart';
import 'package:auth_with_biometric/provider/image_provider.dart';
import 'package:auth_with_biometric/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MainScreen extends ConsumerWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    User? user = ref.watch(userProvider.notifier).getUser();

    return Scaffold(
      appBar: AppBar(
        title: const Text('MainScreen'),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              ref.watch(userProvider.notifier).logout();
              ref.read(imageProvider.notifier).state = null;
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Logged out successfully"),
                ),
              );
              Navigator.pushReplacementNamed(context, '/');
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(children: [
            _displayUserImage(user),
            const SizedBox(height: 20),
            _displayUserBiometricStatus(user),
          ]),
        ),
      ),
    );
  }

  Widget _displayUserImage(User? user) {
    return CircleAvatar(
      radius: 50,
      backgroundImage: FileImage(File(user!.imagePath)),
    );
  }

  Widget _displayUserBiometricStatus(User? user) {
    return Text(
      user!.isUserRegistered
          ? "Biometrically Verified"
          : "Biometrically not Verified",
      style: TextStyle(fontSize: 16, color: Colors.black),
    );
  }
}
