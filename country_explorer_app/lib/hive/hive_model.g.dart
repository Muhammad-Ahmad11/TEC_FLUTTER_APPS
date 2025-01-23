// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CountryAdapter extends TypeAdapter<Country> {
  @override
  final int typeId = 0;

  @override
  Country read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Country(
      name: fields[0] as String,
      flagUrl: fields[1] as String,
      region: fields[2] as String,
      capital: fields[3] as String,
      population: fields[4] as int,
      latlng: (fields[5] as List).cast<double>(),
    );
  }

  @override
  void write(BinaryWriter writer, Country obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.flagUrl)
      ..writeByte(2)
      ..write(obj.region)
      ..writeByte(3)
      ..write(obj.capital)
      ..writeByte(4)
      ..write(obj.population)
      ..writeByte(5)
      ..write(obj.latlng);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CountryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
