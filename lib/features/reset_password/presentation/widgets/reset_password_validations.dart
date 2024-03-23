bool checkCurrentPassExists(String currentPassword) {
  if (currentPassword.isNotEmpty) {
    return true;
  } else {
    return false;
  }
}

bool checkPasswordLength(
    String currentPassword, String newPassword, String confirmedPassword) {
  if (currentPassword.length < 8 ||
      newPassword.length < 8 ||
      confirmedPassword.length < 8) {
    return false;
  } else {
    return true;
  }
}

bool checkIdentical(String newPassword, String confirmedPassword) {
  if (newPassword != confirmedPassword) {
    return false;
  } else {
    return true;
  }
}
