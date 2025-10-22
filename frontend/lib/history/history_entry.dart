class HistoryEntry {
  final String id;
  final String category;
  final DateTime timestamp;
  final Map<String, dynamic> data;

  HistoryEntry({
    required this.id,
    required this.category,
    required this.timestamp,
    required this.data,
  });

  factory HistoryEntry.fromMap(Map<String, dynamic> map) {
    return HistoryEntry(
      id: map['_id'] ?? DateTime.now().microsecondsSinceEpoch.toString(),
      category: map['category'] ?? 'General',
      timestamp: DateTime.parse(map['timestamp'] ?? DateTime.now().toIso8601String()),
      data: map,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'category': category,
      'timestamp': timestamp.toIso8601String(),
      ...data,
    };
  }
}
