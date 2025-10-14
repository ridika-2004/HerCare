import 'package:flutter/material.dart';
import 'week_template.dart';

class Week8Page extends StatelessWidget {
  const Week8Page({super.key});

  @override
  Widget build(BuildContext context) {
    return WeekPageTemplate(
      weekNumber: 8,
      tip:
          "Your baby is now about the size of a raspberry! 🍓 Tiny fingers and toes are forming, "
          "and your baby’s heartbeat can sometimes be seen on an early ultrasound 💓. "
          "Focus on balanced meals and rest well.",
      foods: const [
        {"icon": "🥦", "label": "Green Veggies"},
        {"icon": "🍳", "label": "Protein"},
        {"icon": "🍊", "label": "Vitamin C"},
        {"icon": "🥛", "label": "Calcium"},
        {"icon": "💧", "label": "Hydration"},
      ],
      checklist: const [
        "Schedule your first prenatal appointment",
        "Eat a protein-rich breakfast",
        "Drink plenty of water",
        "Avoid raw or undercooked foods",
        "Get light exercise daily",
      ],
    );
  }
}
