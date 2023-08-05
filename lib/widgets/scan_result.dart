import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '/widgets/show_snackbar.dart';
import 'package:qr_flutter/qr_flutter.dart';

class ScanResult extends StatelessWidget {
  static const routeName = '/scan-result';

  const ScanResult({super.key});
  @override
  Widget build(BuildContext context) {
    final result = ModalRoute.of(context)?.settings.arguments as String;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Result'),
        centerTitle: true,
        backgroundColor: const Color.fromRGBO(52, 58, 64, 1),
      ),
      backgroundColor: const Color.fromRGBO(52, 58, 64, 0.9),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            QrImageView(
              data: result,
              size: 200,
              backgroundColor: Colors.white,
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 200,
              width: MediaQuery.of(context).size.width * 0.98,
              child: Card(
                color: const Color.fromRGBO(52, 58, 64, 1),
                elevation: 10,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView(
                    children: [
                      Text(
                        result,
                        style: const TextStyle(
                          fontSize: 15,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Clipboard.setData(ClipboardData(text: result));
                ShowSnackBar(
                  context: context,
                  label: 'Content saved to clipboard successfully',
                ).show();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromRGBO(146, 224, 0, 1),
                elevation: 10,
              ),
              child: const Text('Copy to Clipboard'),
            ),
          ],
        ),
      ),
    );
  }
}
