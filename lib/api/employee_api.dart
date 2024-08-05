import 'dart:convert';

import 'package:demo_app/model/employee_details.dart';
import 'package:http/http.dart' as http;

class EmployeeApi {
  final String baseUrl = 'http://192.168.1.48:5500/api/';

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

  Future<List<double>> fetchChartData(String employeeID) async {
    final response = await http.get(Uri.parse('${baseUrl}chart_data.json'));
    await Future.delayed(const Duration(seconds: 2));
    if (response.statusCode == 200) {
      var data = json.decode(response.body)[employeeID];
      List<double> hours = List<double>.from(
        data['hours'].map(
          (x) => x.toDouble(),
        ),
      );
      return hours;
    } else {
      throw Exception('Failed to load chart data');
    }
  }
}
