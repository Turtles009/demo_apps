import 'dart:convert';

import 'package:demo_app/model/employee_details.dart';
import 'package:http/http.dart' as http;

import '../constants/constants.dart';

class EmployeeApi {
  Future<List<EmployeeDetails>> fetchEmployees() async {
    final response = await http.get(Uri.parse('${baseUrl}employee_api.json'));
    await Future.delayed(const Duration(seconds: 2));
    if (response.statusCode == 200) {
      List<EmployeeDetails> employees = (json.decode(response.body) as List)
          .map(
            (e) => EmployeeDetails.fromJson(e),
          )
          .toList();
      return employees;
    } else {
      throw Exception('Failed to load employees');
    }
  }

  Future<Map<String, List<double>>> fetchChartData(String employeeID) async {
    final response = await http.get(Uri.parse('${baseUrl}chart_data.json'));
    await Future.delayed(const Duration(seconds: 2));
    if (response.statusCode == 200) {
      var data = json.decode(response.body)[employeeID];
      List<double> hours = List<double>.from(
        data['hours'].map(
          (x) => x.toDouble(),
        ),
      );
      List<double> week = List<double>.from(
        data['week'].map(
          (x) => x.toDouble(),
        ),
      );
      return {'hours': hours, 'week': week};
    } else {
      throw Exception('Failed to load chart data');
    }
  }
}
