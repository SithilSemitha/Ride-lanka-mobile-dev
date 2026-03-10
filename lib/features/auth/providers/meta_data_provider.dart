import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ride_lanka/core/constants/app_dialogs.dart';
import 'package:ride_lanka/features/auth/models/user_model.dart';
import 'package:ride_lanka/features/auth/providers/auth_provider.dart';
import 'package:ride_lanka/features/auth/services/auth_service.dart';
import 'package:provider/provider.dart';
import 'package:ride_lanka/routes/app_routes.dart';

class MetaDataProvider extends ChangeNotifier {
  final AuthService _authService = AuthService();

  List<String> selectedInterests = [];
  String? travelType;
  String? budget;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool get isValid =>
      selectedInterests.isNotEmpty && travelType != null && budget != null;

  void toggleInterest(String interest) {
    if (selectedInterests.contains(interest)) {
      selectedInterests.remove(interest);
    } else {
      selectedInterests.add(interest);
    }
    notifyListeners();
  }

  void setTravelType(String type) {
    travelType = type;
    notifyListeners();
  }

  void setBudget(String value) {
    budget = value;
    notifyListeners();
  }

  Future<void> saveUser(BuildContext context) async {
    try {
      _isLoading = true;
      notifyListeners();

      final authProvider = Provider.of<AuthController>(context, listen: false);
      final firebaseUser = FirebaseAuth.instance.currentUser;

      if (firebaseUser == null) {
        throw Exception("User not found");
      }

      final user = UserModel(
        uid: firebaseUser.uid,
        firstName: authProvider.firstNameController.text,
        lastName: authProvider.lastNameController.text,
        email: authProvider.emailController.text,
        dob: authProvider.dobController.text,
        phone: authProvider.phoneNumberController.text,
        interests: selectedInterests,
        travelType: travelType!,
        budget: budget!,
        createdAt: DateTime.now(),
      );

      await _authService.saveUser(user);

      // Ensure UI updates the loading state before navigating
      _isLoading = false;
      notifyListeners();

      // Delay slightly to let the spinner disappear
      await Future.delayed(const Duration(milliseconds: 200));

      Navigator.of(
        context,
      ).pushNamedAndRemoveUntil(AppRoutes.home, (route) => false);
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      AppDialogs.loginFailedDialog(context);
    }
  }
}
