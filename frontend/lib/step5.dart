import 'package:flutter/material.dart';
import 'step_template.dart';

class Step5Page extends StatelessWidget {
  const Step5Page({super.key});

  @override
  Widget build(BuildContext context) {
    return const StepTemplate(
      stepNumber: 5,
      title: "Note and Record Changes 📝",
      description:
      "If you notice lumps, thickening, discharge, or any unusual changes, "
          "make a note of them and consult your doctor. "
          "Regular self-exams help you learn what’s normal for you.",
      checklist: [
        "Write down observations",
        "Schedule a doctor visit if needed",
        "Repeat this check monthly",
      ],
    );
  }
}