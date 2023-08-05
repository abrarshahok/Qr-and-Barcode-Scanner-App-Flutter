import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models.dart/generated-qr-info-provider.dart';
import '../widgets/qr_items.dart';

class ScannedQrScreen extends StatelessWidget {
  const ScannedQrScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final qrData = Provider.of<GeneratedQrInfo>(context);
    return qrData.infoList.isEmpty
        ? const Center(
            child: Text(
              'No Scanned QR Codes!',
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
              ),
            ),
          )
        : ListView.builder(
            itemCount: qrData.infoList.length,
            itemBuilder: (ctx, index) {
              return QrItems(
                id: qrData.infoList[index].id,
                info: qrData.infoList[index].info,
                dateTime: qrData.infoList[index].dateTime,
              );
            },
          );
  }
}
