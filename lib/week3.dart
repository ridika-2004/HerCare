import 'package:flutter/material.dart';
import 'week_template.dart';

class Week3Page extends StatelessWidget {
  const Week3Page({super.key});

  @override
  Widget build(BuildContext context) {
    return WeekPageTemplate(
      weekNumber: 3,
      tip:
          "Fertilization may have occurred! 🌷\n\n"
          "Your tiny zygote begins dividing rapidly as it travels down the fallopian tube. "
          "Eat omega-3 rich foods like fish or walnuts 🐟🥜 to support early cell growth.",
      foods: const [
        {"icon": "🥦", "label": "Veggies"},
        {"icon": "🍓", "label": "Fruits"},
        {"icon": "🥛", "label": "Dairy"},
        {"icon": "🐟", "label": "Omega-3"},
        {"icon": "💧", "label": "Hydration"},
      ],
      checklist: const [
        "Took prenatal vitamins",
        "Ate omega-3 rich foods",
        "Drank enough water",
        "Practiced light breathing exercise",
      ],
    );
  }
}
