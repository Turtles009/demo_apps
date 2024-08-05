import 'package:demo_app/helper/time_helper.dart';
import 'package:demo_app/model/employee_details.dart';
import 'package:demo_app/screens/employee_details_screen.dart';

import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class EmployeeCard extends StatelessWidget {
  const EmployeeCard({
    super.key,
    required this.details,
  });

  final EmployeeDetails details;

  @override
  Widget build(BuildContext context) {
    double progress = details.workedHours / details.totalHours;
    final color =
        details.status == EmployeeStatus.present ? Colors.blue : Colors.orange;

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => EmployeeDetailsScreen(
              id: details.id,
              employeeName: details.name,
              employeeDesignation: details.role,
            ),
          ),
        );
      },
      child: Card(
        margin: const EdgeInsets.all(8.0),
        color: Colors.white,
        shadowColor: Colors.black26,
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                children: [
                  const CircleAvatar(
                    child: Icon(Icons.person),
                  ),
                  const SizedBox(width: 16.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(details.name,
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                      Text(details.role,
                          style: const TextStyle(color: Colors.grey)),
                    ],
                  ),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 4.0, horizontal: 20.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: color.withAlpha(30),
                    ),
                    child: Text(
                      details.status.name.substring(0, 1).toUpperCase(),
                      style: TextStyle(
                          color: color,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24.0),
              Column(
                children: [
                  Row(
                    children: [
                      const RowTitleText(
                        text: 'Date',
                        textAlign: TextAlign.start,
                      ),
                      const RowTitleText(
                        text: 'In Time',
                        textAlign: TextAlign.center,
                      ),
                      const RowTitleText(
                        text: 'Out Time',
                        textAlign: TextAlign.end,
                      ),
                    ].expandEqually().toList(),
                  ),
                ],
              ),
              const SizedBox(height: 4.0),
              const Divider(
                height: 1,
                color: Colors.black12,
              ),
              const SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RowDataText(text: details.date, textAlign: TextAlign.start),
                  RowDataText(
                      text: details.inTime, textAlign: TextAlign.center),
                  RowDataText(text: details.outTime, textAlign: TextAlign.end),
                ].expandEqually().toList(),
              ),
              const SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    details.status == EmployeeStatus.present
                        ? 'Approved'
                        : 'Absent',
                    style: TextStyle(
                      color: details.status == EmployeeStatus.present
                          ? Colors.green
                          : Colors.red,
                    ),
                  ),
                  CircularPercentIndicator(
                    radius: 44.0,
                    lineWidth: 5.0,
                    percent: progress,
                    center: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          (details.workedHours).convertToHoursAndMinutes(),
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'of ${details.totalHours} Hours',
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontSize: 10),
                        )
                      ],
                    ),
                    progressColor: Colors.orange,
                    backgroundColor: Colors.grey.shade200,
                    circularStrokeCap: CircularStrokeCap.round,
                  ),
                  const SizedBox()
                ].expandEqually().toList(),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class RowTitleText extends StatelessWidget {
  const RowTitleText({
    super.key,
    required this.text,
    required this.textAlign,
  });

  final String text;
  final TextAlign textAlign;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.bold,
      ),
      textAlign: textAlign,
    );
  }
}

class RowDataText extends StatelessWidget {
  const RowDataText({
    super.key,
    required this.text,
    required this.textAlign,
  });

  final String text;
  final TextAlign textAlign;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        color: Colors.grey,
      ),
      textAlign: textAlign,
    );
  }
}

extension ExpandEqually on Iterable<Widget> {
  Iterable<Widget> expandEqually() => map(
        (w) => Expanded(child: w),
      );
}
