
/// This function takes the [currentPassword] variable and ensures that it is not empty (that the user provided his current password).
/// Returns `true` if the [currentPassword] variable is not empty, else it returns `false`.
bool checkCurrentPassExists(String currentPassword) {
  if (currentPassword.isNotEmpty) {
    return true;
  } else {
    return false;
  }
}

/// This function checks the passwords' length. It takes the 3 variables [currentPassword], [newPassword] and [confirmedPassword]
/// to ensure none of them has a length less than 8 characters.
/// Returns `false` if any of the 3 variables is less than 8 characters long, else it returns `true`.
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


/// This function checks that the [newPassword] and [confirmedPassword] are identical.
/// Returns `true` if they are identical, else it returns `false` 
bool checkIdentical(String newPassword, String confirmedPassword) {
  if (newPassword != confirmedPassword) {
    return false;
  } else {
    return true;
  }
}
