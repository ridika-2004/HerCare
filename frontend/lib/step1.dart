import 'package:flutter/material.dart';
import 'step_template.dart';

class Step1Page extends StatelessWidget {
  const Step1Page({super.key});

  @override
  Widget build(BuildContext context) {
    return const StepTemplate(
      stepNumber: 1,
      title: "Look in the Mirror 🪞",
      description:
      "Stand straight in front of a mirror with your shoulders back and arms on your hips. "
          "Observe your breasts for changes in size, shape, or color. "
          "Look for visible distortions, dimpling, or skin puckering.",
      checklist: [
        "Stand in a well-lit room",
        "Compare both breasts",
        "Note skin texture changes",
        "Look for unusual discharge or swelling"
      ],
    );
  }
}