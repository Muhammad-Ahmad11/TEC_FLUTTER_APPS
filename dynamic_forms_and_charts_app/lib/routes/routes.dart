import 'package:dynamic_forms_and_charts_app/views/charts_screen.dart';
import 'package:dynamic_forms_and_charts_app/views/dynamic_fields_screen.dart';
import 'package:flutter/material.dart';

final Map<String, WidgetBuilder> appRoutes = {
  '/': (context) => const DynamicFieldsScreen(),
  '/charts': (context) => const ChartScreen(),
};
