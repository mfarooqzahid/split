import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:split/core/constants/app_theme.dart';

void _showToast({
  required String message,
  required Color color,
}) {
  Fluttertoast.showToast(
    msg: message,
    backgroundColor: color,
    gravity: ToastGravity.SNACKBAR,
  );
}

void showErrorToast(String message) {
  _showToast(
    message: message,
    color: kErrorColor,
  );
}

void showSuccessToast(String message) {
  _showToast(
    message: message,
    color: kPrimaryColor,
  );
}
