import 'package:flutter/material.dart';
import 'month_template.dart';

class Month2Page extends StatelessWidget {
  const Month2Page({super.key});

  @override
  Widget build(BuildContext context) {
    return MonthPageTemplate(
      monthNumber: 2,
      tip:
      "By the second month, your baby’s tiny heart begins to beat 💓 and basic organs start forming. "
          "You may experience nausea, fatigue, or food aversions — all completely normal. "
          "Focus on gentle eating habits and rest whenever needed. "
          "Continue taking prenatal vitamins and avoid skipping meals, even if you feel queasy.",

      foods: const [
        {"icon": "🍌", "label": "Bananas for energy"},
        {"icon": "🍞", "label": "Whole grains"},
        {"icon": "🥕", "label": "Vitamin A veggies"},
        {"icon": "🥛", "label": "Calcium-rich milk"},
        {"icon": "💧", "label": "Hydration"},
      ],

      checklist: const [
        "Keep taking prenatal vitamins daily",
        "Eat light, frequent meals to ease nausea",
        "Avoid spicy or greasy foods if you feel sick",
        "Get plenty of rest and avoid overexertion",
        "Book your first ultrasound appointment",
      ],

    );
  }
}
