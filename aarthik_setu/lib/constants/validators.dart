class Validators {
  static String? emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  static String? usernameValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Username is required';
    }
    if (value.contains(' ')) {
      return 'Username cannot contain spaces';
    }
    return null;
  }

  static String? nameValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Name is required';
    }
    return null;
  }

  static String? panValidator(String? value) {
    final String pattern = r'^[A-Z]{5}[0-9]{4}[A-Z]{1}$';
    if (value == null || value.isEmpty) {
      return 'PAN number is required';
    }
    if (!RegExp(pattern).hasMatch(value)) {
      return 'Please enter a valid PAN number';
    }
    return null;
  }
}
