import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models.dart/qr_info_provider.dart';
import '/widgets/show_snackbar.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrGeneratorScreen extends StatefulWidget {
  const QrGeneratorScreen({super.key});

  @override
  State<QrGeneratorScreen> createState() => _QrGeneratorScreenState();
}

class _QrGeneratorScreenState extends State<QrGeneratorScreen> {
  final controller = TextEditingController();
  String qrString = '';

  void _saveQrCodeInfo() {
    if (qrString.isEmpty) {
      return;
    }
    Provider.of<GeneratedQrInfo>(context, listen: false).saveQRInfo(
      id: DateTime.now().toString(),
      info: qrString,
      dateTime: DateTime.now(),
    );
    ShowSnackBar(context: context, label: 'QR Info saved successfully').show();
    setState(() {
      controller.text = '';
      qrString = '';
    });
    FocusScope.of(context).unfocus();
  }

  bool isTextEmpty = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(52, 58, 64, 0),
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
                  maxLines: 5,
                  cursorColor: Colors.white,
                  controller: controller,
                  autocorrect: false,
                  textInputAction: TextInputAction.newline,
                  onTapOutside: (event) => FocusScope.of(context).unfocus(),
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
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                  onChanged: (value) {
                    setState(() {
                      qrString = controller.text;
                      isTextEmpty = value.trim().isEmpty;
                    });
                  },
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromRGBO(146, 224, 0, 1),
                ),
                onPressed: isTextEmpty ? null : _saveQrCodeInfo,
                child: const Text('Save QR'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
