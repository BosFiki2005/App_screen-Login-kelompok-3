import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Import halaman sukses Anda di sini jika file-nya terpisah
// import 'success_screen.dart'; 

class OtpScreen extends StatelessWidget {
  const OtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const BackButton(color: Colors.black),
        title: const Text(
          "OTP Verification",
          style: TextStyle(color: Color(0xFF757575)),
        ),
      ),
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 16),
                  const Text(
                    "OTP Verification",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "We sent your code to +1 898 860 *** \nThis code will expired in 00:30",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Color(0xFF757575)),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                  const OtpForm(),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.2),
                  TextButton(
                    onPressed: () {
                      // Logika untuk kirim ulang kode
                    },
                    child: const Text(
                      "Resend OTP Code",
                      style: TextStyle(color: Color(0xFF757575)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

const authOutlineInputBorder = OutlineInputBorder(
  borderSide: BorderSide(color: Color(0xFF757575)),
  borderRadius: BorderRadius.all(Radius.circular(12)),
);

class OtpForm extends StatelessWidget {
  const OtpForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildOtpBox(context, isFirst: true),
              _buildOtpBox(context),
              _buildOtpBox(context),
              _buildOtpBox(context, isLast: true),
            ],
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {
              // INI ADALAH BAGIAN NAVIGASI KE HALAMAN SUKSES
              // Ganti 'SuccessRegistrationScreen' dengan nama class di file success_screen.dart Anda
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SuccessRegistrationScreen(), 
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              elevation: 0,
              backgroundColor: const Color(0xFF00BF6D),
              foregroundColor: Colors.white,
              minimumSize: const Size(double.infinity, 54),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(16)),
              ),
            ),
            child: const Text(
              "Continue",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
    );
  }

  // Fungsi pembantu agar kode Row tidak terlalu panjang
  Widget _buildOtpBox(BuildContext context, {bool isFirst = false, bool isLast = false}) {
    return SizedBox(
      height: 64,
      width: 64,
      child: TextFormField(
        onChanged: (pin) {
          if (pin.isNotEmpty && !isLast) {
            FocusScope.of(context).nextFocus();
          }
          if (pin.isEmpty && !isFirst) {
            FocusScope.of(context).previousFocus();
          }
        },
        textInputAction: isLast ? TextInputAction.done : TextInputAction.next,
        keyboardType: TextInputType.number,
        inputFormatters: [
          LengthLimitingTextInputFormatter(1),
          FilteringTextInputFormatter.digitsOnly,
        ],
        style: Theme.of(context).textTheme.titleLarge,
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          hintText: "0",
          hintStyle: const TextStyle(color: Color(0xFF757575)),
          border: authOutlineInputBorder,
          enabledBorder: authOutlineInputBorder,
          focusedBorder: authOutlineInputBorder.copyWith(
            borderSide: const BorderSide(color: Color(0xFF00BF6D), width: 2),
          ),
        ),
      ),
    );
  }
}

// Tambahkan class ini jika Anda belum punya file success_screen.dart
// Jika sudah ada di file lain, hapus bagian ini dan gunakan import
class SuccessRegistrationScreen extends StatelessWidget {
  const SuccessRegistrationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text("Halaman Sukses")),
    );
  }
}