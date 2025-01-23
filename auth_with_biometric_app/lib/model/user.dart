import 'package:hive/hive.dart';

part 'user.g.dart';

@HiveType(typeId: 0)
class User extends HiveObject {
  @HiveField(0)
  final String imagePath;

  @HiveField(1)
  final bool isUserRegistered;

  User({
    required this.imagePath,
    required this.isUserRegistered,
  });
}
