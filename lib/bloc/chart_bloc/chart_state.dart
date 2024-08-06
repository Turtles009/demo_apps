class ChartState {
  final bool isLoading;
  final String? errorMessage;
  final List<double>? hours;
  final List<double>? week;

  ChartState({
    required this.isLoading,
    required this.errorMessage,
    required this.hours,
    required this.week,
  });

  const ChartState.empty()
      : isLoading = false,
        errorMessage = null,
        hours = null,
        week = null;

  @override
  toString() => {
        'isLoading': isLoading,
        'errorMessage': errorMessage,
        'hours': hours,
        'week': week,
      }.toString();
}
