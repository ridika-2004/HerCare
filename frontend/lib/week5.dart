import 'package:flutter/material.dart';
import 'week_template.dart';

class Week5Page extends StatelessWidget {
  const Week5Page({super.key});

  @override
  Widget build(BuildContext context) {
    return WeekPageTemplate(
      weekNumber: 5,
      tip:
          "Your baby’s heart and brain are beginning to form 💓🧠. "
          "You might start to feel a bit more tired — that’s normal! "
          "Focus on balanced nutrition and gentle self-care.",
      foods: const [
        {"icon": "🥬", "label": "Leafy Greens"},
        {"icon": "🍓", "label": "Fruits"},
        {"icon": "🥛", "label": "Calcium"},
        {"icon": "🥩", "label": "Protein"},
        {"icon": "💧", "label": "Hydration"},
      ],
      checklist: const [
        "Take prenatal vitamins daily",
        "Avoid undercooked foods",
        "Eat iron-rich meals",
        "Rest when tired",
        "Stay hydrated throughout the day",
      ],
    );
  }
}
