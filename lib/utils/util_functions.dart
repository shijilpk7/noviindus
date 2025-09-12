class UtilFunctions {
  static String? validateName(String? value) {
    return value == null || value.isEmpty ? 'Name is required' : null;
  }

  static String? validatePhone(String? value) {
    return value == null || value.isEmpty
        ? 'Valid Phone Number is required'
        : null;
  }

  static String? validateField(String? value) {
    return value == null || value.isEmpty ? 'Field is required' : null;
  }

  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return 'Enter a valid email address';
    }
    return null;
  }
}
