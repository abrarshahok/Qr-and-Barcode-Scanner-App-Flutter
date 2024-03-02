import 'package:provider/provider.dart';
import 'package:qr_and_barcode_scanner/providers/qr_info_provider.dart';

import 'scan_result.dart';
import '/widgets/show_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'dart:io';

class ScannerCamera extends StatefulWidget {
  static const routeName = '/scanner-camera';

  const ScannerCamera({super.key});
  @override
  State<ScannerCamera> createState() => _ScannerCameraState();
}

class _ScannerCameraState extends State<ScannerCamera> {
  final qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;

  Widget buildQrView(BuildContext context) {
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
        borderColor: const Color.fromRGBO(146, 224, 0, 1),
        borderRadius: 15,
        borderWidth: 10,
        overlayColor: Colors.black87,
        cutOutSize: MediaQuery.of(context).size.width * 0.8,
      ),
    );
  }

  Widget buildControllButtons() {
    return Row(
      children: [
        IconButton(
          onPressed: () {
            controller!.toggleFlash();
            setState(() {});
          },
          iconSize: 30,
          icon: FutureBuilder<bool?>(
            future: controller?.getFlashStatus(),
            builder: (context, snapshot) {
              if (snapshot.data != null) {
                return Icon(snapshot.data! ? Icons.flash_on : Icons.flash_off);
              }
              return const Icon(Icons.flash_off);
            },
          ),
          color: Colors.white,
        ),
        const SizedBox(
          width: 100,
        ),
        IconButton(
          onPressed: () {
            controller!.flipCamera();
          },
          iconSize: 30,
          icon: const Icon(Icons.switch_camera),
          color: Colors.white,
        ),
      ],
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    bool scanSuccessful = false;
    controller.scannedDataStream.listen((scanData) {
      if (!scanSuccessful) {
        result = scanData;
        if (result?.code != null) {
          scanSuccessful = true;
          _scanSuccess();
        }
      }
    });
  }

  void _scanSuccess() {
    Navigator.of(context).pop();
    Navigator.of(context).pushNamed(
      ScanResult.routeName,
      arguments: result?.code!,
    );
    ShowSnackBar(
      context: context,
      label: 'QR Code scanned successfully',
      color: const Color.fromRGBO(146, 224, 0, 1),
    ).show();
    Provider.of<QrInfo>(context, listen: false).saveQRInfo(
      id: DateTime.now().toString(),
      info: result?.code as String,
      dateTime: DateTime.now(),
      isScan: true,
    );
  }

  @override
  void reassemble() async {
    if (Platform.isAndroid) {
      await controller?.pauseCamera();
    }
    controller?.resumeCamera();
    super.reassemble();
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(52, 58, 64, 1),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(52, 58, 64, 1),
        title: Text(
          'Back',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          buildQrView(context),
          Positioned(
            bottom: 10,
            child: buildControllButtons(),
          ),
        ],
      ),
    );
  }
}
