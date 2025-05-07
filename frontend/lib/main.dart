import 'package:flutter/material.dart';
import 'screens/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized(); // Needed before async code
  debugPrintToken(); // 🔍 Call to print token at startup
  runApp(SmartTaskApp());
}

// 🔧 DEBUG FUNCTION: Print JWT token saved in SharedPreferences
void debugPrintToken() async {
  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('jwt_token');
  print("🔑 DEBUG JWT TOKEN: $token");
}

class SmartTaskApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smart Task Management',
      theme: ThemeData(
        fontFamily: 'Roboto',
        scaffoldBackgroundColor: Color(0xFFFCF2DE),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
