class ChartState {
  final bool isLoading;
  final String? errorMessage;
  final List<double>? hours;

  ChartState({
    required this.isLoading,
    required this.errorMessage,
    required this.hours,
  });

  const ChartState.empty()
      : isLoading = false,
        errorMessage = null,
        hours = null;

  @override
  toString() => {
        'isLoading': isLoading,
        'errorMessage': errorMessage,
        'hours': hours,
      }.toString();
}
