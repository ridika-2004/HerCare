import 'package:flutter/material.dart';
import 'week_template.dart';

class Week1Page extends StatelessWidget {
  const Week1Page({super.key});

  @override
  Widget build(BuildContext context) {
    return WeekPageTemplate(
      weekNumber: 1,
      tip:
          "Even though you’re not technically pregnant yet, your body is preparing for ovulation 🌸. "
          "Eat balanced meals rich in iron and folate to support early development.",
      foods: const [
        {"icon": "🥦", "label": "Veggies"},
        {"icon": "🍎", "label": "Fruits"},
        {"icon": "🥛", "label": "Dairy"},
        {"icon": "🍗", "label": "Protein"},
        {"icon": "💧", "label": "Hydration"},
      ],
      checklist: const [
        "Eat a healthy breakfast",
        "Stay hydrated",
        "Track ovulation",
        "Get enough sleep",
      ],
    );
  }
}
