import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../models/login_response.dart';
import '../../../services/api_service.dart';
import '../../success_screen.dart';

// Definisi style border agar kode lebih rapi
const authOutlineInputBorder = OutlineInputBorder(
  borderSide: BorderSide(color: Color(0xFF757575)),
  borderRadius: BorderRadius.all(Radius.circular(12)),
);

class OtpForm extends StatefulWidget {
  const OtpForm({super.key});

  @override
  State<OtpForm> createState() => _OtpFormState();
}

class _OtpFormState extends State<OtpForm> {
  bool _isLoading = false;
  
  // Controller jika kamu ingin mengambil nilai input secara manual (Opsional)
  // Untuk simulasi ini, kita gunakan default 'admin' & '1234' sesuai API Kelompok 4

  void _handleLogin() async {
    setState(() {
      _isLoading = true;
    });

    try {
      // Memanggil API Service yang mengarah ke Kelompok 4
      final result = await ApiService.login('admin', '1234');

      final data = LoginResponse(
        message: result['status'] ?? "Login berhasil",
        token: result['token'] ?? "",
      );

      if (!mounted) return;

      // Navigasi ke halaman sukses jika berhasil
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => SuccessRegistrationScreen(
            loginData: data,
          ),
        ),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildOtpBox(context, first: true, last: false),
              _buildOtpBox(context, first: false, last: false),
              _buildOtpBox(context, first: false, last: false),
              _buildOtpBox(context, first: false, last: true),
            ],
          ),
          const SizedBox(height: 24),
          _isLoading
              ? const CircularProgressIndicator(color: Color(0xFFFF7643))
              : ElevatedButton(
                  onPressed: _handleLogin,
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    backgroundColor: const Color(0xFFFF7643),
                    foregroundColor: Colors.white,
                    minimumSize: const Size(double.infinity, 48),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                    ),
                  ),
                  child: const Text("Continue"),
                ),
        ],
      ),
    );
  }

  // Helper widget untuk membuat kotak input OTP agar kode tidak duplikat
  Widget _buildOtpBox(BuildContext context, {required bool first, required bool last}) {
    return SizedBox(
      height: 64,
      width: 64,
      child: TextFormField(
        onChanged: (pin) {
          if (pin.isNotEmpty && !last) {
            FocusScope.of(context).nextFocus();
          } else if (pin.isEmpty && !first) {
            FocusScope.of(context).previousFocus();
          }
        },
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        inputFormatters: [
          LengthLimitingTextInputFormatter(1),
          FilteringTextInputFormatter.digitsOnly,
        ],
        style: Theme.of(context).textTheme.titleLarge,
        decoration: InputDecoration(
          hintText: "0",
          hintStyle: const TextStyle(color: Color(0xFF757575)),
          border: authOutlineInputBorder,
          enabledBorder: authOutlineInputBorder,
          focusedBorder: authOutlineInputBorder.copyWith(
            borderSide: const BorderSide(color: Color(0xFFFF7643)),
          ),
        ),
      ),
    );
  }
}