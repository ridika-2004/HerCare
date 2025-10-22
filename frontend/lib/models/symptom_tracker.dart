class SymptomTracker {
  final Set<String> selectedSymptoms = {};
  
  void toggleSymptom(String symptom) {
    if (selectedSymptoms.contains(symptom)) {
      selectedSymptoms.remove(symptom);
    } else {
      selectedSymptoms.add(symptom);
    }
  }
  
  void clearSymptoms() {
    selectedSymptoms.clear();
  }
}