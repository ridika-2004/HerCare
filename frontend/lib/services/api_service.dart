import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/period_record.dart';

class ApiService {
  static const String baseUrl = 'http://127.0.0.1:8000'; // Use 10.0.2.2 for Android emulator
  
  static Future<Map<String, dynamic>> recordPeriod({
    required String email,
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/period/record/'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'email': email,
          'start_date': _formatDate(startDate),
          'end_date': _formatDate(endDate),
        }),
      );
      
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to record period: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }
  
  static Future<List<PeriodRecord>> getPeriodHistory(String email) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/period/history/$email/'),
      );
      
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['status'] == 'success') {
          return (data['data'] as List)
              .map((record) => PeriodRecord.fromJson(record))
              .toList();
        } else {
          throw Exception(data['message']);
        }
      } else {
        throw Exception('Failed to fetch history: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }
  
  static String _formatDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }
}