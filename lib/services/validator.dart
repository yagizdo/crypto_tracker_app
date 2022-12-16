class Validator {
  static String? email(String? value) {
    if (RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value!)) {
      return null;
    }
    return 'Please enter a valid email';
  }

  static String? name(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter some text';
    } else if (value.length < 3) {
      return 'Name must be at least 3 characters';
    }
    return null;
  }

  static String? password(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter some text';
    } else if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  static String? passwordsMatch(String? value, String? passwordOne, String? passwordTwo) {
    if (value == null || value.isEmpty) {
      return 'Please enter some text';
    } else if (value.length < 6) {
      return 'Password must be at least 6 characters';
    } else if (passwordOne != passwordTwo) {
      return 'Passwords do not match';
    }
    return null;
  }
}