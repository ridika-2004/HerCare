import 'package:flutter/material.dart';
import 'feature_card.dart';

class FeatureGrid extends StatelessWidget {
  final List<Map<String, dynamic>> landingFeatures;
  final Function(Map<String, dynamic>, BuildContext) onFeatureTap;

  const FeatureGrid({
    super.key,
    required this.landingFeatures,
    required this.onFeatureTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16.0,
          mainAxisSpacing: 16.0,
          childAspectRatio: 1.0,
        ),
        itemCount: landingFeatures.length,
        itemBuilder: (context, index) {
          final feature = landingFeatures[index];
          return FeatureCard(
            feature: feature,
            onTap: onFeatureTap,
          );
        },
      ),
    );
  }
}