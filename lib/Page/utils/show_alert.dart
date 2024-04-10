
import 'package:flutter/material.dart';
import 'package:trivai_chat_social/Page/utils/custom_theme_extension.dart';

showAlertDialog({
  required BuildContext context,
  required String message,
  //required String message,
  String? btnText,
}) {
  return showDialog(
    context: context,
      builder: (context) {
      return AlertDialog(
        content: Text(
          message,
          style: TextStyle(
            color: context.theme?.greyColor,
            fontSize: 15,
          ),
        ),
        contentPadding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              btnText ?? "OK",
              style: TextStyle(
                 color: Colors.black38,
              ),
            ),
          ),
        ],
      );
    },
  );
}