import 'package:flutter/material.dart';
import 'month_template.dart';

class Month8Page extends StatelessWidget {
  const Month8Page({super.key});

  @override
  Widget build(BuildContext context) {
    return MonthPageTemplate(
      monthNumber: 8,
      tip:
      "Your baby is almost ready! 🌸 By the eighth month, your baby’s brain is rapidly developing, and layers of fat are forming under their skin. "
          "You may feel more discomfort due to your growing belly — shortness of breath, heartburn, or swelling are common. "
          "Focus on rest, light movement, and good nutrition to stay strong and prepare for delivery.",

      foods: const [
        {"icon": "🥑", "label": "Healthy fats"},
        {"icon": "🥦", "label": "Iron-rich greens"},
        {"icon": "🍗", "label": "Lean proteins"},
        {"icon": "🍎", "label": "Fruits for fiber"},
        {"icon": "💧", "label": "Stay hydrated"},
      ],

      checklist: const [
        "Rest frequently and avoid standing too long",
        "Do gentle breathing or relaxation exercises",
        "Eat small, light meals to ease digestion",
        "Finalize your birth plan and hospital choice",
        "Pack essentials for you and baby 🍼",
      ],

    );
  }
}

