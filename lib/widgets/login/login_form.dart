// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:order2eat/constants/ui_helper.dart';
import 'package:order2eat/models/user_model.dart';
import 'package:order2eat/providers/all_providers.dart';
import 'package:order2eat/services/user_api.dart';
import 'package:order2eat/widgets/login/login_form_checkbox.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    TextEditingController _passwordController = TextEditingController();
    TextEditingController _emailController = TextEditingController();

    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: UIHelper.getLoginFormPadding(),
            child: TextFormField(
                controller: _emailController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'username_empty'.tr();
                  }
                  return null;
                },
                style: const TextStyle(),
                decoration: UIHelper.getTextFieldDecoration("username".tr())),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: UIHelper.getLoginFormPadding(),
            child: TextFormField(
                controller: _passwordController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'password_empty'.tr();
                  }
                  return null;
                },
                obscureText: true,
                enableSuggestions: false,
                autocorrect: false,
                style: const TextStyle(),
                decoration: UIHelper.getTextFieldDecoration("password".tr())),
          ),
          Padding(
            padding: UIHelper.getLoginFormPadding(),
            child: Row(children: [
              LoginFormCheckBox(),
              Text("remember_me").tr(),
            ]),
          ),
          Consumer(
            builder: ((context, ref, child) {
              return ElevatedButton(
                onPressed: () {
                  UserApi.postUser(
                          email: _emailController.text,
                          password: _passwordController.text)
                      .then((value) {
                    if (value == null) {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text("error").tr(),
                              content: const Text("user_not_found").tr(),
                              actions: [
                                ElevatedButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text("ok").tr())
                              ],
                            );
                          });
                    } else {
                      if (ref.read(loginFormCheckBoxProvider.state).state) {
                        rememberMe(value, _passwordController.text);
                      }
                      ref.read(userProvider.state).state = value;
                      ref.read(passwordProvider.state).state =
                          _passwordController.text;
                    }
                  });
                },
                style: ElevatedButton.styleFrom(primary: Colors.white),
                child: const Text(
                  "login",
                  style: TextStyle(
                    color: Colors.red,
                  ),
                ).tr(),
              );
            }),
          )
        ],
      ),
    );
  }

  Future<void> rememberMe(UserModel userModel, String password) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt("id", userModel.user!.id!);
    prefs.setInt("company_id", userModel.user!.companyId!);
    prefs.setString("name", userModel.user!.name!);
    prefs.setString("surname", userModel.user!.surname!);
    prefs.setString("email", userModel.user!.email!);
    prefs.setString(
        "picture_thumb",
        userModel.user!.pictureThumb == null
            ? ""
            : userModel.user!.pictureThumb!);
    prefs.setString("password", password);
    // prefs.setString("user", userModel.toJson());
  }
}
