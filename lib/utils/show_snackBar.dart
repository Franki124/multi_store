import 'package:flutter/material.dart';

showSnack(context, String title, Color color) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    backgroundColor: color,
    content: Text(
      title,
      style: TextStyle(fontWeight: FontWeight.bold),
    ),
  ));
}
