import 'package:flutter/material.dart';
import 'package:qr_and_barcode_scanner/screens/generated_qr_screen.dart';

class HistoryScreen extends StatelessWidget {
  static const routeName = '/scanner-screen';
  const HistoryScreen({super.key});

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
                  icon: Icon(Icons.qr_code_scanner),
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
                Text('Scanned QR'),
              ],
            ),
          )
        ],
      ),
    );
  }
}
