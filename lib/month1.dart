import 'package:flutter/material.dart';
import 'month_template.dart';

class Month1Page extends StatelessWidget {
  const Month1Page({super.key});

  @override
  Widget build(BuildContext context) {
    return MonthPageTemplate(
      monthNumber: 1,
      tip:
    "During the first month of pregnancy, implantation occurs and your baby begins forming from a tiny cluster of cells 🍼. "
    "You may start feeling mild fatigue, breast tenderness, or mood swings. "
    "Take prenatal vitamins daily — especially folic acid — and avoid caffeine, alcohol, and smoking. "
    "Gentle rest, hydration, and balanced nutrition are key in supporting your baby’s earliest growth.",

foods: const [
  {"icon": "🥦", "label": "Leafy Greens"},
  {"icon": "🍊", "label": "Vitamin C Fruits"},
  {"icon": "🥚", "label": "Protein & Iron"},
  {"icon": "🥛", "label": "Calcium Foods"},
  {"icon": "💧", "label": "Plenty of Water"},
],

checklist: const [
  "Start taking prenatal vitamins with folic acid",
  "Eat small, balanced meals throughout the day",
  "Avoid alcohol, smoking, and raw foods",
  "Schedule your first prenatal appointment",
  "Get plenty of rest and manage stress gently",
],

    );
  }
}
