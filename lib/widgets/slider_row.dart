import 'package:flutter/material.dart';

class SliderRow extends StatelessWidget {
  const SliderRow({
    super.key,
    required this.containerColor,
    required this.onChanged,
    required this.value,
  });

  final void Function(double)? onChanged;
  final Color containerColor;
  final double value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 40, right: 20),
      child: Row(
        children: [
          Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: containerColor,
            ),
          ),
          SliderTheme(
            data: const SliderThemeData(
              trackHeight: 10,
            ),
            child: SizedBox(
              width: 270,
              child: Slider(
                max: 255.0,
                min: 0.0,
                activeColor: containerColor,
                inactiveColor: Colors.grey.shade200,
                thumbColor: Colors.grey.shade300,
                value: value,
                onChanged: onChanged,
              ),
            ),
          ),
        ],
      ),
    );
  }
}