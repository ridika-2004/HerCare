class CalendarCalculator {
  static bool isPeriodDay(DateTime date, DateTime lastPeriodDate, int periodDuration) {
    return date.isAfter(lastPeriodDate) &&
        date.isBefore(lastPeriodDate.add(Duration(days: periodDuration)));
  }
  
  static bool isOvulationDay(DateTime date, DateTime ovulationDate) {
    return date.difference(ovulationDate.subtract(Duration(days: 1))).inDays >= 0 &&
        date.difference(ovulationDate.add(Duration(days: 1))).inDays <= 0;
  }
  
  static bool isFertileWindow(DateTime date, DateTime nextPeriodDate) {
    return date.isAfter(nextPeriodDate.subtract(Duration(days: 5))) &&
        date.isBefore(nextPeriodDate.add(Duration(days: 1)));
  }
}