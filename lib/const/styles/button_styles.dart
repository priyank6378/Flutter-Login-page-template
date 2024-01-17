import 'package:flutter/material.dart';

final customButtonStyle1 = ButtonStyle(
  overlayColor: MaterialStateProperty.all(
    Colors.black.withOpacity(0.1),
  ),
  shape: MaterialStateProperty.all(
    RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(2),
    ),
  ),
);
