import 'package:flutter/material.dart';
import 'week_template.dart';

class Week7Page extends StatelessWidget {
  const Week7Page({super.key});

  @override
  Widget build(BuildContext context) {
    return WeekPageTemplate(
      weekNumber: 7,
      tip:
          "Your baby’s facial features are starting to form 🍼. "
          "You may notice stronger pregnancy symptoms now — nausea, tiredness, and breast tenderness. "
          "Stick to light meals and avoid strong odors if they bother you.",
      foods: const [
        {"icon": "🥗", "label": "Light Meals"},
        {"icon": "🍊", "label": "Vitamin C"},
        {"icon": "🥛", "label": "Calcium"},
        {"icon": "🍗", "label": "Protein"},
        {"icon": "💧", "label": "Hydration"},
      ],
      checklist: const [
        "Eat small healthy snacks",
        "Rest and nap often",
        "Stay away from strong odors",
        "Continue taking vitamins",
        "Drink water regularly",
      ],
    );
  }
}
