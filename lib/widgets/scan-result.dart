import 'package:flutter/material.dart';

class ScanResult extends StatelessWidget {
  static const routeName = '/scan-result';

  const ScanResult({super.key});
  @override
  Widget build(BuildContext context) {
    final result = ModalRoute.of(context)?.settings.arguments as String;
    return Scaffold(body: Center(child: Text(result)));
  }
}
