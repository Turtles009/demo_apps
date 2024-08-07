import 'package:flutter_bloc/flutter_bloc.dart';
import '../../api/employee_api.dart';
import 'chart_event.dart';
import 'chart_state.dart';

// bloc to handle chart data recieved from th API

class ChartBloc extends Bloc<ChartEvent, ChartState>{
  ChartBloc() : super(const ChartState.empty()) {
    on<FetchChart>((event, emit) async {
      emit(ChartState(
        isLoading: true,
        errorMessage: null,
        hours: null,
        week: null
      ),);

      try{
        final chartData = await EmployeeApi().fetchChartData(event.employeeId);
        // print(chartData['week']);
        emit(
          ChartState(
            isLoading: false,
            errorMessage: null,
            hours: chartData['hours'],
            week: chartData['week'],
          ),
        );
        
      }catch(e){
        emit(
          ChartState(
            isLoading: false,
            errorMessage: 'Failed to laod chart data',
            hours: null,
            week: null
          ),
        );
      }
    });
  }
}