import 'package:flutter/material.dart';

Widget FromField({
  required TextEditingController? controller,
  required Function(String?)? validator,
  required Widget icon,
  required String text,
  required TextInputType keyboardType,
  Color color = Colors.white,
  double paddingContentV = 4,
  double paddingContentH = 50,
  bool obscure = false,
}) {
  return TextFormField(
    controller: controller,
    validator: (value) => validator!(value),
    textAlign: TextAlign.left,
    obscureText: obscure,
    keyboardType: keyboardType,
    style: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.w400,
      color: Colors.black,
    ),
    decoration: InputDecoration(
      fillColor: color,
      filled: true,
      contentPadding: EdgeInsets.symmetric(
        horizontal: paddingContentH,
        vertical: paddingContentV,
      ),
      suffixIcon: icon,
      hintText: text,
      disabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Color.fromARGB(255, 179, 177, 177)),
        borderRadius: BorderRadius.circular(30),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.white),
        borderRadius: BorderRadius.circular(30),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: BorderSide(color: Colors.black),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: BorderSide(color: Colors.red),
      ),
    ),
  );
}
