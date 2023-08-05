import 'package:flutter/material.dart';
import 'qr_generator_screen.dart';
import 'qr_history_screen.dart';
import 'qr_scanner_screen.dart';

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
        'page': const QrGeneratorScreen(),
      },
      {
        'title': 'Scan QR',
        'page': ScannerScreen(),
      },
      {
        'title': 'History',
        'page': const QrHistoryScreen(),
      },
    ];
    super.initState();
  }

  int _currentIndex = 1;
  void _changePageIndex(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _currentIndex == 2
          ? null
          : AppBar(
              title: Text(
                _pages[_currentIndex]['title'] as String,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              backgroundColor: const Color.fromRGBO(52, 58, 64, 1),
              elevation: 5,
              centerTitle: true,
            ),
      backgroundColor: const Color.fromRGBO(52, 58, 64, 0.9),
      body: _pages[_currentIndex]['page'] as Widget,
      bottomNavigationBar: Card(
        elevation: 20,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        margin: const EdgeInsets.all(30),
        shadowColor: Colors.black,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: BottomNavigationBar(
            onTap: _changePageIndex,
            currentIndex: _currentIndex,
            selectedItemColor: Colors.white,
            iconSize: 50,
            unselectedItemColor: Colors.grey,
            backgroundColor: const Color.fromRGBO(52, 58, 64, 0.9),
            selectedFontSize: 15,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.qr_code_rounded,
                  size: 30,
                ),
                label: 'Generate',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.qr_code_scanner,
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
