import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:ride_lanka/core/utils/validators.dart';

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
    if (Validators.isEmpty(_firstNameController.text) ||
        Validators.isEmpty(_lastNameController.text) ||
        Validators.isEmpty(_emailController.text) ||
        Validators.isEmpty(_dobController.text) ||
        Validators.isEmpty(_phoneNumberController.text) ||
        Validators.isEmpty(_passwordController.text) ||
        Validators.isEmpty(_confirmPasswordController.text)) {
      Logger().e('Please fill all fields');
      return;
    } else if (Validators.isValidEmail(_emailController.text) == false) {
      Logger().e('Please enter a valid email address');
    } else if (Validators.isValidPassword(_passwordController.text) == false) {
      Logger().e('Password too weak');
    } else if (Validators.doPasswordsMatch(
          _passwordController.text,
          _confirmPasswordController.text,
        ) ==
        false) {
      Logger().e("Password doesn't match");
    } else {
      // Proceed with sign-up logic
    }
  }
}
