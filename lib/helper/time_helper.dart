extension TimeHelper on double {
  String convertToHoursAndMinutes() {
    int hours = floor();
    int minutes = ((this - hours) * 60).round();

    return '$hours h $minutes m';
  }
}
