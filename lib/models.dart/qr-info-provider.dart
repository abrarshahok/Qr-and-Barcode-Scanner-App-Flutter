import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class QrInfo with ChangeNotifier {
  Future<void> saveInfo(String qrString) async {
    final prefs = await SharedPreferences.getInstance();
    final generatedQrData = json.encode({'qrString': qrString});
    prefs.setString('GeneratedQrData', generatedQrData);
  }

  Future<Map<String, dynamic>> getInfo() async {
    final prefs = await SharedPreferences.getInstance();

    final prefsData = json.decode(prefs.getString('GeneratedQrData')!)
        as Map<String, dynamic>;
    return prefsData;
  }
}
