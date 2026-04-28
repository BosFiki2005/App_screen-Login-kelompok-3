import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// import sesuai struktur folder
import 'screens/sign_in_screen.dart';
import 'screens/otp_screen.dart';
import 'screens/confirm_password_screen.dart';
import 'error/error_404_screen.dart';
import 'notification/empty_notifications_screen.dart';

// import viewmodel
import 'viewmodels/sign_in_view_model.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SignInViewModel()),
      ],
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // UBAH BAGIAN INI:
      title: 'UTS Kelas B - Kelompok 3', 
      theme: ThemeData(primarySwatch: Colors.green),
      initialRoute: '/signin',
      routes: {
        '/signin': (context) => const SignInScreen(),
        '/otp': (context) => const OtpScreen(),
        '/confirm-password': (context) => const ConfirmPasswordScreen(),
        '/error': (context) => const Error404Screen(),
        '/empty': (context) => const EmptyNotificationsScreen(),
      },
    );
  }
}