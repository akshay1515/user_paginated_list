import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:koohutest/utils/constants/stringConstants.dart';

class ExceptionDialog {
  static showCustomAlertDialog(
      {required BuildContext ctx,
      required String statusCode,
      required String message,
      required String actionTitle,
      required VoidCallback onpressed}) {
    showDialog(
        context: ctx,
        builder: (_) {
          return AlertDialog(
            title: Text(
              StringConstants.APIExceptionTitle,
              style: Theme.of(ctx).textTheme.headline6,
            ),
            alignment: Alignment.center,
            actions: [
              ElevatedButton(onPressed: onpressed, child: Text(actionTitle))
            ],
          );
        });
  }
}
