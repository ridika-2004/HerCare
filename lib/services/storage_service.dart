import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/cycle_data.dart';
import '../models/period_record.dart';
import './api_service.dart';

class StorageService {
  static const String _cycleDataKey = 'cycle_data';
  static String? userEmail;

  // Load user email on app start
  static Future<void> loadUserEmail() async {
    final prefs = await SharedPreferences.getInstance();
    userEmail = prefs.getString('userEmail');
    print('📧 Loaded user email from storage: $userEmail');
  }

  // Load data from both local storage AND backend
  static Future<CycleData> loadCycleData() async {
    CycleData cycleData = CycleData();
    
    try {
      // First try to load from local storage
      cycleData = await _loadFromLocalStorage();
      
      // Then sync with backend if user is logged in
      if (userEmail != null && userEmail!.isNotEmpty) {
        try {
          final backendHistory = await ApiService.getPeriodHistory(userEmail!);
          
          if (backendHistory.isNotEmpty) {
            // Merge backend data with local data
            final mergedHistory = _mergePeriodHistories(
              cycleData.periodHistory, 
              backendHistory
            );
            
            cycleData = CycleData(
              periodHistory: mergedHistory,
              predictedNextPeriod: cycleData.predictedNextPeriod,
              predictedCycleLength: cycleData.predictedCycleLength,
            );
            
            // Update predictions
            if (cycleData.periodHistory.isNotEmpty) {
              // Use the public updatePredictions method on CycleData (removed leading underscore)
              cycleData.updatePredictions();
            }
            
            // Save merged data locally
            await _saveToLocalStorage(cycleData);
          }
        } catch (e) {
          print('⚠️ Failed to sync with backend: $e');
          // Continue with local data if backend fails
        }
      }
    } catch (e) {
      print('❌ Error loading cycle data: $e');
      cycleData = CycleData();
    }
    
    return cycleData;
  }

  // Save data to both local storage AND backend
  static Future<void> saveCycleData(CycleData cycleData) async {
    try {
      // Always save to local storage first
      await _saveToLocalStorage(cycleData);
      
      // Sync to backend if user is logged in and has new period
      if (userEmail != null && userEmail!.isNotEmpty && cycleData.lastPeriod != null) {
        try {
          final lastPeriod = cycleData.lastPeriod!;
          await ApiService.recordPeriod(
            email: userEmail!,
            startDate: lastPeriod.startDate,
            endDate: lastPeriod.endDate,
          );
          print('✅ Period synced to backend');
        } catch (e) {
          print('⚠️ Failed to sync period to backend: $e');
          // Queue for retry later or just continue
        }
      }
    } catch (e) {
      print('❌ Error saving cycle data: $e');
      throw e;
    }
  }

  // Local storage methods
  static Future<CycleData> _loadFromLocalStorage() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString(_cycleDataKey);
    
    if (data != null) {
      try {
        return CycleData.fromJson(json.decode(data));
      } catch (e) {
        print('Error parsing local cycle data: $e');
      }
    }
    
    return CycleData();
  }

  static Future<void> _saveToLocalStorage(CycleData cycleData) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_cycleDataKey, json.encode(cycleData.toJson()));
  }

  // Helper to merge period histories (avoid duplicates)
  static List<PeriodRecord> _mergePeriodHistories(
    List<PeriodRecord> localHistory, 
    List<PeriodRecord> backendHistory
  ) {
    final merged = List<PeriodRecord>.from(localHistory);
    
    for (final backendRecord in backendHistory) {
      final exists = merged.any((localRecord) => 
        localRecord.startDate == backendRecord.startDate &&
        localRecord.endDate == backendRecord.endDate
      );
      
      if (!exists) {
        merged.add(backendRecord);
      }
    }
    
    // Sort by start date (oldest first)
    merged.sort((a, b) => a.startDate.compareTo(b.startDate));
    
    return merged;
  }

  // Clear all data (for logout)
  static Future<void> clearData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_cycleDataKey);
    userEmail = null;
  }
}