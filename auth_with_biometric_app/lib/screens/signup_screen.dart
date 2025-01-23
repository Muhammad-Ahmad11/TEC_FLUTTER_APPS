import 'dart:io';

import 'package:auth_with_biometric/model/user.dart';
import 'package:auth_with_biometric/provider/image_provider.dart';
import 'package:auth_with_biometric/provider/user_provider.dart';
import 'package:auth_with_biometric/service/biometric_service.dart';
import 'package:auth_with_biometric/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

class SignupScreen extends ConsumerWidget {
  final ImagePicker picker = ImagePicker();
  final BiometricService _authService = BiometricService();

  SignupScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final image_provider = ref.watch(imageProvider);
    final isAuthenticated = ValueNotifier<bool>(false);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Signup'),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () async {
                  final XFile? image =
                      await picker.pickImage(source: ImageSource.gallery);
                  if (image != null) {
                    ref.read(imageProvider.notifier).state = image.path;
                  }
                },
                child: image_provider != null
                    ? displayImage(image_provider)
                    : displayIcon(),
              ),
              const SizedBox(
                height: 40,
              ),
              ValueListenableBuilder<bool>(
                valueListenable: isAuthenticated,
                builder: (context, value, child) {
                  return SizedBox(
                    width: 250,
                    child: ElevatedButton(
                      onPressed: () async {
                        isAuthenticated.value =
                            await _authService.authenticateWithBiometrics();
                        if (isAuthenticated.value) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Authentication successful')),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Authentication failed')),
                          );
                        }
                      },
                      child: Text(
                        value
                            ? "Authenticated"
                            : "Authenticate with Fingerprint",
                        style:
                            const TextStyle(color: AppColors.backgroundColor),
                      ),
                    ),
                  );
                },
              ),
              SizedBox(
                width: 250,
                child: ElevatedButton(
                  onPressed: () {
                    if (!isAuthenticated.value) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content:
                              Text("Please authenticate before registering"),
                        ),
                      );
                      return;
                    }
                    final path = ref.read(imageProvider);
                    if (path == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("select profile photo"),
                        ),
                      );
                      return;
                    }

                    final user = User(
                      imagePath: path,
                      isUserRegistered: isAuthenticated.value,
                    );

                    ref.watch(userProvider.notifier).registerUser(user);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("User registered successfully"),
                      ),
                    );
                    Navigator.pushReplacementNamed(context, '/');
                  },
                  child: const Text(
                    "Create New Account",
                    style: TextStyle(color: AppColors.backgroundColor),
                  ),
                ),
              ),
              SizedBox(
                width: 250,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/');
                  },
                  child: const Text(
                    'Already have an account, Login!',
                    style: TextStyle(color: AppColors.backgroundColor),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget displayImage(String imagePath) {
    return CircleAvatar(
      radius: 50,
      backgroundImage: FileImage(File(imagePath)),
    );
  }

  Widget displayIcon() {
    return const SizedBox(
      width: 100,
      height: 100,
      child: Icon(Icons.add_a_photo, size: 50),
    );
  }
}
