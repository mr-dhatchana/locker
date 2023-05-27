import 'package:flutter/material.dart';

void showMessage(String? message, BuildContext? context) {
  if (message != null && context != null) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
}

void showNoInternetMessage(context) {
  if (context != null) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('verify your internet connection'),
      ),
    );
  }
}
