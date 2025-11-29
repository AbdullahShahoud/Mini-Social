import 'package:flutter/material.dart';

Widget ButtonAuth({
  Color color = Colors.blue,
  double paddingV = 8,
  double paddingH = 100,
  required String text,
  required VoidCallback function,
}) => ElevatedButton(
  onPressed: function,
  child: Text(
    text,
    style: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: Colors.black,
    ),
  ),
  style: ElevatedButton.styleFrom(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
    backgroundColor: color,
    padding: EdgeInsets.symmetric(vertical: paddingV, horizontal: paddingH),
    elevation: 0.7,
    side: BorderSide(color: Colors.black, width: 1, style: BorderStyle.solid),
  ),
);
