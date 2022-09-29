import 'package:flutter/material.dart';

class CustomTexField {
  late String title;
  late String placeholder;
  late bool ispass;
  late String value;
  late String error;

  TextFormField textFormField() {
    return TextFormField(
      onChanged: (value) {
        value = value;
      },
      validator: (e) {
        if (e!.isEmpty) {
          return error;
        } else {
          return null;
        }
      },
      // ignore: prefer_const_constructors
      decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(3)))),
    );
  }
}
