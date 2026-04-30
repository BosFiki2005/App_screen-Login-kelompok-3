import 'package:flutter/material.dart';
import '../../models/login_response.dart';
import 'product_screen.dart'; // Pastikan file ini sudah ada di folder yang sama

class SuccessRegistrationScreen extends StatelessWidget {
  final LoginResponse loginData;

  const SuccessRegistrationScreen({
    super.key,
    required this.loginData,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Registration Success"),
        backgroundColor: Colors.green,
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Icon Sukses
              const Icon(
                Icons.check_circle_outline,
                size: 100,
                color: Colors.green,
              ),
              const SizedBox(height: 20),
              
              // Pesan Status dari API
              Text(
                "Status: ${loginData.message}",
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              
              // Cuplikan Token
              Text(
                "Token: ${loginData.token.length > 10 ? loginData.token.substring(0, 10) : loginData.token}...",
                style: const TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 40),
              
              // Tombol Navigasi ke Halaman Produk
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductScreen(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent, // Warna utama tombol
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    "Lihat Produk Kami",
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}