
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

  bool validateusername(String value) {
    // Not taken from backend
    RegExp regExp = RegExp(r'^[a-zA-Z0-9_-]+$');
    if (!regExp.hasMatch(value) && value.isNotEmpty) {
      return false;
    }
    if (value.length >= 3 && value.length <= 20)
    {
      return false;
    }
    return  true;
  }

  String validateusernametext(String value) {
    RegExp regExp = RegExp(r'^[a-zA-Z0-9_-]+$');
    if (!regExp.hasMatch(value) && value.isNotEmpty) {
      return "Username can only contain letters, numbers, dashes, and underscores.";
    } else if (value.length < 3 || value.length > 20) {
      return "Username must be between 3 and 20 characters.";
    }
    return "Great name! it's not taken, so it's all yours.";
  }

  bool validatePostTitle(String value) {
    if(value.isNotEmpty && !RegExp(r'^[\W_]+$').hasMatch(value)) {
      return true;
    }
    else {
      return false;
    }
  }