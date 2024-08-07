import 'package:demo_app/bloc/theme_bloc/theme_bloc.dart';
import 'package:demo_app/bloc/theme_bloc/theme_state.dart';
import 'package:demo_app/widgets/attendance_card.dart';
import 'package:demo_app/widgets/decorated_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../constants/constants.dart';

// Attendance widget in the employee details screen
class AttendanceSummary extends StatelessWidget {
  const AttendanceSummary({super.key});

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
          BlocBuilder<ThemeBloc, ThemeState>(builder: (context, state) {
            return Text(
              DateFormat('dd MMMM yyyy').format(DateTime.now()),
              style: TextStyle(
                  color: state.themeMode == ThemeMode.dark
                      ? Colors.white70
                      : Colors.black26),
            );
          }),
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
        children: attendance
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
