import 'dart:io';
import 'package:flutter/material.dart';
import 'package:qr_and_barcode_scanner/widgets/scan-result.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class ScannerScreen extends StatefulWidget {
  static const routeName = '/scanner-screen';
  const ScannerScreen({Key? key}) : super(key: key);
  @override
  State<ScannerScreen> createState() => _ScannerScreenState();
}

class _ScannerScreenState extends State<ScannerScreen> {
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
          onPressed: () {},
          icon: const Icon(Icons.flash_on),
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.switch_camera),
        ),
      ],
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() => this.controller = controller);
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
        if (result != null) {
          Navigator.of(context).pop();
          Navigator.of(context).pushNamed(
            ScanResult.routeName,
            arguments: result?.code!,
          );
          scanSuccess();
        }
      });
    });
  }

  void scanSuccess() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text(
          'QR Code scanned successfully',
          style: TextStyle(fontSize: 15, fontFamily: 'Quicksand'),
        ),
        backgroundColor: const Color.fromRGBO(146, 224, 0, 1),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        duration: const Duration(seconds: 2),
        action: SnackBarAction(
          label: 'Dismiss',
          textColor: Colors.white,
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          },
        ),
      ),
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              iconSize: 200,
              color: const Color.fromRGBO(146, 224, 0, 1),
              onPressed: () {
                result = null;
                controller = null;
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => buildQrView(context),
                  ),
                );
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
      ),
    );
  }
}
