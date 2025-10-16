import 'package:flutter/material.dart';
import 'month_template.dart';

class Month3Page extends StatelessWidget {
  const Month3Page({super.key});

  @override
  Widget build(BuildContext context) {
    return MonthPageTemplate(
      monthNumber: 3,
      tip:
      "Your baby is now about the size of a plum 🍑 — tiny fingers, toes, and facial features are forming! "
          "Morning sickness may begin to ease, but mood swings or tiredness can still occur. "
          "Keep nourishing your body with balanced meals, and start light exercises like walking or prenatal yoga if approved by your doctor.",

      foods: const [
        {"icon": "🍓", "label": "Vitamin C fruits"},
        {"icon": "🥩", "label": "Iron-rich meats"},
        {"icon": "🥦", "label": "Folate-rich greens"},
        {"icon": "🍚", "label": "Whole grains"},
        {"icon": "🥛", "label": "Low-fat dairy"},
      ],

      checklist: const [
        "Continue prenatal vitamins and healthy meals",
        "Include iron and folate in your diet",
        "Begin light pregnancy-safe exercises",
        "Discuss any symptoms with your doctor",
        "Start keeping a pregnancy journal 💗",
      ],

    );
  }
}
