import 'package:flutter/material.dart';
import 'week_template.dart';

class Week10Page extends StatelessWidget {
  const Week10Page({super.key});

  @override
  Widget build(BuildContext context) {
    return WeekPageTemplate(
      weekNumber: 10,
      tip:
          "You’re now nearing the end of your first trimester 🌸. "
          "Your baby’s organs are fully formed and starting to function! "
          "Nausea may begin to ease soon — keep eating small, healthy meals and drink enough fluids 💧.",
      foods: const [
        {"icon": "🥦", "label": "Veggies"},
        {"icon": "🍎", "label": "Fruits"},
        {"icon": "🥛", "label": "Calcium"},
        {"icon": "🥚", "label": "Protein"},
        {"icon": "💧", "label": "Hydration"},
      ],
      checklist: const [
        "Eat small frequent meals",
        "Stay hydrated throughout the day",
        "Take prenatal vitamins daily",
        "Avoid caffeine and junk food",
        "Get 7–8 hours of sleep",
      ],
    );
  }
}
