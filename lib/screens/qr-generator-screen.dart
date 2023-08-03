import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_and_barcode_scanner/models.dart/qr-info-provider.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrGeneratorScreen extends StatefulWidget {
  @override
  State<QrGeneratorScreen> createState() => _QrGeneratorScreenState();
}

class _QrGeneratorScreenState extends State<QrGeneratorScreen> {
  final controller = TextEditingController();
  String qrString = '';

  void _saveQrCodeInfo() {
    Provider.of<QrInfo>(context, listen: false).saveInfo(qrString);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text(
          'QR Info saved successfully',
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
    setState(() {
      controller.text = '';
      qrString = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(52, 58, 64, 1),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 50),
              QrImageView(
                data: qrString,
                size: 200,
                backgroundColor: Colors.white,
              ),
              const SizedBox(height: 50),
              Padding(
                padding: const EdgeInsets.all(5),
                child: TextField(
                  decoration: const InputDecoration(
                    labelText: 'Enter some data...',
                    labelStyle: TextStyle(color: Colors.white),
                    focusColor: Colors.white,
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                  cursorColor: Colors.white,
                  controller: controller,
                  onChanged: (value) {
                    setState(() {
                      qrString = controller.text;
                    });
                  },
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromRGBO(146, 224, 0, 1),
                ),
                onPressed: (controller.text.isEmpty || qrString.isEmpty)
                    ? null
                    : _saveQrCodeInfo,
                child: const Text('Save QR'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
