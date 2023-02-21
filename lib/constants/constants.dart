import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Constants {
  static const TextStyle headingStyle = TextStyle(
    color: Colors.black,
    fontSize: 23,
  );

  static const TextStyle colorStyle = TextStyle(
    color: Colors.grey,
    fontSize: 12.0,
    fontWeight: FontWeight.bold,
  );

  static TextStyle descriptionStyle = TextStyle(
    color: Colors.grey.shade500,
  );

  static BoxDecoration containerDecoration = BoxDecoration(
    color: Colors.grey.shade300,
    borderRadius: const BorderRadius.all(Radius.circular(10.0)),
  );

  static const InputDecoration colorFieldDecoration = InputDecoration(
    contentPadding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 20.0),
    border: InputBorder.none,
    hintStyle: TextStyle(
      color: Colors.black45,
    ),
  );

  static BoxDecoration addButtonDecoration = const BoxDecoration(
    color: CupertinoColors.systemPurple,
    shape: BoxShape.circle,
  );
}
