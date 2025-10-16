import 'package:flutter/material.dart';
import 'month_template.dart';

class Month9Page extends StatelessWidget {
  const Month9Page({super.key});

  @override
  Widget build(BuildContext context) {
    return MonthPageTemplate(
      monthNumber: 9,
      tip:
    "You’ve reached the final month — congratulations, mama-to-be! 🎀 "
    "Your baby is now fully developed and gaining weight for birth. "
    "You might feel more pressure and frequent urination as the baby moves lower. "
    "Stay calm, get plenty of rest, and keep your hospital bag ready — your little one will be here any day now!",

foods: const [
  {"icon": "🍚", "label": "Energy-boosting grains"},
  {"icon": "🥩", "label": "Protein & iron foods"},
  {"icon": "🍌", "label": "Potassium-rich fruits"},
  {"icon": "🥗", "label": "Light salads"},
  {"icon": "💧", "label": "Hydration always"},
],

checklist: const [
  "Keep your hospital bag and documents ready",
  "Stay calm and practice breathing techniques",
  "Sleep on your left side for comfort",
  "Continue light walks if advised by your doctor",
  "Get emotional and practical support from loved ones 💕",
],

    );
  }
}
