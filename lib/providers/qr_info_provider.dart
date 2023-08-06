import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'qr_info.dart';

class QrInfo with ChangeNotifier {
  final List<QrInfoItem> _genQrInfoList = [];
  final List<QrInfoItem> _scannedQrInfoList = [];

  List<QrInfoItem> get genQrInfoList {
    return [..._genQrInfoList];
  }

  List<QrInfoItem> get scannedQrInfoList {
    return [..._scannedQrInfoList];
  }

  Future<void> saveQRInfo({
    required String id,
    required String info,
    required DateTime dateTime,
    bool isScan = false,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final String scan = isScan ? 'scan' : '';
    final generatedQrData = json.encode({
      'qrString': info,
      'dateTime': dateTime.toIso8601String(),
    });

    final qrInfoItem = QrInfoItem(
      id: id,
      info: info,
      dateTime: dateTime,
    );

    if (isScan) {
      _scannedQrInfoList.insert(0, qrInfoItem);
    } else {
      _genQrInfoList.insert(0, qrInfoItem);
    }
    prefs.setString('$scan$id', generatedQrData);
    notifyListeners();
  }

  Future<void> getQRInfo() async {
    final prefs = await SharedPreferences.getInstance();
    _genQrInfoList.clear();
    _scannedQrInfoList.clear();
    prefs.getKeys().forEach((id) {
      final extractedData = prefs.getString(id);
      if (extractedData != null) {
        final decodedData = json.decode(extractedData) as Map<String, dynamic>;
        final infoString = decodedData['qrString'] as String;
        final dateTimeString = decodedData['dateTime'] as String;
        final dateTime = DateTime.parse(dateTimeString);

        final qrInfoItem = QrInfoItem(
          id: id,
          info: infoString,
          dateTime: dateTime,
        );

        if (id.startsWith('scan')) {
          _scannedQrInfoList.insert(0, qrInfoItem);
        } else {
          _genQrInfoList.insert(0, qrInfoItem);
        }
      }
    });
    notifyListeners();
  }

  Future<void> deleteQRInfo(String id) async {
    final prefs = await SharedPreferences.getInstance();
    final key = prefs.getKeys().firstWhere((keyId) => keyId == id);
    if (key.isEmpty) {
      return;
    }
    prefs.remove(key);
    if (id.startsWith('scan')) {
      _scannedQrInfoList.removeWhere((element) => element.id == id);
    } else {
      _genQrInfoList.removeWhere((element) => element.id == id);
    }
    notifyListeners();
  }
}
