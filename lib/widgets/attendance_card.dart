import 'package:flutter/material.dart';

class AttendanceCard extends StatelessWidget {
  const AttendanceCard({
    super.key,
    required this.onTapHandler,
    required this.borderColor,
    required this.title,
    int? numberOfDays,
  }) : numberOfDays = numberOfDays ?? 0;

  final VoidCallback onTapHandler;
  final Color borderColor;
  final String title;
  final int numberOfDays;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTapHandler,
      child: Container(
        decoration: BoxDecoration(
          color: borderColor.withAlpha(30),
          borderRadius: BorderRadius.circular(8),
          border: Border(
            top: BorderSide(
              width: 4,
              color: borderColor,
            ),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '$numberOfDays',
                style: TextStyle(
                  color: borderColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(title)
            ],
          ),
        ),
      ),
    );
  }
}
