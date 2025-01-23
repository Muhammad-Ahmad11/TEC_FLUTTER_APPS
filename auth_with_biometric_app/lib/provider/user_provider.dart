import 'package:auth_with_biometric/model/user.dart';
import 'package:auth_with_biometric/provider/box_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';

final userProvider = StateNotifierProvider<UserNotifier, User?>((ref) {
  final box = ref.watch(boxProvider);
  return UserNotifier(box);
});

class UserNotifier extends StateNotifier<User?> {
  final Box<User?> box;

  UserNotifier(this.box) : super(box.values.isEmpty ? null : box.values.first);

  void registerUser(User user) {
    box.put('user', user);
    state = user;
  }

  User? getUser() {
    return state;
  }

  void logout() {
    box.clear();
    state = null;
  }
}
