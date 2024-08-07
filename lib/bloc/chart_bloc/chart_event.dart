abstract class ChartEvent {
  const ChartEvent();
}

// Event class to trigger an action of fetching chart data from API
class FetchChart extends ChartEvent {
  final String employeeId;

  FetchChart({
    required this.employeeId,
  });
}
