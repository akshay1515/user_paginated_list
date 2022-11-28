

import 'package:flutter/material.dart';

class LazyLoadingDialog {
  static showCustomAlertDialog(
      {required BuildContext ctx}) {
    showDialog(
        context: ctx,
        builder: (_) {
          return AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: const [
                CircularProgressIndicator(),
                SizedBox(height: 8,),
                Text("Getting User List")
              ],
            ),
            alignment: Alignment.center,
          );
        });
  }
}
