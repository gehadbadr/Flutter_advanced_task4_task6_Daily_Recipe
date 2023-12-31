import 'dart:convert';

import 'package:daily_recipe/consts/consts.dart';
import 'package:daily_recipe/models/user.models.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController extends ChangeNotifier {
  bool isLoading = false;
  bool obscureText = false;
  final prefsFile = GetIt.I.get<SharedPreferences>();
  List<UserModel> userLists = [];
  changeisLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  bool _isTrue = true;
  bool _isConfirmPassword = true;
  bool get isTrue => _isTrue;
  bool get isConfirmPassword => _isConfirmPassword;

  get switchPasswordIcon {
    return _isConfirmPassword
        ? Icon(
            Icons.visibility_off,
            color: ColorsApp.PKColor,
          )
        : Icon(Icons.visibility);
  }

  get switchConfirmPasswordIcon {
    return _isTrue
        ? Icon(
            Icons.visibility_off,
            color: ColorsApp.PKColor,
          )
        : Icon(Icons.visibility);
  }

  void toggleConfirmPassword() {
    _isConfirmPassword = !_isConfirmPassword;
    notifyListeners();
  }

  void togglePassword() {
    _isTrue = !_isTrue;
    notifyListeners();
  }

  //SharedPrefrence


  Future savePrefs({email, password, name, login}) async {
    prefsFile.setString('name', name);
    prefsFile.setString('email', email);
    prefsFile.setString('password', password);
    prefsFile.setBool('login', login);
    notifyListeners();

  }

  Future isLogin() async {
    bool? value = prefsFile.getBool('login');
    return value;
  }

  Future logOut() async {
    prefsFile.setBool('login', false);
    notifyListeners();
  }

  Future getUesr() async {
    String? userValue = prefsFile.getString('name');
    String? emailValue = prefsFile.getString('email');
    String? passwordValue = prefsFile.getString('password');
    bool? loginValue = prefsFile.getBool('login');
    //List data =[userValue,emailValue,passwordValue,loginValue];
    Map<String, dynamic> info = {
      'user': userValue,
      'email': emailValue,
      'password': passwordValue,
      'login': loginValue,
    };
    return info;
    //notifyListeners();
  }
}







/*
  Future savePrefs({email, password, name, login}) async {
    prefsFile.setString(
        'userModel',
        jsonEncode(UserModel(
                name: name, email: email, password: password, login: login)
            .toJson()));
    print(prefsFile.getString('userModel'));
  }


  void getUser() async{
        print('DHJZHFJFGHDFKJHGKJ');
    var userData = await prefsFile.getString('userModel');
    //print(userData);
        var dataDecoded = List<Map<String, dynamic>>.from(jsonDecode(userData!));
  userLists = dataDecoded.map((e) => UserModel.fromJson(e)).toList();
      print(userLists);

      notifyListeners();

  }
*/
