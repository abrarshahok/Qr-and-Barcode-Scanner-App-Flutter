import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class ScannerScreen extends StatelessWidget {
  static const routeName = '/scanner-screen';
  ScannerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(52, 58, 64, 1),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              iconSize: 200,
              color: const Color.fromRGBO(146, 224, 0, 1),
              onPressed: () {},
              icon: const Icon(
                Icons.qr_code_scanner,
              ),
            ),
            const Text(
              'Tap to Scan',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
