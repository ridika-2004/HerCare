import 'package:flutter/material.dart';
import '../services/pregnancy_service.dart';


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
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white, size: 24),
          onPressed: () {
            Navigator.of(context).pop();
          },
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Pink header section
            Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Color(0xFFFF69B4),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 16, right: 16, bottom: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      "Tracker",
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.9),
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      "Awareness",
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.9),
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      "Doctors",
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.9),
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Month Header Card
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFFFF69B4), Color(0xFFFF8FAB)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFFFF69B4).withOpacity(0.3),
                          blurRadius: 15,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Your Pregnancy Journey",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white70,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "Month ${widget.monthNumber} of 9",
                          style: const TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 16),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: LinearProgressIndicator(
                            value: progress,
                            color: Colors.white,
                            backgroundColor: Colors.white.withOpacity(0.3),
                            minHeight: 8,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "${(progress * 100).toInt()}% Complete",
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Tip of the Month
                  _buildCard(
                    title: "💡 Tip of the Month",
                    child: Text(
                      widget.tip,
                      style: TextStyle(
                        height: 1.6,
                        fontSize: 15,
                        color: Colors.grey.shade700,
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Daily Nutrition Section
                  const Text(
                    "Daily Nutrition",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF333333),
                    ),
                  ),
                  const SizedBox(height: 12),
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

                  const SizedBox(height: 24),

                  // Daily Checklist
                  _buildCard(
                    title: "✅ Daily Checklist",
                    child: Column(
                      children: List.generate(widget.checklist.length, (index) {
                        return Container(
                          margin: const EdgeInsets.only(bottom: 8),
                          decoration: BoxDecoration(
                            color: checkedItems[index]
                                ? const Color(0xFFFFE6F0)
                                : Colors.grey.shade50,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: CheckboxListTile(
                            value: checkedItems[index],
                            onChanged: (value) {
                              setState(() {
                                checkedItems[index] = value ?? false;
                              });
                            },
                            title: Text(
                              widget.checklist[index],
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.grey.shade800,
                                decoration: checkedItems[index]
                                    ? TextDecoration.lineThrough
                                    : null,
                              ),
                            ),

                            activeColor: const Color(0xFFFF69B4),
                            controlAffinity: ListTileControlAffinity.leading,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        );
                      }),

                    ),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      List<String> completed = [];
                      for (int i = 0; i < widget.checklist.length; i++) {
                        if (checkedItems[i]) completed.add(widget.checklist[i]);
                      }

                      bool ok = await PregnancyService.saveProgress(
                        email: "user@example.com", // TODO: Replace with real user
                        month: widget.monthNumber,
                        completedItems: completed,
                      );

                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(ok ? "Progress Saved ✅" : "Failed to Save ❌"))
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFF69B4),
                      minimumSize: const Size(double.infinity, 50),
                    ),
                    child: const Text("Save Progress", style: TextStyle(color: Colors.white)),
                  ),


                  const SizedBox(height: 24),

                  // Contact Doctor Button
                  Container(
                    width: double.infinity,
                    height: 56,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFFFF69B4), Color(0xFFFF8FAB)],
                      ),
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFFFF69B4).withOpacity(0.4),
                          blurRadius: 12,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      onPressed: () {},
                      icon: const Icon(Icons.local_hospital_rounded,
                          color: Colors.white, size: 24),
                      label: const Text(
                        "Contact Doctor",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
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

  // Reusable Card
  static Widget _buildCard({required String title, required Widget child}) {
    return Container(
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF333333),
            ),
          ),
          const SizedBox(height: 12),
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
    return Container(
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(icon, style: const TextStyle(fontSize: 32)),
          const SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade700,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}