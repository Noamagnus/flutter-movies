import 'package:flutter_movies_app/constants.dart';

String getApiKey() {
  return const String.fromEnvironment(apiKey);
}

String createRuntimeDisplayValue(int? totalMinutes) {
  if (totalMinutes == null) return 'Unknown';
  int hours = totalMinutes ~/ 60; // Get the number of full hours
  int minutes = totalMinutes % 60; // Get the remaining minutes
  return '${hours}h ${minutes}m';
}

String getYearFromDate(String dateString) {
  DateTime dateTime = DateTime.parse(dateString);
  int year = dateTime.year;
  return year.toString();
}
