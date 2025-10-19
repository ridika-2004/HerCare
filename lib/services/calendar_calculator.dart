class CalendarCalculator {
  static bool isPeriodDay(DateTime date, DateTime lastPeriodDate, int periodDuration) {
    // Normalize dates to remove time component for accurate comparison
    final normalizedDate = DateTime(date.year, date.month, date.day);
    final normalizedLastPeriod = DateTime(lastPeriodDate.year, lastPeriodDate.month, lastPeriodDate.day);
    
    // Calculate the end date of the period
    final periodEndDate = normalizedLastPeriod.add(Duration(days: periodDuration - 1));
    
    // Check if date is within the period range (inclusive)
    final isWithinPeriod = (normalizedDate.isAfter(normalizedLastPeriod.subtract(Duration(days: 1))) &&
            normalizedDate.isBefore(periodEndDate.add(Duration(days: 1))));
    
    // Debug print
    if (isWithinPeriod) {
      print('🩸 PERIOD DAY: $normalizedDate (Period: $normalizedLastPeriod to $periodEndDate)');
    }
    
    return isWithinPeriod;
  }
  
  static bool isOvulationDay(DateTime date, DateTime ovulationDate) {
    // Normalize dates
    final normalizedDate = DateTime(date.year, date.month, date.day);
    final normalizedOvulation = DateTime(ovulationDate.year, ovulationDate.month, ovulationDate.day);
    
    // 3-day ovulation window (day before, day of, day after)
    final ovulationStart = normalizedOvulation.subtract(Duration(days: 1));
    final ovulationEnd = normalizedOvulation.add(Duration(days: 1));
    
    final isOvulation = (normalizedDate.isAfter(ovulationStart.subtract(Duration(days: 1))) &&
            normalizedDate.isBefore(ovulationEnd.add(Duration(days: 1))));
    
    // Debug print
    if (isOvulation) {
      print('🥚 OVULATION DAY: $normalizedDate (Window: $ovulationStart to $ovulationEnd)');
    }
    
    return isOvulation;
  }
  
  static bool isFertileWindow(DateTime date, DateTime nextPeriodDate) {
    // Normalize dates
    final normalizedDate = DateTime(date.year, date.month, date.day);
    final normalizedNextPeriod = DateTime(nextPeriodDate.year, nextPeriodDate.month, nextPeriodDate.day);
    
    // Fertile window: 6 days ending on ovulation day
    final ovulationDate = normalizedNextPeriod.subtract(Duration(days: 14));
    final fertileStart = ovulationDate.subtract(Duration(days: 5)); // 6-day window
    final fertileEnd = ovulationDate;
    
    final isFertile = (normalizedDate.isAfter(fertileStart.subtract(Duration(days: 1))) &&
            normalizedDate.isBefore(fertileEnd.add(Duration(days: 1))));
    
    // Debug print
    if (isFertile) {
      print('💖 FERTILE DAY: $normalizedDate (Window: $fertileStart to $fertileEnd)');
    }
    
    return isFertile;
  }
  
  // Helper to get all ovulation dates in a range for debugging
  static List<DateTime> getOvulationDaysInRange(DateTime startDate, DateTime endDate, DateTime ovulationDate) {
    List<DateTime> ovulationDays = [];
    DateTime current = startDate;
    
    while (current.isBefore(endDate) || current.isAtSameMomentAs(endDate)) {
      if (isOvulationDay(current, ovulationDate)) {
        ovulationDays.add(current);
      }
      current = current.add(Duration(days: 1));
    }
    
    print('🥚 OVULATION DAYS IN RANGE: $ovulationDays');
    return ovulationDays;
  }
}