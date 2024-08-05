import 'package:demo_app/theme/theme.dart';
import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  const Button({
    super.key,
    bool? isPrimary,
    required this.buttonText,
  })  : height = 52,
        isPrimary = isPrimary ?? true;

  final bool isPrimary;
  final double? height;
  final String buttonText;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: double.infinity,
      // padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: isPrimary ? color : Colors.blueGrey.shade100,
      ),
      child: Center(
        child: Text(
          buttonText,
          style: TextStyle(
            color: isPrimary ? Colors.white : Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}
