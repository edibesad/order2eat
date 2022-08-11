import 'package:flutter/material.dart';
import 'package:order2eat/widgets/login/login_form.dart';
import '../widgets/login/login_form.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      // backgroundColor: Theme.of(context).primaryColor,
      body: Center(child: LoginForm()),
    );
  }
}
