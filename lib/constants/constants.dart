import 'package:flutter/material.dart';

const List<Map<String, dynamic>> attendance = [
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

const color = Color(0xff5e7cec);

const String baseUrl = 'http://192.168.1.48:5500/api/';
