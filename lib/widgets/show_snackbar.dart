import 'package:flutter/material.dart';

class ShowSnackBar {
  final BuildContext context;
  final String label;
  const ShowSnackBar({required this.context, required this.label});
  void show() {
    final hide = ScaffoldMessenger.of(context);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          label,
          style: const TextStyle(fontSize: 15, fontFamily: 'Quicksand'),
        ),
        backgroundColor: const Color.fromRGBO(146, 224, 0, 1),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        duration: const Duration(seconds: 2),
        action: SnackBarAction(
          label: 'Dismiss',
          textColor: Colors.white,
          onPressed: () {
            hide.hideCurrentSnackBar();
          },
        ),
      ),
    );
  }
}
