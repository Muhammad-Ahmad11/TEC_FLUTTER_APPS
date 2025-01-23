import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task1/models/auth_model.dart';
import 'package:task1/screens/login_screen.dart';
import 'package:task1/theme/colors.dart';
import 'package:task1/utlis/utlis.dart';
import 'package:task1/widgets/password_validator.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final ValueNotifier<int> passwordStrength = ValueNotifier(0);
  late SharedPreferences prefs;
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  @override
  void initState() {
    initialize_preferences();
    super.initState();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    passwordStrength.dispose();
    super.dispose();
  }

  Future<void> initialize_preferences() async {
    prefs = await SharedPreferences.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    final auth_provider = Provider.of<AuthModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(Utils.signup),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                decoration: const InputDecoration(
                  labelText: Utils.userName,
                ),
                controller: _usernameController,
              ),
              const SizedBox(height: 16),
              TextField(
                decoration: const InputDecoration(
                  labelText: Utils.email,
                ),
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 16),
              TextField(
                decoration: const InputDecoration(
                  labelText: Utils.password,
                ),
                controller: _passwordController,
                obscureText: true,
                onChanged: (value) {
                  passwordStrength.value =
                      Utils.calculatePasswordStrength(value);
                },
              ),
              const SizedBox(height: 20),
              ValueListenableBuilder<int>(
                valueListenable: passwordStrength,
                builder: (context, strength, _) {
                  return Visibility(
                    visible: strength > 0,
                    child: Container(
                      height: 8,
                      margin: const EdgeInsets.only(top: 8),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: Colors.grey[300],
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            flex: strength,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                color: strength == 1
                                    ? Colors.red
                                    : strength == 2
                                        ? Colors.orange
                                        : strength == 3
                                            ? Colors.yellow
                                            : Colors.green,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 4 - strength,
                            child: const SizedBox(),
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                child: const Text(
                  Utils.signup,
                  style: TextStyle(color: AppColors.backgroundColor),
                ),
                onPressed: () {
                  _saveData(context, auth_provider);
                },
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                child: const Text(
                  Utils.login,
                  style: TextStyle(color: AppColors.backgroundColor),
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginScreen()));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _saveData(BuildContext context, AuthModel auth_provider) async {
    if (_usernameController.text.isEmpty) {
      Utils.showSnackBar(context, Utils.usernameEmpty);
      return;
    }

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
      // add the signup logic
      bool nameSaved =
          await prefs.setString(Utils.name, _usernameController.text);
      bool emailSaved =
          await prefs.setString(Utils.email, _emailController.text);
      bool passwordSaved =
          await prefs.setString(Utils.password, _passwordController.text);

      if (emailSaved && passwordSaved && nameSaved) {
        auth_provider.setUsername(_usernameController.text);
        auth_provider.setEmail(_emailController.text);
        auth_provider.setPassword(_passwordController.text);

        // auth here
        auth_provider.setSignUpState(true);
        prefs.setBool(Utils.signup, true);
        Utils.showSnackBar(context, Utils.signupSuccess);

        // Navigate to login screen
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const LoginScreen()),
        );
      } else {
        Utils.showSnackBar(context, Utils.failedToSaveInSharedPreferences);
      }
    } else {
      Utils.showSnackBar(context, value!);
    }
  }
}
