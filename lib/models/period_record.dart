class PeriodRecord {
  final DateTime startDate;
  final DateTime endDate;
  final int cycleLength; // Calculated from previous record
  final int periodDuration; // Calculated from start and end date
  
  PeriodRecord({
    required this.startDate,
    required this.endDate,
    required this.cycleLength,
    required this.periodDuration,
  });
  
  Map<String, dynamic> toJson() {
    return {
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
      'cycleLength': cycleLength,
      'periodDuration': periodDuration,
    };
  }
  
  factory PeriodRecord.fromJson(Map<String, dynamic> json) {
    return PeriodRecord(
      startDate: DateTime.parse(json['startDate']),
      endDate: DateTime.parse(json['endDate']),
      cycleLength: json['cycleLength'],
      periodDuration: json['periodDuration'],
    );
  }
}