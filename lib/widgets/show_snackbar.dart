import 'package:flutter/material.dart';

class ShowSnackBar {
  final BuildContext context;
  final String label;
  final Color color;
  const ShowSnackBar({required this.context, required this.label,required this.color});
  void show() {
    final hide = ScaffoldMessenger.of(context);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          label,
          style: const TextStyle(fontSize: 15, fontFamily: 'Quicksand'),
        ),
        backgroundColor: color,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        duration: const Duration(seconds: 2),
        action: SnackBarAction(
          label: 'Okay!',
          textColor: Colors.white,
          onPressed: () {
            hide.hideCurrentSnackBar();
          },
        ),
      ),
    );
  }
}
