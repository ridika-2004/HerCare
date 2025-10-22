import 'package:flutter/material.dart';
import 'month_template.dart';

class Month6Page extends StatelessWidget {
  const Month6Page({super.key});

  @override
  Widget build(BuildContext context) {
    return MonthPageTemplate(
      monthNumber: 6,
      tip:
      "By the sixth month, your baby’s senses are developing — they can now respond to light and sound 🌙. "
          "You might feel stronger kicks and notice your belly growing more quickly. "
          "This is a good time to focus on posture, hydration, and rest. "
          "Keep eating foods rich in iron and protein to support rapid growth and prevent fatigue.",

      foods: const [
        {"icon": "🥩", "label": "Iron-rich meats"},
        {"icon": "🥦", "label": "Green vegetables"},
        {"icon": "🍌", "label": "Potassium-rich fruits"},
        {"icon": "🥜", "label": "Healthy nuts"},
        {"icon": "💧", "label": "Plenty of water"},
      ],

      checklist: const [
        "Track your baby’s movement patterns",
        "Eat iron and protein-rich foods",
        "Do light stretches or prenatal yoga",
        "Stay hydrated throughout the day",
        "Discuss birth plans with your doctor",
      ],

    );
  }
}
