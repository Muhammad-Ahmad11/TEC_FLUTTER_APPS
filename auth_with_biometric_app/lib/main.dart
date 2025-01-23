import 'package:auth_with_biometric/model/user.dart';
import 'package:auth_with_biometric/provider/box_provider.dart';
import 'package:auth_with_biometric/screens/login_screen.dart';
import 'package:auth_with_biometric/screens/main_screen.dart';
import 'package:auth_with_biometric/screens/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/adapters.dart';

import 'theme/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(UserAdapter());
  final box = await Hive.openBox<User>('box');

  runApp(ProviderScope(
    overrides: [
      boxProvider.overrideWithValue(box),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task 02',
      routes: {
        '/': (_) => const LoginScreen(),
        '/signup': (_) => SignupScreen(),
        '/main': (_) => const MainScreen(),
      },
      debugShowCheckedModeBanner: false,
      theme: AppTheme.theme,
      darkTheme: AppTheme.theme,
      supportedLocales: {const Locale('en', ' ')},
    );
  }
}
