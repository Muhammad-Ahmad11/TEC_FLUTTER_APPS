import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task1/models/auth_model.dart';
import 'package:task1/screens/home_screen.dart';
import 'package:task1/screens/signup_screen.dart';
import 'package:task1/theme/colors.dart';
import 'package:task1/utlis/utlis.dart';
import 'package:task1/widgets/password_validator.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late SharedPreferences prefs;
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  bool signUpFlag = false;

  @override
  void initState() {
    initialize_preferences();
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> initialize_preferences() async {
    prefs = await SharedPreferences.getInstance();
    signUpFlag = prefs.getBool(Utils.signup) ?? false;
  }

  @override
  Widget build(BuildContext context) {
    final auth_provider = Provider.of<AuthModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(Utils.login),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                decoration: const InputDecoration(
                  labelText: Utils.email,
                ),
                controller: _emailController,
              ),
              const SizedBox(height: 16),
              TextField(
                decoration: const InputDecoration(
                  labelText: Utils.password,
                ),
                controller: _passwordController,
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Checkbox(
                    value: auth_provider.rememberMe,
                    onChanged: (value) {
                      auth_provider.setisRememberMe(value!);
                    },
                  ),
                  const Text(Utils.rememberMe),
                ],
              ),
              ElevatedButton(
                child: const Text(
                  Utils.login,
                  style: TextStyle(color: AppColors.backgroundColor),
                ),
                onPressed: () {
                  _saveDataLogin(context, auth_provider);
                },
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                child: const Text(
                  Utils.signUpPrompt,
                  style: TextStyle(color: AppColors.backgroundColor),
                ),
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SignupScreen()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _saveDataLogin(
      BuildContext context, AuthModel auth_provider) async {
    if (auth_provider.signedUp || signUpFlag) {
      if (_emailController.text.isEmpty) {
        Utils.showSnackBar(context, Utils.emailEmpty);
        return;
      }

      if (_passwordController.text.isEmpty) {
        Utils.showSnackBar(context, Utils.passwordEmpty);
        return;
      }

      if (!_emailController.text.endsWith(Utils.emailValidation)) {
        Utils.showSnackBar(context, Utils.invalidEmailFormat);
        return;
      }

      String? value = validatePassword(_passwordController.text);
      if (value != null) {
        auth_provider.setEmail(_emailController.text);
        auth_provider.setPassword(_passwordController.text);
        Utils.showSnackBar(context, Utils.loginSuccess);

        auth_provider.setLoginState(true);

        if (auth_provider.isrememberMe) {
          await prefs.setString(Utils.email, _emailController.text);
          await prefs.setString(Utils.password, _passwordController.text);
          await prefs.setBool(Utils.login, auth_provider.isLogin);
        } else {
          await prefs.setBool(Utils.login, false);
        }

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        );
      } else {
        Utils.showSnackBar(context, value!);
      }
    } else {
      Utils.showSnackBar(context, Utils.createAccountFirst);
    }
  }
}
