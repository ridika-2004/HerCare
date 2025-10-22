import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/cycle_data.dart';

class StorageService {
  static const String _cycleDataKey = 'cycle_data';
  
  static Future<void> saveCycleData(CycleData cycleData) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_cycleDataKey, json.encode(cycleData.toJson()));
  }
  
  static Future<CycleData> loadCycleData() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString(_cycleDataKey);
    
    if (data != null) {
      try {
        return CycleData.fromJson(json.decode(data));
      } catch (e) {
        print('Error loading cycle data: $e');
      }
    }
    
    return CycleData(); // Return empty data if none exists
  }
}