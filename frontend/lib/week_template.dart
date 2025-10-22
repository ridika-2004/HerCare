import 'package:flutter/material.dart';

class WeekPageTemplate extends StatelessWidget {
  final int weekNumber;
  final String tip;
  final List<Map<String, String>> foods;
  final List<String> checklist;

  const WeekPageTemplate({
    super.key,
    required this.weekNumber,
    required this.tip,
    required this.foods,
    required this.checklist,
  });

  @override
  Widget build(BuildContext context) {
    double progress = weekNumber / 40;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFFFE6EC), Color(0xFFFFF9FB)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  "Pregnancy Journey 🤰",
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFFF7043),
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 6),
                const Text(
                  "Your body, your baby, your care 💕",
                  style: TextStyle(fontSize: 16, color: Colors.black54),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),

                // Progress Tracker
                _buildCard(
                  title: "Progress Tracker",
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 10,
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFE0B2),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: FractionallySizedBox(
                          alignment: Alignment.centerLeft,
                          widthFactor: progress,
                          child: Container(
                            decoration: BoxDecoration(
                              color: const Color(0xFFFF7043),
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text("Week $weekNumber of 40"),
                    ],
                  ),
                ),

                // Tip of the Week
                _buildCard(
                  title: "Tip of the Week 💡",
                  child: Text(
                    tip,
                    style: const TextStyle(height: 1.5),
                  ),
                ),

                const SizedBox(height: 10),

                // Daily Nutrition
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Daily Nutrition",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: foods
                        .map((food) =>
                            _FoodItem(icon: food['icon']!, label: food['label']!))
                        .toList(),
                  ),
                ),

                const SizedBox(height: 20),

                // Daily Checklist
                _buildCard(
                  title: "Daily Checklist ✅",
                  child: Column(
                    children: checklist.map((item) => _checkItem(item)).toList(),
                  ),
                ),

                const SizedBox(height: 20),

                // Contact Doctor
                Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFF7043),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {},
                    child: const Text(
                      "Contact Doctor",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Reusable card
  static Widget _buildCard({required String title, required Widget child}) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style:
                  const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          child,
        ],
      ),
    );
  }

  // Checklist item
  static Widget _checkItem(String label) {
    return Row(
      children: [
        Checkbox(value: false, onChanged: (_) {}),
        Expanded(child: Text(label)),
      ],
    );
  }
}

// Food item
class _FoodItem extends StatelessWidget {
  final String icon;
  final String label;
  const _FoodItem({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF0E6),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Text(icon, style: const TextStyle(fontSize: 24)),
          const SizedBox(height: 4),
          Text(label, style: const TextStyle(fontSize: 14)),
        ],
      ),
    );
  }
}
