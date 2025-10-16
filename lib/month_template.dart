import 'package:flutter/material.dart';

class MonthPageTemplate extends StatefulWidget {
  final int monthNumber;
  final String tip;
  final List<Map<String, String>> foods;
  final List<String> checklist;

  const MonthPageTemplate({
    super.key,
    required this.monthNumber,
    required this.tip,
    required this.foods,
    required this.checklist,
  });

  @override
  State<MonthPageTemplate> createState() => _MonthPageTemplateState();
}

class _MonthPageTemplateState extends State<MonthPageTemplate> {
  late List<bool> checkedItems;

  @override
  void initState() {
    super.initState();
    checkedItems = List.filled(widget.checklist.length, false);
  }

  @override
  Widget build(BuildContext context) {
    double progress = widget.monthNumber / 9;

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
                // Header
                const Text(
                  "Pregnancy Journey 🤰",
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFFF6F61),
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
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: LinearProgressIndicator(
                          value: progress,
                          color: const Color(0xFFFF6F61),
                          backgroundColor: const Color(0xFFFFE0E0),
                          minHeight: 10,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text("Month ${widget.monthNumber} of 9",
                          style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.black87)),
                    ],
                  ),
                ),

                // Tip of the Month
                _buildCard(
                  title: "Tip of the Month 💡",
                  child: Text(
                    widget.tip,
                    style: const TextStyle(height: 1.5),
                  ),
                ),

                const SizedBox(height: 10),

                // Daily Nutrition
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Daily Nutrition 🍽️",
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
                    children: widget.foods
                        .map((food) => _FoodItem(
                              icon: food['icon']!,
                              label: food['label']!,
                            ))
                        .toList(),
                  ),
                ),

                const SizedBox(height: 20),

                // Daily Checklist (Dynamic)
                _buildCard(
                  title: "Daily Checklist ✅",
                  child: Column(
                    children: List.generate(widget.checklist.length, (index) {
                      return CheckboxListTile(
                        value: checkedItems[index],
                        onChanged: (value) {
                          setState(() {
                            checkedItems[index] = value ?? false;
                          });
                        },
                        title: Text(widget.checklist[index]),
                        activeColor: const Color(0xFFFF6F61),
                        controlAffinity: ListTileControlAffinity.leading,
                      );
                    }),
                  ),
                ),

                const SizedBox(height: 20),

                // Contact Doctor
                Center(
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFF6F61),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 28, vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 3,
                    ),
                    onPressed: () {},
                    icon: const Icon(Icons.local_hospital, color: Colors.white),
                    label: const Text(
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

  // Reusable Card
  static Widget _buildCard({required String title, required Widget child}) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.pink.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
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
}

// Food Item Widget
class _FoodItem extends StatelessWidget {
  final String icon;
  final String label;
  const _FoodItem({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 18),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF0E6),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.pink.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(icon, style: const TextStyle(fontSize: 26)),
          const SizedBox(height: 6),
          Text(
            label,
            style: const TextStyle(fontSize: 14, color: Colors.black87),
          ),
        ],
      ),
    );
  }
}
