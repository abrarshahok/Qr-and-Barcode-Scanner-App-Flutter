import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'widgets/scan_result.dart';
import 'widgets/scanner_camera.dart';
import 'providers/qr_info_provider.dart';
import 'screens/app_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Color.fromRGBO(52, 58, 64, 1),
    statusBarIconBrightness: Brightness.light,
    systemNavigationBarColor: Color.fromRGBO(52, 58, 64, 1),
    systemNavigationBarIconBrightness: Brightness.light,
  ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => QrInfo(),
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
          ScanResult.routeName: (context) => ScanResult(),
          ScannerCamera.routeName: (context) => const ScannerCamera(),
        },
      ),
    );
  }
}
