abstract class ChartEvent {
  const ChartEvent();
}

class FetchChart extends ChartEvent {
  final String employeeId;

  FetchChart({
    required this.employeeId,
  });
}
