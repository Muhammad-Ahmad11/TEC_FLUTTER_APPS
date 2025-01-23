import 'package:dynamic_forms_and_charts_app/routes/routes.dart';
import 'package:dynamic_forms_and_charts_app/theme/theme.dart';
import 'package:dynamic_forms_and_charts_app/view_models/field_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => FieldViewModel(),
      child: const myApp(),
    ),
  );
}

class myApp extends StatelessWidget {
  const myApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.theme,
      initialRoute: '/',
      routes: appRoutes,
    );
  }
}
