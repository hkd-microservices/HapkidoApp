import 'package:http/http.dart' as http;
import 'package:vitalles/Business/Core/SecureStorage.dart';
import 'package:vitalles/Models/FormModels/ChangePasswordFormModel.dart';
import 'package:vitalles/Models/FormModels/LoginFormModel.dart';
import 'package:vitalles/Models/FormModels/RegisterFormModel.dart';
import 'package:vitalles/Models/FormModels/ResetPasswordFormModel.dart';
import 'package:vitalles/Utils/Global.dart';
import 'package:vitalles/Utils/GlobalUserInfo.dart';
import 'dart:async';
import 'dart:convert';

class AuthController {
  static Future<bool> login(LoginFormModel loginModel) async {
    final response = await http.post(Global.url + '/api/Authentication/Login',
        headers: Global.headers, body: json.encode(loginModel));
    if (response.statusCode != 200) {
      return false;
    }

    Map globalUserInfoMap = jsonDecode(response.body);
    var userInfo = GlobalUserInfo.fromJson(globalUserInfoMap);

    Global.token = userInfo.token;
    Global.fullName = userInfo.fullName;
    Global.cpf = userInfo.cpf;
    if (userInfo.avatar != null && userInfo.avatar.isNotEmpty) {
      Global.avatarPath = Global.url + "/" + userInfo.avatar;
    }

    if (Global.avatarPath == null) {
      Global.avatarText = Global.avatarLetter(userInfo.fullName);
    }

    //Save user data to call login again
    SecureStorage.saveUserData(loginModel.cpf, loginModel.password);

    return Global.token != null && Global.token != "";
  }

  static Future<bool> forgotPassword(
      ResetPasswordFormModel resetPasswordModel) async {
    final response = await http.post(
        Global.url + '/api/Authentication/ResetPassword',
        headers: Global.headers,
        body: json.encode(resetPasswordModel));

    return response.statusCode != 200 ? false : true;
  }

  static Future<String> changePassword(
      ChangePasswordFormModel changePasswordModel) async {
    final response = await http.post(
        Global.url + '/api/Authentication/ChangePassword',
        headers: Global.headers,
        body: json.encode(changePasswordModel));

    if (response.statusCode == 200) {
      SecureStorage.saveUserData(
          changePasswordModel.cpf, changePasswordModel.newPassword);
    }

    return response.statusCode != 200 ? jsonDecode(response.body) : "";
  }

  static Future<bool> register(RegisterFormModel registerModel) async {
    final response = await http.post(
        Global.url + '/api/Authentication/Register',
        headers: Global.headers,
        body: json.encode(registerModel));

    return response.statusCode != 200 ? false : true;
  }
}
