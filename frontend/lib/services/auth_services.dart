import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final String baseUrl = 'http://192.168.0.114:3000'; // your Node.js server IP

  Future<bool> signup(String username, String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/signup'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'username': username,
          'email': email,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        print("Signup success");
        return true;
      } else {
        print("Signup failed: ${response.body}");
        return false;
      }
    } catch (e) {
      print("Signup error: $e");
      return false;
    }
  }

  Future<bool> login(String username, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'username': username,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);

        final token = responseBody['token'];
        final user = responseBody['user'];
        final userId = user['_id']; // 👈 this is from MongoDB

        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('jwtToken', token);
        await prefs.setString('userId', userId);

        print('Login success - User ID saved: $userId');
        return true;
      } else {
        print("Login failed: ${response.body}");
        return false;
      }
    } catch (e) {
      print("Login error: $e");
      return false;
    }
  }
}
