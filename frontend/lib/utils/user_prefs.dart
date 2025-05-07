// import 'package:shared_preferences/shared_preferences.dart';

// class UserPrefs {
//   static Future<void> saveUserId(String userId) async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setString('userId', userId);
//   }

//   static Future<String?> getUserId() async {
//     final prefs = await SharedPreferences.getInstance();
//     return prefs.getString('userId');
//   }

//   static Future<void> clearUserId() async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.remove('userId');
//   }
// }

// import 'package:shared_preferences/shared_preferences.dart';

// class UserPrefs {
//   static Future<void> saveUserId(String userId) async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setString('userId', userId);
//   }

//   static Future<String?> getUserId() async {
//     final prefs = await SharedPreferences.getInstance();
//     return prefs.getString('userId');
//   }

//   static Future<void> clearUserId() async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.remove('userId');
//   }
// }

// import 'package:shared_preferences/shared_preferences.dart';

// class UserPrefs {
//   static Future<String?> getUserId() async {
//     final prefs = await SharedPreferences.getInstance();
//     return prefs.getString('userId');
//   }

//   static Future<void> clearPrefs() async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.clear(); // for logout
//   }
// }

// // Save JWT token after login
// Future<void> saveToken(String token) async {
//   final prefs = await SharedPreferences.getInstance();
//   prefs.setString('jwt_token', token);
// }

// // Retrieve JWT token
// Future<String?> getToken() async {
//   final prefs = await SharedPreferences.getInstance();
//   return prefs.getString('jwt_token');
// }

import 'package:shared_preferences/shared_preferences.dart';

class UserPrefs {
  static Future<String?> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('userId');
  }

  static Future<void> clearPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear(); // for logout
  }

  // Debug: Print saved token
  static Future<void> debugPrintToken() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('jwt_token');
    print("🔑 DEBUG JWT TOKEN: $token"); // Print token for debugging
  }
}

// Save JWT token after login
Future<void> saveToken(String token) async {
  final prefs = await SharedPreferences.getInstance();
  prefs.setString('jwt_token', token);
  print("🔑 Token saved successfully: $token"); // Debug: Token saved
}

// Retrieve JWT token
Future<String?> getToken() async {
  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('jwt_token');
  print("🔑 Retrieved Token: $token"); // Debug: Token retrieved
  return token;
}
