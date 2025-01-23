import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task1/models/auth_model.dart';
import 'package:task1/screens/login_screen.dart';
import 'package:task1/theme/colors.dart';
import 'package:task1/utlis/utlis.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late SharedPreferences prefs;
  String? username;
  String? email;

  @override
  void initState() {
    initialize_preferences();
    super.initState();
  }

  Future<void> initialize_preferences() async {
    prefs = await SharedPreferences.getInstance();
    username = prefs.getString(Utils.name);
    email = prefs.getString(Utils.email);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final auth_provider = Provider.of<AuthModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(Utils.homeScreen),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Column(
          children: [
            Text(Utils.welcomeMessage(username)),
            Text(Utils.emailMessage(email)),
            const SizedBox(height: 16.0),
            ElevatedButton(
              child: const Text(
                Utils.logout,
                style: TextStyle(color: AppColors.backgroundColor),
              ),
              onPressed: () {
                logout(auth_provider);
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> logout(AuthModel auth_provider) async {
    await prefs.clear();
    auth_provider.clearState();

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
    );
  }
}
