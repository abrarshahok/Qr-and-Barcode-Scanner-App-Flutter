import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '/models.dart/qr_info_provider.dart';
import '/widgets/show_snackbar.dart';
import '/widgets/scan_result.dart';
import 'package:scan/scan.dart';
import '../widgets/scanner_camera.dart';

class ScannerScreen extends StatelessWidget {
  File? image;
  String? decodedString;
  Future<void> pickImage(BuildContext context) async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      image = File(pickedFile.path);
    }
    decodedString = await Scan.parse(image!.path);
  }

  @override
  Widget build(BuildContext context) {
    void saveAndShowInfo() {
      Navigator.of(context).pushNamed(
        ScanResult.routeName,
        arguments: decodedString,
      );
      ShowSnackBar(
        context: context,
        label: 'Scan Success',
        color: const Color.fromRGBO(146, 224, 0, 1),
      ).show();
      Provider.of<QrInfo>(context, listen: false).saveQRInfo(
        id: DateTime.now().toString(),
        info: decodedString as String,
        dateTime: DateTime.now(),
        isScan: true,
      );
    }

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            iconSize: 100,
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
          const SizedBox(height: 50),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromRGBO(146, 224, 0, 1),
            ),
            onPressed: () async {
              await pickImage(context).whenComplete(() {
                bool isEmpty = decodedString == null ? true : false;
                if (isEmpty) {
                  ShowSnackBar(
                    context: context,
                    label: 'Invalid QR Code!',
                    color: Colors.red,
                  ).show();
                  return;
                }
                saveAndShowInfo();
              });
            },
            child: const Text(
              'Import QR',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
