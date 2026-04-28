import 'package:flutter/material.dart';
import '../../models/login_response.dart';

class SuccessRegistrationScreen extends StatelessWidget {
  final LoginResponse loginData;

  const SuccessRegistrationScreen({
    super.key,
    required this.loginData,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Success")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Status: ${loginData.message}"),
            const SizedBox(height: 10),
            Text("Token: ${loginData.token.substring(0, 10)}..."),
          ],
        ),
      ),
    );
  }
}