import '/widgets/show_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:screenshot/screenshot.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';

class ScanResult extends StatelessWidget {
  static const routeName = '/scan-result';

  void _copyToClipboard(BuildContext context, String result) {
    Clipboard.setData(
      ClipboardData(text: result),
    );
    ShowSnackBar(
      context: context,
      label: 'Content saved to clipboard successfully',
    ).show();
  }

  final ScreenshotController _screenShotController = ScreenshotController();
  void _saveImageToGallery(BuildContext context) {
    _screenShotController.capture().then((image) {
      ImageGallerySaver.saveImage(image!);
      ShowSnackBar(
        context: context,
        label: 'Image successfully saved to Gallery',
      ).show();
    }).catchError((_) {
      ShowSnackBar(context: context, label: 'An error occured!').show();
    });
  }

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
            Screenshot(
              controller: _screenShotController,
              child: QrImageView(
                data: result,
                size: 200,
                backgroundColor: Colors.white,
              ),
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
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  onPressed: () => _copyToClipboard(context, result),
                  color: const Color.fromRGBO(146, 224, 0, 1),
                  iconSize: 40,
                  icon: const Icon(Icons.copy),
                ),
                IconButton(
                  onPressed: () => _saveImageToGallery(context),
                  color: const Color.fromRGBO(146, 224, 0, 1),
                  iconSize: 40,
                  icon: const Icon(Icons.download),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
