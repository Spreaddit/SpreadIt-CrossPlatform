/// A string representing an error message for an invalid email address.
const String emailInvalidText = "Not a valid email address";

/// A string representing an error message for a password that must be at least 8 characters long.
const String passwordInvalidText ="Password must be at least 8 characters";

/// Validates whether the given [value] is a valid email address.
/// Returns `true` if the [value] is not empty and contains '@' and '.' symbols,
/// indicating it conforms to a basic email format.
bool validateEmail(String value) {
  return value.isNotEmpty && value.contains('@') && value.contains('.');
}

/// Validates whether the given [value] meets the minimum length requirement of 8 characters.
/// Returns `true` if the [value] is not empty and its length is greater than or equal to 8 characters.
bool validatePassword(String value) {
  return value.isNotEmpty && value.length >= 8;
}

/// Validates whether the given [value] is not empty.
/// Returns `true` if the [value] is not empty.
bool validateNotEmpty(String value) {
  return value.isNotEmpty;
}

/// Validates whether the given [value] for username meets certain criteria.
/// This function checks whether the username contains only letters, numbers, dashes, and underscores,
/// and its length is between 3 and 20 characters.
/// Returns `false` if the username violates any of the specified criteria.
bool validateusername(String value) {
  RegExp regExp = RegExp(r'^[a-zA-Z0-9_-]+$');
  if (!regExp.hasMatch(value) && value.isNotEmpty) {
    return false;
  }
  if (value.length >= 3 && value.length <= 20) {
    return false;
  }
  return true;
}

  bool validatePostTitle(String value) {
    if(value.isNotEmpty && !RegExp(r'^[\W_]+$').hasMatch(value)) {
      return true;
    }
    else {
      return false;
    }
  }

  bool validateLink(String url) {
    RegExp regex = RegExp(r'^.{4,}\.[a-zA-Z]{2,3}$');
    return regex.hasMatch(url);
  }
/// Provides a detailed error message based on the validation result for the username.
/// Returns an appropriate error message if the username does not meet the required criteria.
/// Otherwise, returns a success message indicating the username is available.
String validateusernametext(String value) {
  RegExp regExp = RegExp(r'^[a-zA-Z0-9_-]+$');
  if (!regExp.hasMatch(value) && value.isNotEmpty) {
    return "Username can only contain letters, numbers, dashes, and underscores.";
  } else if (value.length < 3 || value.length > 20) {
    return "Username must be between 3 and 20 characters.";
  }
  return "Great name! it's not taken, so it's all yours.";
}

bool validateInputLength(String value ,int length) {
    if (length - value.length < 0)
    {    
      return false;
    }    
    return true;
}
