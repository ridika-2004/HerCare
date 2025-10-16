import 'package:flutter/material.dart';
import 'month_template.dart';

class Month4Page extends StatelessWidget {
  const Month4Page({super.key});

  @override
  Widget build(BuildContext context) {
    return MonthPageTemplate(
      monthNumber: 4,
      tip:
    "Welcome to the second trimester! 🌞 By the fourth month, your baby’s heartbeat is stronger and you may start showing a small bump. "
    "Many moms notice increased energy and reduced nausea around this time. "
    "Focus on nutrient-rich meals with plenty of iron and calcium to support your baby’s growing bones and blood supply.",

foods: const [
  {"icon": "🥬", "label": "Spinach & greens"},
  {"icon": "🍗", "label": "Lean protein"},
  {"icon": "🥭", "label": "Fruits for vitamins"},
  {"icon": "🥛", "label": "Calcium-rich milk"},
  {"icon": "💧", "label": "Hydrate often"},
],

checklist: const [
  "Attend your prenatal checkup for the second trimester",
  "Start wearing comfortable maternity clothes",
  "Eat foods high in iron and calcium",
  "Sleep on your side for better circulation",
  "Take short walks or light stretches daily",
],

    );
  }
}
