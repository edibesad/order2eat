import 'package:flutter/material.dart';

class UIHelper {
  static InputDecoration getTextFieldDecoration(String hint) {
    return InputDecoration(
      errorBorder: const OutlineInputBorder(
        borderSide: BorderSide(
          width: 2,
          color: Colors.orange,
        ),
      ),
      errorStyle: const TextStyle(color: Colors.black, fontSize: 16),
      filled: true,
      fillColor: Colors.white,
      border: const OutlineInputBorder(
        borderSide: BorderSide(
          width: 2,
          color: Colors.black,
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      enabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(
          width: 2,
          color: Colors.black,
          style: BorderStyle.solid,
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      hintText: hint,
    );
  }

  static EdgeInsets getListTilePadding() {
    return const EdgeInsets.all(1);
  }

  static getFloatingButtonPadding() {
    return const EdgeInsets.all(15);
  }

  static getBasketTextPadding() {
    return const EdgeInsets.only(right: 30, left: 10);
  }

  static getLoginFormPadding() {
    return const EdgeInsets.symmetric(horizontal: 72);
  }
}
