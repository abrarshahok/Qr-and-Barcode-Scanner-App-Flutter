import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'qr_info_model.dart';

class GeneratedQrInfo with ChangeNotifier {
  final List<QrInfoItem> _infoList = [];

  List<QrInfoItem> get infoList {
    return [..._infoList];
  }

  Future<void> saveGenQRInfo({
    required String id,
    required String info,
    required DateTime dateTime,
  }) async {
    final prefs = await SharedPreferences.getInstance();

    final generatedQrData = json.encode({
      'qrString': info,
      'dateTime': dateTime.toIso8601String(),
    });
    _infoList.insert(
      0,
      QrInfoItem(
        id: id,
        info: info,
        dateTime: dateTime,
      ),
    );
    prefs.setString(id, generatedQrData);
    notifyListeners();
  }

  Future<void> getGenQRInfo() async {
    final prefs = await SharedPreferences.getInstance();
    _infoList.clear();
    prefs.getKeys().forEach((id) {
      final extractedData = prefs.getString(id);
      if (extractedData != null) {
        final decodedData = json.decode(extractedData) as Map<String, dynamic>;
        final infoString = decodedData['qrString'] as String;
        final dateTimeString = decodedData['dateTime'] as String;
        final dateTime = DateTime.parse(dateTimeString);
        _infoList.insert(
          0,
          QrInfoItem(
            id: id,
            info: infoString,
            dateTime: dateTime,
          ),
        );
      }
    });
    notifyListeners();
  }

  Future<void> deleteQRInfo(String id) async {
    final prefs = await SharedPreferences.getInstance();
    final key = prefs.getKeys().firstWhere((id) => id == id);
    if (key.isEmpty) {
      return;
    }
    prefs.remove(key);
    _infoList.removeWhere((element) => element.id == id);
    notifyListeners();
  }
}
