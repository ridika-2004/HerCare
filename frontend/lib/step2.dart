import 'package:flutter/material.dart';
import 'step_template.dart';

class Step2Page extends StatelessWidget {
  const Step2Page({super.key});

  @override
  Widget build(BuildContext context) {
    return const StepTemplate(
      stepNumber: 2,
      title: "Raise Your Arms 🙆‍♀️",
      description:
      "Raise both arms and check for the same changes. "
          "Pay attention to how your breasts move and whether one seems different. "
          "Observe for fluid coming out of one or both nipples.",
      checklist: [
        "Lift both arms above head",
        "Check for nipple discharge",
        "Observe any movement differences",
      ],
    );
  }
}