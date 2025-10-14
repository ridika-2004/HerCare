import 'package:flutter/material.dart';
import 'step_template.dart';

class Step4Page extends StatelessWidget {
  const Step4Page({super.key});

  @override
  Widget build(BuildContext context) {
    return const StepTemplate(
      stepNumber: 4,
      title: "Feel While Standing or Sitting 🚿",
      description:
          "Many women find it easier to feel their breasts when their skin is wet and slippery, "
          "so this can be done in the shower. "
          "Move your fingers around the entire breast in circular motions.",
      checklist: [
        "Use soap or lotion for smoother motion",
        "Cover all breast areas",
        "Apply light, medium, and firm pressure",
      ],
    );
  }
}
