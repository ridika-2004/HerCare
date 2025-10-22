import 'dart:convert';
import 'package:http/http.dart' as http;

class PregnancyService {
  static const String baseUrl = "http://127.0.0.1:8000"; // change for real device

  static Future<bool> saveProgress({
    required String email,
    required int month,
    required List<String> completedItems,
  }) async {
    final url = Uri.parse("$baseUrl/pregnancy/record-progress/");
    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "email": email,
        "month": month,
        "completed_items": completedItems,
      }),
    );

    return response.statusCode == 200;
  }

  static Future<List<dynamic>> getProgress(String email) async {
    final url = Uri.parse("$baseUrl/pregnancy/progress/$email/");
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return jsonDecode(response.body)["data"];
    } else {
      return [];
    }
  }
}
