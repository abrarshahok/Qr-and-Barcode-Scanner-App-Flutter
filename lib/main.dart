import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'widgets/scan_result.dart';
import 'widgets/scanner_camera.dart';
import 'models.dart/generated-qr-info-provider.dart';
import 'screens/app_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.manual,
    overlays: [
      SystemUiOverlay.bottom,
    ],
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => GeneratedQrInfo(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'Nexa',
          colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.green),
          textTheme: const TextTheme().copyWith(
            titleLarge: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        home: const AppScreen(),
        routes: {
          ScanResult.routeName: (context) => const ScanResult(),
          ScannerCamera.routeName: (context) => const ScannerCamera(),
        },
      ),
    );
  }
}
