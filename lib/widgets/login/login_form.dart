// ignore_for_file: no_leading_underscores_for_local_identifiers

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
                    return 'Username cannot be empty ';
                  }
                  return null;
                },
                style: const TextStyle(),
                decoration: UIHelper.getTextFieldDecoration("Username")),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: UIHelper.getLoginFormPadding(),
            child: TextFormField(
                controller: _passwordController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Password cannot be empty ';
                  }
                  return null;
                },
                obscureText: true,
                enableSuggestions: false,
                autocorrect: false,
                style: const TextStyle(),
                decoration: UIHelper.getTextFieldDecoration("Password")),
          ),
          Padding(
            padding: UIHelper.getLoginFormPadding(),
            child: Row(children: const [
              LoginFormCheckBox(),
              Text("Remember me"),
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
                              title: const Text("Error"),
                              content: const Text("User not found"),
                              actions: [
                                ElevatedButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text("Ok"))
                              ],
                            );
                          });
                    } else {
                      if (ref.read(loginFormCheckBoxProvider.state).state) {
                        rememberMe(value);
                      }
                      ref.read(userProvider.state).state = value;
                    }
                  });
                },
                style: ElevatedButton.styleFrom(primary: Colors.white),
                child: const Text(
                  "Login",
                  style: TextStyle(
                    color: Colors.red,
                  ),
                ),
              );
            }),
          )
        ],
      ),
    );
  }

  Future<void> rememberMe(UserModel userModel) async {
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
    // prefs.setString("user", userModel.toJson());
  }
}
