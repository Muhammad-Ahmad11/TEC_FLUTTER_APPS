import 'package:dynamic_forms_and_charts_app/database/db_helper.dart';
import 'package:dynamic_forms_and_charts_app/models/field_model.dart';
import 'package:flutter/material.dart';

class FieldViewModel extends ChangeNotifier {
  final DatabaseHelper _databaseHelper = DatabaseHelper.instance;

  List<FieldModel> _fields = [];
  List<FieldModel> get fields => _fields;

  final List<TextEditingController> controllers = [];

  Future<void> fetchFields() async {
    try {
      _fields = await _databaseHelper.getFields();
      notifyListeners();
    } catch (error) {
      debugPrint('Error fetching fields: $error');
    }
  }

  Future<void> insertField(String fieldName, double fieldValue) async {
    final field = FieldModel(fieldName: fieldName, fieldValue: fieldValue);
    await _databaseHelper.insertField(field);
    await fetchFields();
  }

  Future<void> deleteAllFields() async {
    await _databaseHelper.deleteAllFields();
    await fetchFields();
  }

  void addController() {
    controllers.add(TextEditingController());
    notifyListeners();
  }
}
