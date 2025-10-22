import 'package:flutter/material.dart';
import 'week_template.dart';

class Week6Page extends StatelessWidget {
  const Week6Page({super.key});

  @override
  Widget build(BuildContext context) {
    return WeekPageTemplate(
      weekNumber: 6,
      tip:
          "Your baby’s heart is beating now! 💓 Tiny arms and legs are beginning to form. "
          "You might experience morning sickness — eat small, frequent meals and stay hydrated. 🍋",
      foods: const [
        {"icon": "🍌", "label": "Bananas"},
        {"icon": "🍞", "label": "Whole Grains"},
        {"icon": "🥦", "label": "Veggies"},
        {"icon": "🥛", "label": "Dairy"},
        {"icon": "💧", "label": "Hydration"},
      ],
      checklist: const [
        "Eat small, frequent meals",
        "Avoid skipping breakfast",
        "Rest when feeling nauseous",
        "Take prenatal vitamins daily",
        "Stay hydrated with water or fresh juice",
      ],
    );
  }
}
