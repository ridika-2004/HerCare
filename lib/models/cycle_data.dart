class CycleData {
  DateTime lastPeriodDate;
  int cycleLength;
  int periodDuration;
  
  CycleData({
    required this.lastPeriodDate,
    this.cycleLength = 28,
    this.periodDuration = 5,
  });
  
  DateTime get nextPeriodDate => lastPeriodDate.add(Duration(days: cycleLength));
  DateTime get ovulationDate => lastPeriodDate.add(Duration(days: cycleLength ~/ 2));
  int get daysUntilNext => nextPeriodDate.difference(DateTime.now()).inDays;
  int get daysSinceLast => DateTime.now().difference(lastPeriodDate).inDays;
  
  CycleData copyWith({
    DateTime? lastPeriodDate,
    int? cycleLength,
    int? periodDuration,
  }) {
    return CycleData(
      lastPeriodDate: lastPeriodDate ?? this.lastPeriodDate,
      cycleLength: cycleLength ?? this.cycleLength,
      periodDuration: periodDuration ?? this.periodDuration,
    );
  }
}