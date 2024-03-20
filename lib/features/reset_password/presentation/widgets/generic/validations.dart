
  const String emailInvalidText = "Not a valid email address";
  const String passwordInvalidText ="Password must be at least 8 characters";
  bool validateEmail(String value)
  {
    return value.isNotEmpty && value.contains('@') && value.contains('.');
  }

  bool validatePassword(String value)
  {
       return value.isNotEmpty && value.length >= 8;
  }

  bool validateNotEmpty(String value)
  {
    return value.isNotEmpty;
  }
