import 'package:flutter/material.dart';
import 'week_template.dart';

class Week4Page extends StatelessWidget {
  const Week4Page({super.key});

  @override
  Widget build(BuildContext context) {
    return WeekPageTemplate(
      weekNumber: 4,
      tip:
          "Congratulations! 🌟 The fertilized egg has implanted into your uterus. "
          "You are officially pregnant now! Your body starts producing hormones to support the pregnancy. "
          "Eat folate-rich foods and stay well hydrated 💧.",
      foods: const [
        {"icon": "🥦", "label": "Veggies"},
        {"icon": "🍊", "label": "Citrus"},
        {"icon": "🥚", "label": "Protein"},
        {"icon": "🍞", "label": "Whole Grains"},
        {"icon": "💧", "label": "Hydration"},
      ],
      checklist: const [
        "Take prenatal vitamins",
        "Drink 8 glasses of water",
        "Eat folate-rich foods",
        "Avoid alcohol and smoking",
        "Rest well and reduce stress",
      ],
    );
  }
}
