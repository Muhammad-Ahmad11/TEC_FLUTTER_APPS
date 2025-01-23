import 'package:task1/theme/colors.dart';
import 'package:task1/widgets/custom_snack_bar.dart';
import 'package:flutter/material.dart';

class Utils {
  // assets paths
  static const String imagePath = 'assets/logo.png';

  // General Tags
  static const String login = 'Login';
  static const String signup = 'Signup';
  static const String homeScreen = 'Home Screen';
  static const String email = "Email";
  static const String password = "Password";
  static const String rememberMe = "Remember Me";
  static const String signUpPrompt = "Don't have an account? Signup!";
  static const String userName = "Username";
  static const String name = "Name";
  static const String logout = "Logout";

  // Validation Messages
  static const String usernameEmpty = "Username should not be empty";
  static const String emailEmpty = "Email should not be empty";
  static const String passwordEmpty = "Password should not be empty";
  static const String invalidEmailFormat = "Invalid email format";
  static const String loginSuccess = "Login successful!";
  static const String signupSuccess = "Signup successful!";
  static const String createAccountFirst = "Please create an account first!";
  static const String failedToSaveInSharedPreferences =
      "Failed to save data in Shared preferences";
  static const String emailValidation = '@gmail.com';

  // Dynamic Strings
  static String welcomeMessage(String? username) {
    return 'Welcome, ${username ?? 'User'}!';
  }

  static String emailMessage(String? email) {
    return 'Your email is: ${email ?? 'Not available'}';
  }

  // functions
  static void showSnackBar(BuildContext context, String message) {
    CustomSnackBar.show(
        context, message, AppColors.backgroundColor, AppColors.textColor);
  }

  static int calculatePasswordStrength(String password) {
    int strength = 0;

    if (password.length >= 8) strength++;
    if (RegExp(r'[A-Z]').hasMatch(password)) strength++;
    if (RegExp(r'[0-9]').hasMatch(password)) strength++;
    if (RegExp(r'[!@#\$%^&*(),.?":{}|<>]').hasMatch(password)) strength++;

    return strength;
  }
}
