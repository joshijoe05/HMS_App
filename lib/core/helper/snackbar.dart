import 'package:flutter/material.dart';

class SnackbarService {
  static GlobalKey<ScaffoldMessengerState> messengerKey = GlobalKey<ScaffoldMessengerState>();

  static void showSnackbar(String message, [Duration? duration]) {
    final snackBar = SnackBar(
      duration: duration ?? const Duration(milliseconds: 1500),
      content: Text(
        message,
        style: const TextStyle(color: Colors.white),
      ),
      backgroundColor: Colors.black,
      behavior: SnackBarBehavior.floating,
      dismissDirection: DismissDirection.horizontal,
    );
    messengerKey.currentState?.clearSnackBars();
    messengerKey.currentState?.showSnackBar(snackBar);
  }
}
