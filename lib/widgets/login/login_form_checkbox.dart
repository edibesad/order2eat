import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:order2eat/providers/all_providers.dart';

class LoginFormCheckBox extends StatelessWidget {
  const LoginFormCheckBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        return Checkbox(
            value: ref.watch(loginFormCheckBoxProvider.state).state,
            onChanged: (value) {
              ref.read(loginFormCheckBoxProvider.state).state = value!;
            });
      },
    );
  }
}
