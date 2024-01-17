import 'package:flutter/material.dart';
import '/utilities/dialogs/generic_dialog.dart';

Future<bool> showDeleteDialog(BuildContext context) {
  return showGenericDialog(
    context: context,
    title: "Delete",
    content: "Are you sure?",
    optionsBuilder: () => {
      'Cancel': false,
      "Yes": true,
    },
  ).then(
    (value) => value ?? false,
  );
}
