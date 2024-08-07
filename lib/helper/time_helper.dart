// An extension to convert a double value to string format. Ex., '9 h 42 m'
extension TimeHelper on double {
  String convertToHoursAndMinutes() {
    int hours = floor();
    int minutes = ((this - hours) * 60).round();

    return '$hours h $minutes m';
  }
}
