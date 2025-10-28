class MyValidators {
  static String? displayNamevalidator(String? displayName) {
    if (displayName == null || displayName.isEmpty) {
      return 'Display name cannot be empty';
    }
    if (displayName.length < 3 || displayName.length > 20) {
      return 'Display name must be between 3 and 20 characters';
    }
    return null;
  }

  static String? emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter an email';
    }
    if (!RegExp(
      r'\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Z|a-z]{2,}\b',
    ).hasMatch(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  static String? phoneValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a phone';
    }
    // (تم التعديل) تحقق من 11 رقم بالضبط ويبدأ بـ 01
    if (!RegExp(r'^01[0-9]{9}$').hasMatch(value)) {
      return 'Please enter a valid 11-digit Egyptian phone number';
    }
    return null;
  }

  static String? passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a password';
    }
    if (value.length < 8) {
      return 'Password must be at least 8 characters long';
    }
    return null;
  }

  static String? nationalIdValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a national ID';
    }
    // (تم التعديل) تحقق من 14 رقم بالضبط
    if (!RegExp(r'^[0-9]{14}$').hasMatch(value)) {
      return 'National ID must be exactly 14 digits';
    }
    return null;
  }

  static String? repeatPasswordValidator({String? value, String? password}) {
    if (value != password) {
      return 'Passwords do not match';
    }
    return null;
  }

  static String? genderValidator({String? value}) {
    if (value == null || value.isEmpty) {
      return 'Please enter gender';
    }
    return null;
  }

  static String? imageValidator(String? image) {
    if (image == null || image.isEmpty) {
      return 'Image cannot be empty';
    }
    return null;
  }

  static String? tokenValidator(String? val) {
    if (val == null || val.isEmpty) {
      return 'Token cannot be empty';
    }
    return null;
  }
}
