import 'package:flutter/material.dart';
import 'month_template.dart';

class Month5Page extends StatelessWidget {
  const Month5Page({super.key});

  @override
  Widget build(BuildContext context) {
    return MonthPageTemplate(
      monthNumber: 5,
      tip:
    "By the fifth month, your baby can now hear sounds and may respond to your voice 🩷. "
    "You might start feeling gentle movements — those first exciting flutters called 'quickening'. "
    "As your appetite increases, focus on healthy snacks and balanced meals to fuel both you and your growing baby.",

foods: const [
  {"icon": "🥑", "label": "Healthy fats (avocado)"},
  {"icon": "🍞", "label": "Whole grains"},
  {"icon": "🍓", "label": "Fresh berries"},
  {"icon": "🥚", "label": "Protein-rich eggs"},
  {"icon": "💧", "label": "Plenty of fluids"},
],

checklist: const [
  "Monitor your baby’s first movements",
  "Maintain a balanced diet with fiber",
  "Stay active with light exercises",
  "Use pillows for sleeping comfort",
  "Start thinking about baby names 💕",
],

    );
  }
}
