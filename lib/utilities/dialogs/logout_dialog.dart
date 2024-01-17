import 'package:flutter/material.dart';
import '/utilities/dialogs/generic_dialog.dart';

Future<bool> showLogOutDialog(BuildContext context) {
  return showGenericDialog(
    context: context,
    title: "Logout",
    content: "Are you sure?",
    optionsBuilder: () => {
      'Cancel': false,
      "Logout": true,
    },
  ).then(
    (value) => value ?? false,
  );
}
