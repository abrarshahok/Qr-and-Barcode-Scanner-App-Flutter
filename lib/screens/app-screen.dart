import 'package:flutter/material.dart';
import '/screens/qr-generator-screen.dart';
import '/screens/history-screen.dart';
import '/screens/scanner-screen.dart';

class AppScreen extends StatefulWidget {
  const AppScreen({Key? key}) : super(key: key);

  @override
  State<AppScreen> createState() => _AppScreenState();
}

class _AppScreenState extends State<AppScreen> {
  List<Map<String, Object>> _pages = [];
  @override
  void initState() {
    _pages = [
      {
        'title': 'Generate QR',
        'page': QrGeneratorScreen(),
      },
      {
        'title': 'Scan QR',
        'page': ScannerScreen(),
      },
      {
        'title': 'History',
        'page': const HistoryScreen(),
      },
    ];
    super.initState();
  }

  int _currentIndex = 0;
  void _changePageIndex(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _pages[_currentIndex]['title'] as String,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        backgroundColor: const Color.fromRGBO(52, 58, 64, 1),
        elevation: 5,
        centerTitle: true,
      ),
      backgroundColor: const Color.fromRGBO(52, 58, 64, 1),
      body: _pages[_currentIndex]['page'] as Widget,
      bottomNavigationBar: Card(
        elevation: 20,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        margin: const EdgeInsets.all(30),
        shadowColor: Colors.black,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: BottomNavigationBar(
            onTap: _changePageIndex,
            currentIndex: _currentIndex,
            selectedItemColor: Colors.white,
            iconSize: 50,
            unselectedItemColor: Colors.grey,
            backgroundColor: const Color.fromRGBO(52, 58, 64, 1),
            items: const [
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.qr_code,
                  size: 30,
                ),
                label: 'Generate',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.qr_code,
                  color: Color.fromRGBO(146, 224, 0, 1),
                ),
                label: 'Scan',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.history,
                  size: 30,
                ),
                label: 'History',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
