import 'package:flutter/material.dart';
import 'week_template.dart';

class Week2Page extends StatelessWidget {
  const Week2Page({super.key});

  @override
  Widget build(BuildContext context) {
    return WeekPageTemplate(
      weekNumber: 2,
      tip:
          "Ovulation is approaching 🩷. Maintain a nutrient-rich diet and avoid stress. "
          "Iron and folate intake continue to be important as your body prepares for conception.",
      foods: const [
        {"icon": "🥬", "label": "Leafy Greens"},
        {"icon": "🍓", "label": "Fruits"},
        {"icon": "🥚", "label": "Protein"},
        {"icon": "🥛", "label": "Dairy"},
        {"icon": "💧", "label": "Hydration"},
      ],
      checklist: const [
        "Eat iron-rich foods",
        "Avoid excessive caffeine",
        "Track fertility window",
        "Stay active and relaxed",
      ],
    );
  }
}