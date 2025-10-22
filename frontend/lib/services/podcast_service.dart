import 'dart:convert';
import 'package:http/http.dart' as http;
import '../config/constants.dart'; // contains baseUrl

class PodcastService {
  static Future<void> addPodcast(String email, String title, String link) async {
    final response = await http.post(
      Uri.parse('$baseUrl/podcast/add/'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'title': title, 'link': link}),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to add podcast');
    }
  }

  static Future<List<dynamic>> getPodcasts(String email) async {
    final response = await http.get(Uri.parse('$baseUrl/podcast/list/$email/'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['data'] ?? [];
    } else {
      throw Exception('Failed to fetch podcasts');
    }
  }

  static Future<void> deletePodcast(String email, String title) async {
    final response = await http.post(
      Uri.parse('$baseUrl/podcast/delete/'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'title': title}),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to delete podcast');
    }
  }
}
