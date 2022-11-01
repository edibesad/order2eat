import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:order2eat/models/user_model.dart';

class UserApi {
  static Future<UserModel?> postUser(
      {required String email, required String password}) async {
    try {
      var formData = FormData.fromMap({
        "email": email,
        "password": password,
        "api_key": ""
      });
      var response =
          await Dio().post('', data: formData);
      if (response.data["error"] == "Kullanıcı Bulunamadı") {
        return null;
      }
      UserModel userModel = UserModel.fromJson(jsonDecode(response.toString()));
      return userModel;
    } catch (e) {
      debugPrint(e.toString());
      return UserModel();
    }
  }
}
