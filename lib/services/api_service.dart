import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  // Base URL untuk mempermudah maintenance
  static const String baseUrl = 'https://api.ppb.widiarrohman.my.id/api/2026/uts/A/kelompok4';

  static Future<String> getTitle() async {
    // Sesuaikan URL jika ini masih menggunakan Kelompok 3 atau ingin diubah ke Kelompok 4
    final response = await http.get(
      Uri.parse('https://api.ppb.widiarrohman.my.id/api/2026/uts/B/kelompok3/check'),
    );

    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to load data');
    }
  }

  // Tambahkan fungsi Login di bawah ini
  static Future<Map<String, dynamic>> login(String username, String password) async {
    final url = Uri.parse('$baseUrl/login');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'username': username,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        // Mengembalikan data JSON (biasanya berisi status dan token)
        return jsonDecode(response.body);
      } else {
        // Mengembalikan pesan error dari server jika ada
        final errorData = jsonDecode(response.body);
        throw Exception(errorData['message'] ?? 'Gagal login: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Terjadi kesalahan koneksi: $e');
    }
  }
}