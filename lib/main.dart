import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final preferences = await SharedPreferences.getInstance();
  final isDarkMode = preferences.getBool('isDarkMode') ?? true;
  runApp(MyApp(initialIsDarkMode: isDarkMode));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key, required this.initialIsDarkMode});

  final bool initialIsDarkMode;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final ValueNotifier<bool> _isDarkMode;

  @override
  void initState() {
    super.initState();
    _isDarkMode = ValueNotifier(widget.initialIsDarkMode);
  }

  @override
  void dispose() {
    _isDarkMode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Clone X',
      theme: ThemeData(
        brightness: Brightness.dark,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.dark,
        ),
        scaffoldBackgroundColor: Colors.black,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
        ),
        textTheme: const TextTheme(bodyMedium: TextStyle(fontSize: 16)),
      ),
      home: LoginPage(isDarkMode: _isDarkMode),
    );
  }
}