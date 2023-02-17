import 'package:flutter/material.dart';

class Constants {
  static const TextStyle headingStyle = TextStyle(
    color: Colors.black,
    fontSize: 23,
  );

  static BoxDecoration containerDecoration = BoxDecoration(
    color: Colors.grey.shade300,
    borderRadius: const BorderRadius.all(Radius.circular(10.0)),
  );

  static const InputDecoration taskFieldDecoration = InputDecoration(
    hintText: 'Enter Your Notes',
    contentPadding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 20.0),
    border: InputBorder.none,
    hintStyle: TextStyle(
      color: Colors.black45,
    ),
  );

  static BoxDecoration addButtonDecoration = BoxDecoration(
    color: Colors.purple.shade400,
    shape: BoxShape.circle,
  );
}
