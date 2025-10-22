import 'package:flutter/material.dart';
import 'month_template.dart';

class Month7Page extends StatelessWidget {
  const Month7Page({super.key});

  @override
  Widget build(BuildContext context) {
    return MonthPageTemplate(
      monthNumber: 7,
      tip:
      "Welcome to the third trimester! 🍼 Your baby is growing fast and practicing breathing movements. "
          "You may experience backaches, leg cramps, or shortness of breath as your belly expands. "
          "Rest whenever possible, maintain good posture, and start preparing mentally and physically for labor.",

      foods: const [
        {"icon": "🥗", "label": "Leafy greens for iron"},
        {"icon": "🍊", "label": "Citrus for vitamin C"},
        {"icon": "🥛", "label": "Calcium-rich milk"},
        {"icon": "🍠", "label": "Energy foods"},
        {"icon": "💧", "label": "Hydration"},
      ],

      checklist: const [
        "Get enough sleep and rest frequently",
        "Practice light prenatal exercises",
        "Maintain good posture while sitting",
        "Attend your prenatal checkups regularly",
        "Start preparing your hospital bag 🧸",
      ],

    );
  }
}

