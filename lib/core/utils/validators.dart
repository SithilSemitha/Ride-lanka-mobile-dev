class Validators {
  static bool isEmpty(String value) {
    return value.trim().isEmpty;
  }

  static bool isValidEmail(String email) {
    return RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(email.trim());
  }

  static bool isValidPassword(String password) {
    return password.trim().length >= 6;
  }

  static bool doPasswordsMatch(String password, String confirmPassword) {
    return password.trim() == confirmPassword.trim();
  }

  static bool isValidPhone(String phone) {
    return phone.trim().length >= 8;
  }

  static bool isValidDate(String date) {
    try {
      DateTime.parse(date);
      return true;
    } catch (_) {
      return false;
    }
  }
}
