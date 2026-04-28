import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // 1. Tambahkan import provider
import '../viewmodels/sign_in_view_model.dart'; // 2. Pastikan path import benar

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();
  String? phone;
  String? password;

  @override
  void initState() {
    super.initState();
    // 3. Panggil fungsi ambil data API saat layar pertama kali dimuat
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<SignInViewModel>().fetchTitle();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  SizedBox(height: constraints.maxHeight * 0.1),
Image.asset(
  "assets/logo.png",
  height: 100,
),
                  SizedBox(height: constraints.maxHeight * 0.1),

                  // 4. BUNGKUS DENGAN CONSUMER AGAR TEKS BERUBAH OTOMATIS
                  Consumer<SignInViewModel>(
                    builder: (context, viewModel, child) {
                      return Text(
                        viewModel.isLoading ? "Loading..." : viewModel.title,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      );
                    },
                  ),

                  SizedBox(height: constraints.maxHeight * 0.05),

                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          keyboardType: TextInputType.phone,
                          decoration: _inputDecoration("Phone"),
                          validator: (value) =>
                              value!.isEmpty ? "Phone wajib diisi" : null,
                          onSaved: (value) => phone = value,
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          obscureText: true,
                          decoration: _inputDecoration("Password"),
                          validator: (value) =>
                              value!.length < 6 ? "Minimal 6 karakter" : null,
                          onSaved: (value) => password = value,
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();
                              Navigator.pushNamed(context, '/otp');
                            }
                          },
                          style: _buttonStyle(const Color(0xFF00BF6D)),
                          child: const Text("Sign in"),
                        ),
                        const SizedBox(height: 16),
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/confirm-password');
                          },
                          child: const Text("Forgot Password?"),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: const Text("Don’t have an account? Sign Up"),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  // ... (Method _inputDecoration dan _buttonStyle tetap sama)
  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      filled: true,
      fillColor: const Color(0xFFF5FCF9),
      contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(50),
        borderSide: BorderSide.none,
      ),
    );
  }

  ButtonStyle _buttonStyle(Color color) {
    return ElevatedButton.styleFrom(
      backgroundColor: color,
      foregroundColor: Colors.white,
      minimumSize: const Size(double.infinity, 48),
      shape: const StadiumBorder(),
    );
  }
}