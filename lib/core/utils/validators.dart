class Validators {
  Validators._();

  ///private constructor to prevent instantiation
  static String? validateEmail(String? val) {
    final RegExp emailRegex = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
    );
    if (val == null) {
      return 'This field is required';
    } else if (val.trim().isEmpty) {
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
      return 'Strong password required';
    } else {
      return null;
    }
  }

  static String? validateConfirmPassword(String? val, String? password) {
    if (val == null || val.isEmpty) {
      return 'This field is required';
    } else if (val != password) {
      return 'Not the Same password';
    } else {
      return null;
    }
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

  static String? validatePhoneNumber(String? val) {
    if (val == null) {
      return 'This field is required';
    } else if (int.tryParse(val.trim()) == null) {
      //check if val is a number not string
      return 'Enter numbers only';
    } else if (val.trim().length != 11) {
      return 'Enter value must equal 11 digit';
    } else {
      return null;
    }
  }
}
