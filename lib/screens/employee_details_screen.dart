import 'package:demo_app/bloc/chart_bloc/chart_event.dart';
import 'package:demo_app/bloc/chart_bloc/chart_state.dart';
import 'package:demo_app/bloc/theme_bloc/theme_bloc.dart';
import 'package:demo_app/bloc/theme_bloc/theme_state.dart';
import 'package:demo_app/widgets/attendance_summary.dart';
import 'package:demo_app/widgets/button.dart';
import 'package:demo_app/widgets/working_hour_chart.dart';
import 'package:flutter/material.dart';

import 'package:demo_app/widgets/body_container.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../bloc/chart_bloc/chart_bloc.dart';

class EmployeeDetailsScreen extends StatefulWidget {
  const EmployeeDetailsScreen({
    super.key,
    required this.employeeName,
    required this.employeeDesignation,
    required this.id,
  });

  final String id;
  final String employeeName, employeeDesignation;

  @override
  State<EmployeeDetailsScreen> createState() => _EmployeeDetailsScreenState();
}

class _EmployeeDetailsScreenState extends State<EmployeeDetailsScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<ChartBloc>(context).add(FetchChart(employeeId: widget.id));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        clipBehavior: Clip.none,
        titleTextStyle: GoogleFonts.poppins(
          textStyle: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500,
            fontSize: 20,
          ),
        ),
        titleSpacing: 0,
        leadingWidth: 80,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('${widget.employeeName} Details'),
            Text(
              widget.employeeDesignation,
              style: const TextStyle(
                fontSize: 12,
                color: Colors.white70,
              ),
            ),
          ],
        ),
        leading: Container(
          margin: const EdgeInsets.all(8),
          //padding: EdgeInsets.all(8),
          child: const CircleAvatar(
            child: Icon(Icons.person),
          ),
        ),
      ),
      body: BodyContainer(
        child: Column(
          children: [
            const Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 24),
                child: Column(
                  children: [
                    Expanded(
                      flex: 3,
                      child: WorkingHourChart(),
                    ),
                    SizedBox(height: 16),
                    Expanded(
                      flex: 2,
                      child: AttendanceSummary(),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 8),
            BlocBuilder<ThemeBloc, ThemeState>(builder: (context, state) {
              return Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                    color: state.themeMode == ThemeMode.dark
                        ? Colors.grey.shade800
                        : Colors.white),
                child: const Row(
                  children: [
                    Expanded(
                        child: Button(
                      buttonText: 'Delete',
                      isPrimary: false,
                    )),
                    SizedBox(width: 16),
                    Expanded(
                      child: Button(
                        buttonText: 'Edit',
                        isPrimary: true,
                      ),
                    ),
                  ],
                ),
              );
            })
          ],
        ),
      ),
    );
  }
}
