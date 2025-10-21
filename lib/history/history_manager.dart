import 'history_entry.dart';

class HistoryManager {
  static final HistoryManager _instance = HistoryManager._internal();
  factory HistoryManager() => _instance;
  HistoryManager._internal();

  final List<HistoryEntry> _history = [];
  final Map<String, int> _pageVisitCount = {};
  static const int _maxHistoryEntries = 100;
  static const int _totalVisitors = 1247;

  void addHistory(String pageName, String icon, String category) {
    final entry = HistoryEntry(
      pageName: pageName,
      icon: icon,
      category: category,
      timestamp: DateTime.now(),
    );

    _history.insert(0, entry);
    _pageVisitCount[pageName] = (_pageVisitCount[pageName] ?? 0) + 1;

    if (_history.length > _maxHistoryEntries) {
      _history.removeLast();
    }
  }

  List<HistoryEntry> getHistory() => List.from(_history);

  void clearHistory() {
    _history.clear();
    _pageVisitCount.clear();
  }

  int getHistoryCount() => _history.length;

  int getPageVisitCount(String pageName) => _pageVisitCount[pageName] ?? 0;

  int getTotalVisitors() => _totalVisitors;

  Map<String, int> getVisitStats() => Map.from(_pageVisitCount);
}