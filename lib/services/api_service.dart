import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static Future<String> getTitle() async {
    final response = await http.get(
      Uri.parse('https://api.ppb.widiarrohman.my.id/api/2026/uts/B/kelompok3/check'),
    );

    if (response.statusCode == 200) {
      // karena response kamu plain text
      return response.body;
    } else {
      throw Exception('Failed to load data');
    }
  }
}