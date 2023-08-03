import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_and_barcode_scanner/models.dart/qr-info-provider.dart';

class GeneratedQrScreen extends StatelessWidget {
  const GeneratedQrScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final qrData = Provider.of<QrInfo>(context, listen: false);

    return FutureBuilder<Map<String, dynamic>>(
      future: qrData.getInfo(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          final qrString = snapshot.data?['qrString'] as String ?? '';

          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('QR String:'),
                Text(qrString),
              ],
            ),
          );
        }
      },
    );
  }
}
