class Validators {
  Validators._();

  static String? validateEmail(String? val) {
    final RegExp emailRegex = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
    );
    if (val == null || val.trim().isEmpty) {
      return 'This field is required';
    } else if (emailRegex.hasMatch(val) == false) {
      return 'Enter valid email';
    } else {
      return null;
    }
  }

  static String? validatePassword(String? val) {
    if (val == null || val.isEmpty) {
      return 'This field is required';
    } else if (val.length < 8) {
      return 'Strong password required (min 8 characters)';
    } else {
      return null;
    }
  }

  static String? validateConfirmPassword(String? val, String? password) {
    if (val == null || val.isEmpty) {
      return 'This field is required';
    } else if (val != password) {
      return 'Passwords do not match';
    } else {
      return null;
    }
  }

  // FIXED: Added this method to handle general fields like Name and Location
  static String? validateField(String? val, String fieldName) {
    if (val == null || val.trim().isEmpty) {
      return '$fieldName is required';
    }
    return null;
  }

  static String? validateUsername(String? val) {
    final RegExp usernameRegex = RegExp(r'^[a-zA-Z0-9,.-]+$');
    if (val == null || val.isEmpty) {
      return 'This field is required';
    } else if (!usernameRegex.hasMatch(val)) {
      return 'Enter valid username';
    } else {
      return null;
    }
  }

  static String? validateFullName(String? val) {
    if (val == null || val.isEmpty) {
      return 'This field is required';
    } else {
      return null;
    }
  }
}
