class PeriodRecord {
  final DateTime startDate;
  final DateTime endDate;
  final int cycleLength;
  final int periodDuration;
  
  PeriodRecord({
    required this.startDate,
    required this.endDate,
    required this.cycleLength,
    required this.periodDuration,
  });
  
  // For backend JSON
  factory PeriodRecord.fromJson(Map<String, dynamic> json) {
    return PeriodRecord(
      startDate: DateTime.parse(json['start_date']),
      endDate: DateTime.parse(json['end_date']),
      cycleLength: json['cycle_length'] ?? 28,
      periodDuration: json['period_duration'] ?? 5,
    );
  }
  
  // For local storage
  Map<String, dynamic> toJson() {
    return {
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
      'cycleLength': cycleLength,
      'periodDuration': periodDuration,
    };
  }
  
  // For backend API calls
  Map<String, dynamic> toApiJson() {
    return {
      'start_date': '${startDate.year}-${startDate.month.toString().padLeft(2, '0')}-${startDate.day.toString().padLeft(2, '0')}',
      'end_date': '${endDate.year}-${endDate.month.toString().padLeft(2, '0')}-${endDate.day.toString().padLeft(2, '0')}',
      'period_duration': periodDuration,
      'cycle_length': cycleLength,
    };
  }
}