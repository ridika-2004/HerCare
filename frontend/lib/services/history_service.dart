import 'dart:convert';
import 'package:http/http.dart' as http;

class HistoryService {
  static const String baseUrl = "http://127.0.0.1:8000"; // Django backend base URL

  static Future<Map<String, dynamic>> getUserHistory(String email) async {
    final url = Uri.parse("$baseUrl/user/history/$email/");

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception("Failed to fetch history (${response.statusCode})");
      }
    } catch (e) {
      throw Exception("Network error: $e");
    }
  }
}
