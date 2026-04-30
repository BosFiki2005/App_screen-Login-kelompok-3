import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/cart_item.dart'; // Import model yang baru dibuat

class ApiService {
  static const String baseUrl = 'https://api.ppb.widiarrohman.my.id/api/2026/uts/A/kelompok4';

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
        return jsonDecode(response.body);
      } else {
        final errorData = jsonDecode(response.body);
        throw Exception(errorData['message'] ?? 'Gagal login: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Terjadi kesalahan koneksi: $e');
    }
  }

  static Future<List<dynamic>> getProducts() async {
    const String productUrl = 'https://api.ppb.widiarrohman.my.id/api/2026/uts/B/kelompok3/products';

    try {
      final response = await http.get(Uri.parse(productUrl));

      if (response.statusCode == 200) {
        final Map<String, dynamic> decodedData = jsonDecode(response.body);
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

  /// === FIX: getCart dengan Model & Perbaikan Variabel Exception ===
  static Future<List<CartItem>> getCart() async {
    const String cartUrl = 'https://api.ppb.widiarrohman.my.id/api/2026/uts/B/kelompok3/cart';

    try {
      final response = await http.get(Uri.parse(cartUrl));

      if (response.statusCode == 200) {
        final Map<String, dynamic> decodedData = jsonDecode(response.body);
        
        if (decodedData['status'] == 'success') {
          // Mapping data list dynamic ke list object CartItem
          List<dynamic> data = decodedData['data'];
          return data.map((item) => CartItem.fromJson(item)).toList();
        } else {
          throw Exception('Gagal mengambil data keranjang');
        }
      } else {
        throw Exception('Error server: ${response.statusCode}');
      }
    } catch (e) {
      // Perbaikan: Menggunakan $e sesuai definisi catch (e)
      throw Exception('Terjadi kesalahan koneksi: $e'); 
    }
  }
}