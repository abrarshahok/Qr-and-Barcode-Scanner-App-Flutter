import 'package:flutter/material.dart';
import '/screens/scanned_qr_screen.dart';
import '/screens/generated_qr_screen.dart';

class QrHistoryScreen extends StatelessWidget {
  static const routeName = '/scanner-screen';
  const QrHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const DefaultTabController(
      length: 2,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(10),
            child: TabBar(
              indicatorColor: Colors.white,
              unselectedLabelColor: Colors.grey,
              tabs: [
                Tab(
                  icon: Icon(Icons.qr_code_rounded),
                  text: 'Generated QR',
                ),
                Tab(
                  icon: Icon(Icons.qr_code_scanner),
                  text: 'Scanned QR',
                ),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              children: [
                GeneratedQrScreen(),
                ScannedQrScreen(),
              ],
            ),
          )
        ],
      ),
    );
  }
}
