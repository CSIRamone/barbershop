import 'package:flutter/material.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

sealed class Messages {
  static void showError(String message, BuildContext context) {
    /*final snackBar = SnackBar(
      content: Text(message),
      backgroundColor: Colors.red,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);*/
    showTopSnackBar(
      Overlay.of(context), 
      CustomSnackBar.error(message: message),);
  }

  static void showInfo(String message, BuildContext context) {
    /*final snackBar = SnackBar(
      content: Text(message),
      backgroundColor: Colors.blue,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);*/
    showTopSnackBar(
      Overlay.of(context),
      CustomSnackBar.info(message: message),);
  }

  static void showSuccess(String message, BuildContext context) {
    /*final snackBar = SnackBar(
      content: Text(message),
      backgroundColor: Colors.green,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);*/
    showTopSnackBar(
      Overlay.of(context),
      CustomSnackBar.success(message: message),);
  }

}