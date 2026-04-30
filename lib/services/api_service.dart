import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  // Base URL sesuai dengan konstanta proyek Anda
  static const String baseUrl = 'https://api.ppb.widiarrohman.my.id/api/2026/uts/A/kelompok4';

  /// Fungsi untuk mengambil judul (check endpoint)
  static Future<String> getTitle() async {
    final response = await http.get(
      Uri.parse('https://api.ppb.widiarrohman.my.id/api/2026/uts/B/kelompok3/check'),
    );

    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to load data');
    }
  }

  /// Fungsi Login (Mengirim data POST ke API)
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
        // Mengembalikan data JSON (status, message, token)
        return jsonDecode(response.body);
      } else {
        final errorData = jsonDecode(response.body);
        throw Exception(errorData['message'] ?? 'Gagal login: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Terjadi kesalahan koneksi: $e');
    }
  }

  /// Fungsi Get Products (Konversi dari Axios JavaScript)
  /// Mengambil data produk dari endpoint Kelompok 3 sesuai gambar Hoppscotch
  static Future<List<dynamic>> getProducts() async {
    const String productUrl = 'https://api.ppb.widiarrohman.my.id/api/2026/uts/B/kelompok3/products';

    try {
      final response = await http.get(Uri.parse(productUrl));

      if (response.statusCode == 200) {
        final Map<String, dynamic> decodedData = jsonDecode(response.body);
        
        // Sesuai dengan struktur JSON di image_f02837.png, data produk ada di key 'data'
        if (decodedData['status'] == 'success') {
          return decodedData['data'];
        } else {
          throw Exception('API mengembalikan status gagal');
        }
      } else {
        throw Exception('Gagal memuat produk: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Terjadi kesalahan koneksi saat mengambil produk: $e');
    }
  }
}