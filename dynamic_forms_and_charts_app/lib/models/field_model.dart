class FieldModel {
  final int? id;
  final String fieldName;
  final double fieldValue;

  FieldModel({this.id, required this.fieldName, required this.fieldValue});

  // fields to map conversion
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'fieldName': fieldName,
      'fieldValue': fieldValue,
    };
  }

  // map to fields conversion
  factory FieldModel.fromMap(Map<String, dynamic> map) {
    return FieldModel(
      id: map['id'],
      fieldName: map['fieldName'],
      fieldValue: map['fieldValue'],
    );
  }
}
