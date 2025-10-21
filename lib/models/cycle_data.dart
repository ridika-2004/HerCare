import 'period_record.dart';

class CycleData {
  List<PeriodRecord> periodHistory;
  DateTime? predictedNextPeriod;
  int? predictedCycleLength;
  
  CycleData({
    this.periodHistory = const [],
    this.predictedNextPeriod,
    this.predictedCycleLength,
  });
  
  PeriodRecord? get lastPeriod {
    if (periodHistory.isEmpty) return null;
    return periodHistory.last;
  }
  
  // Only return last period date if we have actual data
  DateTime? get lastPeriodDate => lastPeriod?.startDate;
  
  int get cycleLength {
    if (predictedCycleLength != null) return predictedCycleLength!;
    if (periodHistory.length >= 2) return _calculateAverageCycleLength();
    return 28; // Default fallback, but won't be used for display until we have data
  }
  
  int get periodDuration {
    return lastPeriod?.periodDuration ?? 5; // Default fallback
  }
  
  DateTime get nextPeriodDate {
    if (predictedNextPeriod != null) return predictedNextPeriod!;
    if (lastPeriod != null && lastPeriodDate != null) {
      return lastPeriodDate!.add(Duration(days: cycleLength));
    }
    return DateTime.now().add(Duration(days: 28)); // Default fallback
  }
  
  DateTime get ovulationDate {
    if (lastPeriodDate != null) {
      return lastPeriodDate!.add(Duration(days: cycleLength ~/ 2));
    }
    return DateTime.now().add(Duration(days: 14)); // Default fallback
  }
  
  int get daysUntilNext {
    if (lastPeriodDate == null) return 28; // Default if no data
    final nextDate = nextPeriodDate;
    final difference = nextDate.difference(DateTime.now()).inDays;
    return difference >= 0 ? difference : 0; // Don't show negative days
  }
  
  int get daysSinceLast {
    if (lastPeriodDate == null) return 0; // Don't show fake "day X" if no data
    final difference = DateTime.now().difference(lastPeriodDate!).inDays;
    return difference >= 0 ? difference : 0; // Don't show negative days
  }
  
  int _calculateAverageCycleLength() {
    if (periodHistory.length < 2) return 28;
    
    int totalDays = 0;
    int count = 0;
    
    for (int i = 1; i < periodHistory.length; i++) {
      final previous = periodHistory[i - 1];
      final current = periodHistory[i];
      final daysBetween = current.startDate.difference(previous.startDate).inDays;
      
      // Only include reasonable cycle lengths (20-40 days)
      if (daysBetween >= 20 && daysBetween <= 40) {
        totalDays += daysBetween;
        count++;
      }
    }
    
    return count > 0 ? (totalDays / count).round() : 28;
  }
  
  void addPeriodRecord(DateTime startDate, DateTime endDate) {
    int periodDuration = endDate.difference(startDate).inDays + 1;
    int cycleLength = _calculateCycleLength(startDate);
    
    final newRecord = PeriodRecord(
      startDate: startDate,
      endDate: endDate,
      cycleLength: cycleLength,
      periodDuration: periodDuration,
    );
    
    periodHistory.add(newRecord);
    _updatePredictions();
  }
  
  int _calculateCycleLength(DateTime newStartDate) {
    if (periodHistory.isEmpty) return 28; // First period
    
    final lastStartDate = lastPeriod!.startDate;
    final daysBetween = newStartDate.difference(lastStartDate).inDays;
    
    // Return reasonable cycle length, default to 28 if unreasonable
    return (daysBetween >= 20 && daysBetween <= 40) ? daysBetween : 28;
  }
  
  void _updatePredictions() {
    if (periodHistory.length >= 2) {
      predictedCycleLength = _calculateAverageCycleLength();
      if (lastPeriodDate != null) {
        predictedNextPeriod = lastPeriodDate!.add(Duration(days: predictedCycleLength!));
      }
    } else {
      predictedCycleLength = null;
      predictedNextPeriod = null;
    }
  }
  
  // Helper method to check if we have enough data for predictions
  bool get hasEnoughDataForPredictions {
    return periodHistory.length >= 2;
  }
  
  // Helper method to check if we have any period data
  bool get hasPeriodData {
    return periodHistory.isNotEmpty;
  }
  
  // Get the most recent period record
  PeriodRecord? get mostRecentPeriod {
    if (periodHistory.isEmpty) return null;
    return periodHistory.last;
  }
  
  // Get all period records sorted by date (newest first)
  List<PeriodRecord> get sortedPeriodHistory {
    final sorted = List<PeriodRecord>.from(periodHistory);
    sorted.sort((a, b) => b.startDate.compareTo(a.startDate));
    return sorted;
  }
  
  // Get the average period duration
  double get averagePeriodDuration {
    if (periodHistory.isEmpty) return 5.0;
    
    int totalDuration = 0;
    for (final record in periodHistory) {
      totalDuration += record.periodDuration;
    }
    
    return totalDuration / periodHistory.length;
  }
  
  // Clear all history (for testing or reset)
  void clearHistory() {
    periodHistory.clear();
    predictedCycleLength = null;
    predictedNextPeriod = null;
  }
  
  Map<String, dynamic> toJson() {
    return {
      'periodHistory': periodHistory.map((record) => record.toJson()).toList(),
      'predictedNextPeriod': predictedNextPeriod?.toIso8601String(),
      'predictedCycleLength': predictedCycleLength,
    };
  }
  
  factory CycleData.fromJson(Map<String, dynamic> json) {
    List<PeriodRecord> history = [];
    if (json['periodHistory'] != null) {
      history = (json['periodHistory'] as List)
          .map((record) => PeriodRecord.fromJson(record))
          .toList();
    }
    
    return CycleData(
      periodHistory: history,
      predictedNextPeriod: json['predictedNextPeriod'] != null 
          ? DateTime.parse(json['predictedNextPeriod']) 
          : null,
      predictedCycleLength: json['predictedCycleLength'],
    );
  }
  
  @override
  String toString() {
    return 'CycleData('
        'periods: ${periodHistory.length}, '
        'lastPeriod: $lastPeriodDate, '
        'cycleLength: $cycleLength, '
        'nextPeriod: $nextPeriodDate'
        ')';
  }
  
  // Create a copy of the object
// In your CycleData class, add/update this method:
CycleData copyWith({
  List<PeriodRecord>? periodHistory,
  DateTime? predictedNextPeriod,
  int? predictedCycleLength,
  DateTime? lastPeriodDate, // ADD THIS LINE
  int? cycleLength,         // ADD THIS LINE
  int? periodDuration,      // ADD THIS LINE
}) {
  return CycleData(
    periodHistory: periodHistory ?? this.periodHistory,
    predictedNextPeriod: predictedNextPeriod ?? this.predictedNextPeriod,
    predictedCycleLength: predictedCycleLength ?? this.predictedCycleLength,
  );
}
}