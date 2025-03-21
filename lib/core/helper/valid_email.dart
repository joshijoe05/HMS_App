extension EmailValidator on String {
  bool isValidEmail() {
    return RegExp(r'^[Nn]\d{6}@rguktn\.ac\.in$').hasMatch(this);
  }
}
