import 'package:flutter/material.dart';
import '../services/api_service.dart';

class SignInViewModel extends ChangeNotifier {
  String title = "Loading...";
  bool isLoading = true;

  Future<void> fetchTitle() async {
    try {
      isLoading = true;
      notifyListeners();

      title = await ApiService.getTitle();
    } catch (e) {
      title = "Error mengambil data";
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}