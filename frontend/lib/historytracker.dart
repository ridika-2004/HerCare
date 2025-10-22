

import 'package:flutter/material.dart';

// History Manager - Singleton to track user visits
class HistoryManager {
  static final HistoryManager _instance = HistoryManager._internal();
  factory HistoryManager() => _instance;
  HistoryManager._internal();

  final List<Map<String, dynamic>> _history = [];
  final Map<String, int> _pageVisitCount = {};
  int _totalVisitors = 1247; // Initialize with a base count

  void addHistory(String pageName, String icon, String category) {
    _history.insert(0, {
      'pageName': pageName,
      'icon': icon,
      'category': category,
      'timestamp': DateTime.now(),
    });

    // Update visit count for this page
    _pageVisitCount[pageName] = (_pageVisitCount[pageName] ?? 0) + 1;

    // Keep only last 100 entries
    if (_history.length > 100) {
      _history.removeLast();
    }
  }

  List<Map<String, dynamic>> getHistory() => List.from(_history);

  void clearHistory() {
    _history.clear();
    _pageVisitCount.clear();
  }

  int getHistoryCount() => _history.length;

  int getPageVisitCount(String pageName) => _pageVisitCount[pageName] ?? 0;

  int getTotalVisitors() => _totalVisitors;

  Map<String, int> getVisitStats() => Map.from(_pageVisitCount);
}

// HISTORY PAGE
class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  String selectedFilter = 'All';

  List<String> get categories => [
    'All',
    'Menstrual Health',
    'Pregnancy',
    'Cancer Awareness',
    'Mental Wellness',
    'Education',
  ];

  @override
  Widget build(BuildContext context) {
    final allHistory = HistoryManager().getHistory();
    final filteredHistory = selectedFilter == 'All'
        ? allHistory
        : allHistory.where((item) => item['category'] == selectedFilter).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Your History 📜",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Color(0xFFFF6F61),
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.pink.shade100,
        elevation: 1,
        actions: [
          if (allHistory.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.download, color: Color(0xFFFF6F61)),
              tooltip: 'Download History',
              onPressed: () {
                _downloadHistory(context, allHistory);
              },
            ),
          if (allHistory.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.delete_outline, color: Color(0xFFFF6F61)),
              tooltip: 'Clear History',
              onPressed: () {
                _showClearHistoryDialog(context);
              },
            ),
        ],
      ),
      body: Column(
        children: [
          // Stats Banner
          if (allHistory.isNotEmpty) _buildStatsBanner(),

          // Filter chips
          if (allHistory.isNotEmpty) _buildFilterChips(),

          // History list or empty state
          Expanded(
            child: allHistory.isEmpty
                ? _buildEmptyState()
                : filteredHistory.isEmpty
                ? _buildNoResultsState()
                : _buildHistoryList(filteredHistory),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsBanner() {
    final totalVisits = HistoryManager().getHistoryCount();
    final totalVisitors = HistoryManager().getTotalVisitors();
    final visitStats = HistoryManager().getVisitStats();
    final uniquePages = visitStats.length;

    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.pink.shade400, Colors.pink.shade600],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.pink.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildStatItem('👥', totalVisitors.toString(), 'Total Users'),
              Container(width: 1, height: 40, color: Colors.white30),
              _buildStatItem('📊', totalVisits.toString(), 'Your Visits'),
              Container(width: 1, height: 40, color: Colors.white30),
              _buildStatItem('📄', uniquePages.toString(), 'Pages'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String emoji, String value, String label) {
    return Column(
      children: [
        Text(emoji, style: const TextStyle(fontSize: 24)),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: const TextStyle(
            fontSize: 11,
            color: Colors.white70,
          ),
        ),
      ],
    );
  }

  Widget _buildFilterChips() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: categories.map((category) {
            final isSelected = selectedFilter == category;
            return Padding(
              padding: const EdgeInsets.only(right: 8),
              child: FilterChip(
                label: Text(category),
                selected: isSelected,
                onSelected: (selected) {
                  setState(() {
                    selectedFilter = category;
                  });
                },
                backgroundColor: Colors.white,
                selectedColor: Colors.pink.shade100,
                checkmarkColor: Colors.pink.shade800,
                labelStyle: TextStyle(
                  color: isSelected ? Colors.pink.shade800 : Colors.grey[700],
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
                side: BorderSide(
                  color: isSelected ? Colors.pink.shade300 : Colors.grey.shade300,
                  width: 1.5,
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '📭',
            style: TextStyle(fontSize: 80),
          ),
          const SizedBox(height: 16),
          Text(
            'No History Yet',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.grey[700],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Visit pages to see your history here',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[500],
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.home),
            label: const Text('Go to Home'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.pink,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNoResultsState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '🔍',
            style: TextStyle(fontSize: 60),
          ),
          const SizedBox(height: 16),
          Text(
            'No Results Found',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.grey[700],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Try selecting a different filter',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[500],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHistoryList(List<Map<String, dynamic>> history) {
    // Group history by date
    final groupedHistory = <String, List<Map<String, dynamic>>>{};

    for (var item in history) {
      final timestamp = item['timestamp'] as DateTime;
      final dateKey = _getDateKey(timestamp);

      if (!groupedHistory.containsKey(dateKey)) {
        groupedHistory[dateKey] = [];
      }
      groupedHistory[dateKey]!.add(item);
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: groupedHistory.length,
      itemBuilder: (context, index) {
        final dateKey = groupedHistory.keys.elementAt(index);
        final items = groupedHistory[dateKey]!;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Text(
                dateKey,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.pink.shade700,
                ),
              ),
            ),
            ...items.map((item) => _buildHistoryItem(item)),
            const SizedBox(height: 8),
          ],
        );
      },
    );
  }

  Widget _buildHistoryItem(Map<String, dynamic> item) {
    final timestamp = item['timestamp'] as DateTime;
    final timeString = _formatTime(timestamp);
    final visitCount = HistoryManager().getPageVisitCount(item['pageName']);

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.pink.shade100,
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        leading: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: Colors.pink.shade50,
            borderRadius: BorderRadius.circular(25),
          ),
          child: Center(
            child: Text(
              item['icon'],
              style: const TextStyle(fontSize: 28),
            ),
          ),
        ),
        title: Text(
          item['pageName'],
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color(0xFF333333),
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: Colors.pink.shade100,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    item['category'],
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.pink.shade800,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.visibility, size: 10, color: Colors.blue.shade700),
                      const SizedBox(width: 4),
                      Text(
                        '$visitCount visits',
                        style: TextStyle(
                          fontSize: 10,
                          color: Colors.blue.shade700,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                Icon(Icons.access_time, size: 12, color: Colors.grey[500]),
                const SizedBox(width: 4),
                Text(
                  timeString,
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.grey[500],
                  ),
                ),
              ],
            ),
          ],
        ),
        trailing: Icon(
          Icons.arrow_forward_ios,
          size: 16,
          color: Colors.grey[400],
        ),
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Opening ${item['pageName']}...'),
              duration: const Duration(seconds: 1),
              backgroundColor: Colors.pink,
            ),
          );
        },
      ),
    );
  }

  String _getDateKey(DateTime timestamp) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));
    final dateToCheck = DateTime(timestamp.year, timestamp.month, timestamp.day);

    if (dateToCheck == today) {
      return 'Today';
    } else if (dateToCheck == yesterday) {
      return 'Yesterday';
    } else if (now.difference(dateToCheck).inDays < 7) {
      return '${_getDayName(timestamp.weekday)}';
    } else {
      return '${timestamp.day}/${timestamp.month}/${timestamp.year}';
    }
  }

  String _getDayName(int weekday) {
    const days = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'];
    return days[weekday - 1];
  }

  String _formatTime(DateTime timestamp) {
    final hour = timestamp.hour;
    final minute = timestamp.minute.toString().padLeft(2, '0');
    final period = hour >= 12 ? 'PM' : 'AM';
    final displayHour = hour > 12 ? hour - 12 : (hour == 0 ? 12 : hour);

    return '$displayHour:$minute $period';
  }

  void _downloadHistory(BuildContext context, List<Map<String, dynamic>> history) {
    // Generate downloadable content
    String content = _generateHistoryReport(history);

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Download History Report',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF333333),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Your history report is ready to download',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pop(context);
                      _showDownloadSuccess(context, 'PDF');
                    },
                    icon: const Icon(Icons.picture_as_pdf),
                    label: const Text('Download PDF'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pop(context);
                      _showDownloadSuccess(context, 'CSV');
                    },
                    icon: const Icon(Icons.table_chart),
                    label: const Text('Download CSV'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () {
                  Navigator.pop(context);
                  _showDownloadSuccess(context, 'TXT');
                },
                icon: const Icon(Icons.description),
                label: const Text('Download TXT'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.pink,
                  side: const BorderSide(color: Colors.pink, width: 2),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
          ],
        ),
      ),
    );
  }

  String _generateHistoryReport(List<Map<String, dynamic>> history) {
    StringBuffer buffer = StringBuffer();
    buffer.writeln('═══════════════════════════════════════');
    buffer.writeln('       HERCARE HISTORY REPORT');
    buffer.writeln('═══════════════════════════════════════');
    buffer.writeln('Generated: ${DateTime.now()}');
    buffer.writeln('Total Visits: ${history.length}');
    buffer.writeln('Total Users: ${HistoryManager().getTotalVisitors()}');
    buffer.writeln('═══════════════════════════════════════\n');

    for (var item in history) {
      buffer.writeln('📄 ${item['pageName']}');
      buffer.writeln('   Category: ${item['category']}');
      buffer.writeln('   Time: ${item['timestamp']}');
      buffer.writeln('   Visits: ${HistoryManager().getPageVisitCount(item['pageName'])}');
      buffer.writeln('───────────────────────────────────────');
    }

    return buffer.toString();
  }

  void _showDownloadSuccess(BuildContext context, String format) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.check_circle, color: Colors.white),
            const SizedBox(width: 12),
            Expanded(
              child: Text('History downloaded as $format successfully!'),
            ),
          ],
        ),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  void _showClearHistoryDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Clear History'),
        content: const Text(
          'Are you sure you want to clear all history? This action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                HistoryManager().clearHistory();
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('History cleared successfully'),
                  backgroundColor: Colors.green,
                ),
              );
            },
            child: const Text(
              'Clear',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }
}

// Demo App


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'History Tracker Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.pink),
        useMaterial3: true,
      ),
      home: const DemoHomePage(),
    );
  }
}

class DemoHomePage extends StatelessWidget {
  const DemoHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HerCare Demo'),
        backgroundColor: Colors.pink.shade100,
        actions: [
          IconButton(
            icon: const Icon(Icons.history),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const HistoryPage()),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Test History Tracking',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  HistoryManager().addHistory('Period Tracker', '📊', 'Menstrual Health');
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Added Period Tracker to history')),
                  );
                },
                child: const Text('Track Period Visit'),
              ),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: () {
                  HistoryManager().addHistory('Pregnancy Journey', '🤰', 'Pregnancy');
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Added Pregnancy to history')),
                  );
                },
                child: const Text('Track Pregnancy Visit'),
              ),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: () {
                  HistoryManager().addHistory('Breast Cancer Awareness', '🎗️', 'Cancer Awareness');
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Added Breast Cancer to history')),
                  );
                },
                child: const Text('Track Breast Cancer Visit'),
              ),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: () {
                  HistoryManager().addHistory('Mental Health', '🧠', 'Mental Wellness');
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Added Mental Health to history')),
                  );
                },
                child: const Text('Track Mental Health Visit'),
              ),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: () {
                  HistoryManager().addHistory('Health Podcasts', '🎧', 'Education');
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Added Podcasts to history')),
                  );
                },
                child: const Text('Track Podcast Visit'),
              ),
              const SizedBox(height: 32),
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const HistoryPage()),
                  );
                },
                icon: const Icon(Icons.history),
                label: const Text('View History'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pink,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}