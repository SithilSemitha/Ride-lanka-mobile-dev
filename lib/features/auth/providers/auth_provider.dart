import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class AuthProvider extends ChangeNotifier {
  final TextEditingController _firstNameController = TextEditingController();
  TextEditingController get firstNameController => _firstNameController;

  final TextEditingController _lastNameController = TextEditingController();
  TextEditingController get lastNameController => _lastNameController;

  final TextEditingController _emailController = TextEditingController();
  TextEditingController get emailController => _emailController;

  final TextEditingController _dobController = TextEditingController();
  TextEditingController get dobController => _dobController;

  final TextEditingController _phoneNumberController = TextEditingController();
  TextEditingController get phoneNumberController => _phoneNumberController;

  final TextEditingController _passwordController = TextEditingController();
  TextEditingController get passwordController => _passwordController;

  final TextEditingController _confirmPasswordController =
      TextEditingController();
  TextEditingController get confirmPasswordController =>
      _confirmPasswordController;

  Future<void> signUp(BuildContext context) async {
    if (_firstNameController.text.isEmpty ||
        _lastNameController.text.isEmpty ||
        _emailController.text.isEmpty ||
        _dobController.text.isEmpty ||
        _phoneNumberController.text.isEmpty ||
        _passwordController.text.isEmpty ||
        _confirmPasswordController.text.isEmpty) {
      Logger().e('Please fill in all fields');
    } else if (RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(_emailController.text) ==
        false) {
      Logger().e('Please enter a valid email address');
    } else if (_passwordController.text.trim().length < 6) {
      Logger().e('Password too weak');
    } else if (_confirmPasswordController.text.trim() !=
        _passwordController.text.trim()) {
      Logger().e("Password doesn't match");
    } else {
      // Proceed with sign-up logic
    }
  }
}
