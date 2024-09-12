import 'package:brik/global.dart';
import 'package:flutter/material.dart';

class ShowSnackbar {
  ShowSnackbar._();

  static snackbarOk(String content) {
    ScaffoldMessenger.of(navigatorKey.currentState!.context).clearSnackBars();
    ScaffoldMessenger.of(navigatorKey.currentState!.context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 1),
        behavior: SnackBarBehavior.floating,  
        backgroundColor: Colors.green,
        content: Text(
          content.contains('SocketException') ? "Koneksi internet anda tidak stabil. Pastikan anda terhubung ke internet." : content,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 13.0
          ),
        ),
        action: SnackBarAction(
          label: "",
          onPressed: () {
            ScaffoldMessenger.of(navigatorKey.currentState!.context).hideCurrentSnackBar();
          }
        ),
      )
    );
  }

  static snackbarErr(String content) {
    ScaffoldMessenger.of(navigatorKey.currentState!.context).clearSnackBars();
    ScaffoldMessenger.of(navigatorKey.currentState!.context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 1),
        behavior: SnackBarBehavior.floating,  
        backgroundColor: Colors.red,
        content: Text(
          content.contains('SocketException') ? "Koneksi internet anda tidak stabil. Pastikan anda terhubung ke internet." : content,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 13.0
          ),
        ),
        action: SnackBarAction(
          label: "",
          onPressed: () {
            ScaffoldMessenger.of(navigatorKey.currentState!.context).hideCurrentSnackBar();
          }
        ),
      )
    );
  }

}