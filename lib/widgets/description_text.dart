
import 'package:flutter/material.dart';
import 'package:color_design_app/constants/constants.dart';

class DescriptionText extends StatelessWidget {
  const DescriptionText({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Text(
        text,
        style: Constants.descriptionStyle,
      ),
    );
  }
}