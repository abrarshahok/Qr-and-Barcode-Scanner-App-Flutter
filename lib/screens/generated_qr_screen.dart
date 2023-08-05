import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/qr_items.dart';
import '../models.dart/qr_info_provider.dart';

class GeneratedQrScreen extends StatelessWidget {
  const GeneratedQrScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final qrData = Provider.of<QrInfo>(context);
    final infoList = qrData.genQrInfoList;
    qrData.getQRInfo();
    return infoList.isEmpty
        ? const Center(
            child: Text(
              'No generated QR Codes!',
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
              ),
            ),
          )
        : ListView.builder(
            itemCount: infoList.length,
            itemBuilder: (ctx, index) {
              return QrItems(
                id: infoList[index].id,
                info: infoList[index].info,
                dateTime: infoList[index].dateTime,
                icon: Icons.qr_code_rounded,
              );
            },
          );
  }
}
