enum EmployeeStatus { present, absent }

class EmployeeDetails {
  final String id;
  final String name;
  final String role;
  final String date;
  final String inTime;
  final String outTime;
  final EmployeeStatus status;
  final double workedHours;
  final double totalHours;

  const EmployeeDetails({
    required this.id,
    required this.name,
    required this.role,
    required this.date,
    required this.inTime,
    required this.outTime,
    required this.status,
    required this.workedHours,
    required this.totalHours,
  });

  factory EmployeeDetails.fromJson(Map<String, dynamic> json) {
    return EmployeeDetails(
      id: json['id'],
      name: json['name'],
      role: json['role'],
      date: json['date'],
      inTime: json['inTime'],
      outTime: json['outTime'],
      status: json['status'] == 'P'
          ? EmployeeStatus.present
          : EmployeeStatus.absent,
      workedHours: json['workedHours'].toDouble(),
      totalHours: json['totalHours'].toDouble(),
    );
  }
}
