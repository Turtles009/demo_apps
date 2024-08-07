import 'package:demo_app/api/employee_api.dart';
import 'package:demo_app/bloc/employee_bloc/employee_event.dart';
import 'package:demo_app/bloc/employee_bloc/employee_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Bloc class to fetch employee details and emit state on change
class EmployeeBloc extends Bloc<EmployeeEvent, EmployeeState> {
  EmployeeBloc() : super(const EmployeeState.empty()) {
    on<FetchEmployeeEvent>((event, emit) async {
      emit(
        EmployeeState(
          isLoading: true,
          errorMessage: null,
          fetchedEmployees: null,
        ),
      );

      try {
        final employees = await EmployeeApi().fetchEmployees();
        emit(
          EmployeeState(
            isLoading: false,
            errorMessage: null,
            fetchedEmployees: employees,
          ),
        );
      } catch (e) {
        emit(
          EmployeeState(
            isLoading: false,
            errorMessage: 'Failed to load employees',
            fetchedEmployees: null,
          ),
        );
      }
    });
  }
}
