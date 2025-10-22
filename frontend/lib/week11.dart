import 'package:flutter/material.dart';
import 'week_template.dart';

class Week11Page extends StatelessWidget {
  const Week11Page({super.key});

  @override
  Widget build(BuildContext context) {
    return WeekPageTemplate(
      weekNumber: 11,
      tip:
          "Your baby is now moving slightly inside you, though you may not feel it yet 🤰. "
          "Bones are starting to harden, and hair follicles are forming! "
          "Make sure to keep your meals rich in calcium and protein 🥛🥩.",
      foods: const [
        {"icon": "🥬", "label": "Leafy Greens"},
        {"icon": "🍌", "label": "Potassium"},
        {"icon": "🥛", "label": "Calcium"},
        {"icon": "🍗", "label": "Protein"},
        {"icon": "💧", "label": "Hydration"},
      ],
      checklist: const [
        "Eat calcium-rich foods daily",
        "Take short naps if tired",
        "Continue light exercises",
        "Stay hydrated with water or juice",
        "Avoid skipping meals",
      ],
    );
  }
}
