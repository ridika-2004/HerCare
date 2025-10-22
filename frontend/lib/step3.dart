import 'package:flutter/material.dart';
import 'step_template.dart';

class Step3Page extends StatelessWidget {
  const Step3Page({super.key});

  @override
  Widget build(BuildContext context) {
    return const StepTemplate(
      stepNumber: 3,
      title: "Feel While Lying Down 🛏️",
      description:
      "Lie down and use your right hand to feel your left breast and vice versa. "
          "Use a firm, smooth touch with the first few fingers, keeping them flat together. "
          "Cover the entire breast from top to bottom, side to side.",
      checklist: [
        "Use small circular motions",
        "Follow a consistent pattern",
        "Feel under the arm and collarbone",
      ],
    );
  }
}