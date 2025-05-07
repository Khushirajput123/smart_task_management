// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import '../models/task_model.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class TaskService {
//   final String baseUrl = 'http://192.168.0.118:3000'; // Your backend IP

//   // Fetch JWT token from shared preferences
//   Future<String?> getToken() async {
//     final prefs = await SharedPreferences.getInstance();
//     return prefs.getString('jwt_token');
//   }

//   // Create a new task
//   // Future<bool> createTask(Task task) async {
//   //   try {
//   //     final token = await getToken();
//   //     if (token == null) return false;

//   //     final response = await http.post(
//   //       Uri.parse('$baseUrl/tasks'),
//   //       headers: {
//   //         'Content-Type': 'application/json',
//   //         'Authorization': 'Bearer $token',
//   //       },
//   //       body: jsonEncode(task.toJson()),
//   //     );

//   //     return response.statusCode == 201 || response.statusCode == 200;
//   //   } catch (e) {
//   //     print("Error creating task: $e");
//   //     return false;
//   //   }
//   // }

//   Future<bool> createTask(Task task) async {
//     try {
//       final token = await getToken();
//       if (token == null) {
//         print("No JWT token found");
//         return false;
//       }
// print("JWT Token: $token");
// print("Task JSON: ${task.toJson()}");
// print("Response Status: ${response.statusCode}");
// print("Response Body: ${response.body}");

//       final response = await http.post(
//         Uri.parse('$baseUrl/tasks'),
//         headers: {
//           'Content-Type': 'application/json',
//           'Authorization': 'Bearer $token',
//         },
//         body: jsonEncode(task.toJson()),
//       );

//       print("Response Status: ${response.statusCode}"); // Log response status
//       print("Response Body: ${response.body}"); // Log response body

//       return response.statusCode == 201 || response.statusCode == 200;
//     } catch (e) {
//       print("Error creating task: $e");
//       return false;
//     }
//   }

//   // Update an existing task
//   Future<bool> updateTask(Task task) async {
//     try {
//       final token = await getToken();
//       if (token == null) return false;

//       final Map<String, dynamic> taskJson =
//           Map<String, dynamic>.from(task.toJson());
//       taskJson.remove('_id'); // in case _id exists

//       final response = await http.put(
//         Uri.parse('$baseUrl/tasks/${task.id}'),
//         headers: {
//           'Content-Type': 'application/json',
//           'Authorization': 'Bearer $token',
//         },
//         body: jsonEncode(taskJson),
//       );

//       return response.statusCode == 200;
//     } catch (e) {
//       print("Error updating task: $e");
//       return false;
//     }
//   }

//   // ✅ Get tasks by category
//   Future<List<Task>> getTasksByCategory(String category) async {
//     try {
//       final token = await getToken();
//       if (token == null) return [];

//       final response = await http.get(
//         Uri.parse('$baseUrl/tasks/category/$category'),
//         headers: {
//           'Authorization': 'Bearer $token',
//         },
//       );

//       if (response.statusCode == 200) {
//         final List data = jsonDecode(response.body);
//         return data.map((json) => Task.fromJson(json)).toList();
//       } else {
//         print("Failed to fetch tasks: ${response.body}");
//         return [];
//       }
//     } catch (e) {
//       print("Error fetching tasks: $e");
//       return [];
//     }
//   }
// }

import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/task_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TaskService {
  final String baseUrl = 'http://192.168.0.114:3000'; // Your backend IP

  // Fetch JWT token from shared preferences
  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('jwtToken');
  }

  // ✅ UPDATED createTask method with proper debug logs
  // Future<bool> createTask(Task task) async {
  //   try {
  //     final token = await getToken();
  //     if (token == null) {
  //       print("No JWT token found");
  //       return false;
  //     }

  //     // ✅ Log token and task data before request
  //     print("JWT Token: $token");
  //     print("Task JSON: ${task.toJson()}");

  //     final response = await http.post(
  //       Uri.parse('$baseUrl/tasks'),
  //       headers: {
  //         'Content-Type': 'application/json',
  //         'Authorization': 'Bearer $token',
  //       },
  //       body: jsonEncode(task.toJson()),
  //     );

  //     // ✅ Log response after request
  //     print("Response Status: ${response.statusCode}");
  //     print("Response Body: ${response.body}");

  //     return response.statusCode == 201 || response.statusCode == 200;
  //   } catch (e) {
  //     print("Error creating task: $e");
  //     return false;
  //   }
  // }

  Future<bool> createTask(Task task) async {
    print("createTask() method called"); // ✅ Add this

    try {
      final token = await getToken();
      print("Fetched token: $token"); // ✅ Log even if null

      if (token == null) {
        print("No JWT token found in SharedPreferences");
        return false;
      }

      print("JWT Token: $token");
      print("Task JSON: ${task.toJson()}");

      final response = await http.post(
        Uri.parse('$baseUrl/tasks'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(task.toJson()),
      );

      print("Response Status: ${response.statusCode}");
      print("Response Body: ${response.body}");

      return response.statusCode == 201 || response.statusCode == 200;
    } catch (e) {
      print("Exception caught in createTask(): $e");
      return false;
    }
  }

  // Update an existing task
  Future<bool> updateTask(Task task) async {
    try {
      final token = await getToken();
      if (token == null) return false;

      final Map<String, dynamic> taskJson =
          Map<String, dynamic>.from(task.toJson());
      taskJson.remove('_id'); // Remove _id if present

      final response = await http.put(
        Uri.parse('$baseUrl/tasks/${task.id}'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(taskJson),
      );

      return response.statusCode == 200;
    } catch (e) {
      print("Error updating task: $e");
      return false;
    }
  }

  // Get tasks by category
  Future<List<Task>> getTasksByCategory(String category) async {
    try {
      final token = await getToken();
      if (token == null) return [];

      final response = await http.get(
        Uri.parse('$baseUrl/tasks/category/$category'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final List data = jsonDecode(response.body);
        return data.map((json) => Task.fromJson(json)).toList();
      } else {
        print("Failed to fetch tasks: ${response.body}");
        return [];
      }
    } catch (e) {
      print("Error fetching tasks: $e");
      return [];
    }
  }
}
