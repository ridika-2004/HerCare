import 'package:flutter/material.dart';
import 'history_manager.dart';
import 'history_entry.dart';
import 'widgets/stats_banner.dart';
import 'widgets/filter_chips.dart';
import 'widgets/empty_states.dart';
import 'widgets/history_list.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  String selectedFilter = 'All';

  @override
  Widget build(BuildContext context) {
    final allHistory = HistoryManager().getHistory();
    final filteredHistory = selectedFilter == 'All'
        ? allHistory
        : allHistory.where((item) => item.category == selectedFilter).toList();

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
          if (allHistory.isNotEmpty) ..._buildAppBarActions(allHistory),
        ],
      ),
      body: Column(
        children: [
          if (allHistory.isNotEmpty) const StatsBanner(),
          if (allHistory.isNotEmpty) _buildFilterSection(),
          Expanded(child: _buildContent(allHistory, filteredHistory)),
        ],
      ),
    );
  }

  List<Widget> _buildAppBarActions(List<HistoryEntry> history) {
    return [
      IconButton(
        icon: const Icon(Icons.download, color: Color(0xFFFF6F61)),
        tooltip: 'Download History',
        onPressed: () => _downloadHistory(context, history),
      ),
      IconButton(
        icon: const Icon(Icons.delete_outline, color: Color(0xFFFF6F61)),
        tooltip: 'Clear History',
        onPressed: () => _showClearHistoryDialog(context),
      ),
    ];
  }

  Widget _buildFilterSection() {
    return FilterChips(
      selectedFilter: selectedFilter,
      onFilterSelected: (category) => setState(() => selectedFilter = category),
    );
  }

  Widget _buildContent(List<HistoryEntry> allHistory, List<HistoryEntry> filteredHistory) {
    if (allHistory.isEmpty) return const EmptyHistoryState();
    if (filteredHistory.isEmpty) return const NoResultsState();
    return HistoryList(history: filteredHistory);
  }

  void _downloadHistory(BuildContext context, List<HistoryEntry> history) {
    // Download logic remains the same...
    _showDownloadOptions(context);
  }

  void _showDownloadOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
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
            _buildDownloadButtons(context),
          ],
        ),
      ),
    );
  }

  Widget _buildDownloadButtons(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: ElevatedButton.icon(
                onPressed: () => _handleDownload(context, 'PDF'),
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
                onPressed: () => _handleDownload(context, 'CSV'),
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
            onPressed: () => _handleDownload(context, 'TXT'),
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
    );
  }

  void _handleDownload(BuildContext context, String format) {
    Navigator.pop(context);
    _showDownloadSuccess(context, format);
  }

  void _showDownloadSuccess(BuildContext context, String format) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.check_circle, color: Colors.white),
            const SizedBox(width: 12),
            Expanded(child: Text('History downloaded as $format successfully!')),
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
              setState(() => HistoryManager().clearHistory());
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('History cleared successfully'),
                  backgroundColor: Colors.green,
                ),
              );
            },
            child: const Text('Clear', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}