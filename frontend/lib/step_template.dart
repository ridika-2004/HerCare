import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class StepTemplate extends StatefulWidget {
  final int stepNumber;
  final String title;
  final String description;
  final List<String> checklist;

  const StepTemplate({
    super.key,
    required this.stepNumber,
    required this.title,
    required this.description,
    required this.checklist,
  });

  @override
  State<StepTemplate> createState() => _StepTemplateState();
}

class _StepTemplateState extends State<StepTemplate> {
  late List<bool> _checkedItems;
  bool _stepCompleted = false;
  bool _isLoading = false;
  String? _userEmail; // 🔹 Loaded from SharedPreferences

  @override
  void initState() {
    super.initState();
    _checkedItems = List.generate(widget.checklist.length, (_) => false);
    _loadUserEmail();
  }

  // 🔹 Load user email from SharedPreferences
  Future<void> _loadUserEmail() async {
    final prefs = await SharedPreferences.getInstance();
    final email = prefs.getString('userEmail');

    setState(() => _userEmail = email);

    if (email != null) {
      _fetchProgress(email);
    }
  }

  // 🔹 Fetch saved checklist progress from Django
  Future<void> _fetchProgress(String email) async {
    setState(() => _isLoading = true);
    try {
      final url = Uri.parse('http://127.0.0.1:8000/breast/history/$email/');
      final res = await http.get(url);

      if (res.statusCode == 200) {
        final data = jsonDecode(res.body);
        if (data['status'] == 'success' && data['data'] is List) {
          final records = List<Map<String, dynamic>>.from(data['data']);
          final record = records.firstWhere(
                (r) => r['step_number'] == widget.stepNumber,
            orElse: () => {},
          );

          if (record.isNotEmpty) {
            final completed = List<String>.from(record['completed_items']);
            setState(() {
              _checkedItems = widget.checklist
                  .map((item) => completed.contains(item))
                  .toList();
              _stepCompleted = _checkedItems.every((item) => item);
            });
          }
        }
      }
    } catch (e) {
      debugPrint("⚠️ Error fetching progress: $e");
    }
    setState(() => _isLoading = false);
  }

  // 🔹 Save progress to Django (only if logged in)
  Future<void> _saveProgress() async {
    if (_userEmail == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please log in to save your progress."),
          backgroundColor: Colors.orangeAccent,
        ),
      );
      return;
    }

    try {
      final completedItems = <String>[];
      for (int i = 0; i < widget.checklist.length; i++) {
        if (_checkedItems[i]) completedItems.add(widget.checklist[i]);
      }

      final url = Uri.parse('http://127.0.0.1:8000/breast/record/');
      final res = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "email": _userEmail,
          "step_number": widget.stepNumber,
          "completed_items": completedItems,
        }),
      );

      if (res.statusCode == 200) {
        final msg = jsonDecode(res.body)['message'] ??
            "Progress saved successfully!";
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(msg), backgroundColor: Colors.green),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Failed to save progress (${res.statusCode})"),
            backgroundColor: Colors.redAccent,
          ),
        );
      }
    } catch (e) {
      debugPrint("⚠️ Save error: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Error saving progress"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _toggleCheck(int index) {
    setState(() {
      _checkedItems[index] = !_checkedItems[index];
      _stepCompleted = _checkedItems.every((item) => item);
    });
    _saveProgress(); // auto-save
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Colors.white, size: 20),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        title: const Text(
          "HerCare",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: Colors.white,
            letterSpacing: 0.5,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFFFF69B4),
        elevation: 0,
        toolbarHeight: 70,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator(color: Color(0xFFFF69B4)))
          : SingleChildScrollView(
        child: Column(
          children: [
            // Header
            Container(
              width: double.infinity,
              color: const Color(0xFFFF69B4),
              padding: const EdgeInsets.only(left: 16, right: 16, bottom: 20),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text("Tracker", style: TextStyle(color: Colors.white, fontSize: 15)),
                  Text("Awareness", style: TextStyle(color: Colors.white, fontSize: 15)),
                  Text("Doctors", style: TextStyle(color: Colors.white, fontSize: 15)),
                ],
              ),
            ),

            const SizedBox(height: 20),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Step badge
                  Container(
                    padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFFFF69B4), Color(0xFFFF8FAB)],
                      ),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFFFF69B4).withOpacity(0.3),
                          blurRadius: 8,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Text(
                      "Step ${widget.stepNumber}",
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Title and description
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.title,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF333333),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          widget.description,
                          style: TextStyle(
                            fontSize: 16,
                            height: 1.6,
                            color: Colors.grey.shade700,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  const Text(
                    "🩺 Steps",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF333333),
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Dynamic checklist
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      children: widget.checklist.asMap().entries.map((entry) {
                        final index = entry.key;
                        final item = entry.value;
                        return Container(
                          margin: EdgeInsets.only(
                              bottom: index < widget.checklist.length - 1 ? 12 : 0),
                          child: CheckboxListTile(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            tileColor: const Color(0xFFFFF5F9),
                            activeColor: const Color(0xFFFF69B4),
                            checkColor: Colors.white,
                            title: Text(
                              item,
                              style: TextStyle(
                                fontSize: 15,
                                height: 1.5,
                                color: Colors.grey.shade800,
                              ),
                            ),
                            value: _checkedItems[index],
                            onChanged: (_) => _toggleCheck(index),
                          ),
                        );
                      }).toList(),
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Button to mark completion
                  Center(
                    child: ElevatedButton.icon(
                      onPressed: _stepCompleted ? _saveProgress : null,
                      icon: const Icon(Icons.done_all),
                      label: const Text("Mark Step Complete"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _stepCompleted
                            ? const Color(0xFFFF69B4)
                            : Colors.grey.shade400,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 32, vertical: 14),
                        textStyle: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 32),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
