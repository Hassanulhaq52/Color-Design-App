import 'package:flutter/material.dart';

class ColorDesignModel {
  ColorDesignModel({
    this.colorName,
    this.colorNotes,
    this.red,
    this.green,
    this.blue,
    this.opacity,
    this.containerColor,
  });

  final String? colorName;
  final String? colorNotes;
  final double? red;
  final double? green;
  final double? blue;
  final double? opacity;
  final Color? containerColor;

}
