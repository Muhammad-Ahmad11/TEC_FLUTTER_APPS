import 'package:flutter/material.dart';

class AuthModel extends ChangeNotifier {
  String? _username;
  String? _email;
  String? _password;
  bool _signedUp = false;
  bool _islogin = false;
  bool rememberMe = false;

  String get username => _username!;
  String get email => _email!;
  String get password => _password!;
  bool get signedUp => _signedUp;
  bool get isLogin => _islogin;
  bool get isrememberMe => rememberMe;

  void setUsername(String value) {
    _username = value;
    notifyListeners();
  }

  void setEmail(String value) {
    _email = value;
    notifyListeners();
  }

  void setPassword(String value) {
    _password = value;
    notifyListeners();
  }

  void setSignUpState(bool flag) {
    _signedUp = flag;
    notifyListeners();
  }

  void setLoginState(bool flag) {
    _islogin = flag;
    notifyListeners();
  }

  void setisRememberMe(bool flag) {
    rememberMe = flag;
    notifyListeners();
  }

  void clearState() {
    _username = null;
    _email = null;
    _password = null;
    _signedUp = false;
    _islogin = false;
    rememberMe = false;
    notifyListeners();
  }
}
