class HistoryEntry {
  final String pageName;
  final String icon;
  final String category;
  final DateTime timestamp;

  HistoryEntry({
    required this.pageName,
    required this.icon,
    required this.category,
    required this.timestamp,
  });

  Map<String, dynamic> toMap() {
    return {
      'pageName': pageName,
      'icon': icon,
      'category': category,
      'timestamp': timestamp,
    };
  }

  static HistoryEntry fromMap(Map<String, dynamic> map) {
    return HistoryEntry(
      pageName: map['pageName'],
      icon: map['icon'],
      category: map['category'],
      timestamp: map['timestamp'],
    );
  }
}