import 'package:demo_app/widgets/attendance_card.dart';
import 'package:demo_app/widgets/decorated_container.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AttendanceSummary extends StatelessWidget {
  const AttendanceSummary({super.key});

  final List<Map<String, dynamic>> _attendance = const [
    {
      'days': 13,
      'name': 'Present',
      'color': Colors.blue,
    },
    {
      'days': 0,
      'name': 'Absent',
      'color': Colors.orange,
    },
    {
      'days': 4,
      'name': 'Holiday',
      'color': Colors.lightGreen,
    },
    {
      'days': 6,
      'name': 'Half Day',
      'color': Colors.amber,
    },
    {
      'days': 4,
      'name': 'Week Off',
      'color': Colors.purple,
    },
    {
      'days': 3,
      'name': 'Leave',
      'color': Colors.lightBlue,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return DecoratedContainer(
      titleRow: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Attendance',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            DateFormat('dd MMMM yyyy').format(DateTime.now()),
            style: const TextStyle(color: Colors.black26),
          ),
        ],
      ),
      child: GridView.count(
        childAspectRatio: 3 / 2,
        crossAxisCount: 3,
        shrinkWrap: true,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        //padding: const EdgeInsets.all(2),
        physics: const NeverScrollableScrollPhysics(),
        children: _attendance
            .map(
              (data) => AttendanceCard(
                onTapHandler: () {},
                borderColor: data['color'],
                title: data['name'],
                numberOfDays: data['days'],
              ),
            )
            .toList(),
      ),
    );
  }
}
