import 'package:flutter_bloc/flutter_bloc.dart';
import '../../api/employee_api.dart';
import 'chart_event.dart';
import 'chart_state.dart';

class ChartBloc extends Bloc<ChartEvent, ChartState>{
  ChartBloc() : super(const ChartState.empty()) {
    on<FetchChart>((event, emit) async {
      emit(ChartState(
        isLoading: true,
        errorMessage: null,
        hours: null,
      ),);

      try{
        final chartData = await EmployeeApi().fetchChartData(event.employeeId);
        print(chartData);
        emit(
          ChartState(
            isLoading: false,
            errorMessage: null,
            hours: chartData,
          ),
        );
        
      }catch(e){
        emit(
          ChartState(
            isLoading: false,
            errorMessage: 'Failed to laod chart data',
            hours: null,
          ),
        );
      }
    });
  }
}