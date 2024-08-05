import '../../model/employee_details.dart';

class EmployeeState {
  final bool isLoading;
  final String? errorMessage;
  final List<EmployeeDetails>? fetchedEmployees;

  const EmployeeState.empty()
      : isLoading = false,
        errorMessage = null,
        fetchedEmployees = null;

  EmployeeState({
    required this.isLoading,
    required this.errorMessage,
    required this.fetchedEmployees,
  });

  @override
  toString() => {
        'isLoading': isLoading,
        'errorMessage': errorMessage,
        'fetchedEmployees': fetchedEmployees,
      }.toString();
}
