import 'package:dynamic_forms_and_charts_app/models/field_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
  static Database? _database;

  /// private constructore for achieving singleton behaviour
  DatabaseHelper._privateConstructor();

  // get instance (Singleton Method)
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  // initilize DB
  Future<Database> _initDatabase() async {
    final path = await getDatabasesPath();
    return openDatabase(
      join(path, 'fields.db'),
      version: 1,
      onCreate: (db, version) {
        db.execute('''
          CREATE TABLE fields (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            fieldName TEXT,
            fieldValue REAL
          )
        ''');
      },
    );
  }

  // insert a field
  /*Future<int> insertField(FieldModel field) async {
    final db = await database;
    return db.insert('fields', field.toMap());
  }*/

  Future<int> insertField(FieldModel field) async {
    final db = await database;

    // Check if a field with same name already exists
    final existingField = await db.query(
      'fields',
      where: 'fieldName = ?',
      whereArgs: [field.fieldName],
    );

    if (existingField.isNotEmpty) {
      // If yes, update its value by adding new one
      final existingValue = existingField.first['fieldValue'] as double;
      final newValue = existingValue + field.fieldValue;

      return db.update(
        'fields',
        {'fieldValue': newValue},
        where: 'fieldName = ?',
        whereArgs: [field.fieldName],
      );
    } else {
      // If no, insert a new field
      return db.insert('fields', field.toMap());
    }
  }

  // query to get all the fields
  Future<List<FieldModel>> getFields() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('fields');
    return List.generate(maps.length, (i) => FieldModel.fromMap(maps[i]));
  }

  // deleting all fields
  Future<int> deleteAllFields() async {
    final db = await database;
    return db.delete('fields');
  }
}
