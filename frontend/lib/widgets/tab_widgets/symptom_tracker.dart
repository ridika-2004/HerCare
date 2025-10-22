import 'package:flutter/material.dart';
import '../../models/symptom_tracker.dart';
import '../../constants/app_constants.dart';

class SymptomTrackerWidget extends StatelessWidget {
  final SymptomTracker symptomTracker;
  final Function(SymptomTracker) onSymptomTrackerChanged;
  
  const SymptomTrackerWidget({
    super.key,
    required this.symptomTracker,
    required this.onSymptomTrackerChanged,
  });
  
  void _toggleSymptom(String symptom) {
    final newTracker = SymptomTracker();
    newTracker.selectedSymptoms.addAll(symptomTracker.selectedSymptoms);
    newTracker.toggleSymptom(symptom);
    onSymptomTrackerChanged(newTracker);
  }
  
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Log Your Symptoms',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppConstants.textColor,
          ),
        ),
        SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: AppConstants.symptoms
              .map(
                (symptom) => InkWell(
                  onTap: () => _toggleSymptom(symptom),
                  child: Container(
                    decoration: BoxDecoration(
                      color: symptomTracker.selectedSymptoms.contains(symptom)
                          ? AppConstants.primaryColor
                          : Colors.white,
                      border: Border.all(
                        color: AppConstants.primaryColor,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Text(
                      symptom,
                      style: TextStyle(
                        fontSize: 13,
                        color: symptomTracker.selectedSymptoms.contains(symptom)
                            ? Colors.white
                            : AppConstants.primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}