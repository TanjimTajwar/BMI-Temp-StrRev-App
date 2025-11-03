import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'home.dart';
import 'theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const TrioAngleApp());
}

class TrioAngleApp extends StatelessWidget {
  const TrioAngleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Trio-Angle',
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.system,
      home: const HomePage(),
    );
  }
}

