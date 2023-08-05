import 'package:flutter/material.dart';
import '../widgets/scanner_camera.dart';

class ScannerScreen extends StatelessWidget {
  const ScannerScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            iconSize: 200,
            color: const Color.fromRGBO(146, 224, 0, 1),
            onPressed: () {
              Navigator.of(context).pushNamed(ScannerCamera.routeName);
            },
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
    );
  }
}
