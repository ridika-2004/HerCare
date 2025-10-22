import 'history_entry.dart';

class HistoryManager {
  static final HistoryManager _instance = HistoryManager._internal();
  factory HistoryManager() => _instance;
  HistoryManager._internal();

  final List<HistoryEntry> _history = [];
  final Map<String, int> _categoryVisitCount = {};
  static const int _maxHistoryEntries = 100;
  static const int _totalVisitors = 1247;

  void addHistory(String category, Map<String, dynamic> data, {String? id}) {
    final entry = HistoryEntry(
      id: id ?? DateTime.now().microsecondsSinceEpoch.toString(),
      category: category,
      timestamp: DateTime.now(),
      data: data,
    );

    _history.insert(0, entry);
    _categoryVisitCount[category] = (_categoryVisitCount[category] ?? 0) + 1;

    if (_history.length > _maxHistoryEntries) {
      _history.removeLast();
    }
  }

  List<HistoryEntry> getHistory() => List.from(_history);

  void clearHistory() {
    _history.clear();
    _categoryVisitCount.clear();
  }

  int getHistoryCount() => _history.length;

  int getPageVisitCount(String category) => _categoryVisitCount[category] ?? 0;

  int getTotalVisitors() => _totalVisitors;

  Map<String, int> getVisitStats() => Map.from(_categoryVisitCount);
}