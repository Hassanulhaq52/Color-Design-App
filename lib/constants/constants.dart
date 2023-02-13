import 'package:flutter/material.dart';

class Constants {
  static const TextStyle headingStyle = TextStyle(
    color: Colors.black,
    fontSize: 23,
  );

  static InputDecoration taskFieldDecoration = InputDecoration(
    fillColor: Colors.grey.shade200,
    filled: true,
    hintText: 'Enter Your Task',
    contentPadding:
        const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
    border: const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(10.0)),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.grey.shade100,
      ),
      borderRadius: const BorderRadius.all(Radius.circular(10.0)),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.grey.shade100,
      ),
      borderRadius: const BorderRadius.all(Radius.circular(10.0)),
    ),
  );
}
