import 'package:flutter/material.dart';
import 'week_template.dart';

class Week9Page extends StatelessWidget {
  const Week9Page({super.key});

  @override
  Widget build(BuildContext context) {
    return WeekPageTemplate(
      weekNumber: 9,
      tip:
          "Your baby is growing fast! 🌱 Eyes, ears, and tiny muscles are forming. "
          "You might notice mood swings or fatigue — it’s completely normal. "
          "Eat iron-rich foods and try to maintain a consistent sleep routine 😴.",
      foods: const [
        {"icon": "🥬", "label": "Leafy Greens"},
        {"icon": "🍓", "label": "Fruits"},
        {"icon": "🥩", "label": "Iron Foods"},
        {"icon": "🥚", "label": "Protein"},
        {"icon": "💧", "label": "Hydration"},
      ],
      checklist: const [
        "Get 8 hours of sleep",
        "Eat iron and folate-rich foods",
        "Stay active with light walks",
        "Avoid heavy lifting",
        "Take prenatal vitamins daily",
      ],
    );
  }
}
