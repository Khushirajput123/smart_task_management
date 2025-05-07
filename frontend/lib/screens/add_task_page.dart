//fromto create task
// import 'package:flutter/material.dart';
// import '../models/task_model.dart';
// import '../services/task_service.dart';
// import '../utils/user_prefs.dart';

// class AddTaskPage extends StatefulWidget {
//   final String category;

//   const AddTaskPage({super.key, required this.category});

//   @override
//   State<AddTaskPage> createState() => _AddTaskPageState();
// }

// class _AddTaskPageState extends State<AddTaskPage> {
//   final _formKey = GlobalKey<FormState>();
//   final TextEditingController _titleController = TextEditingController();
//   final TextEditingController _descriptionController = TextEditingController();
//   DateTime? _dueDate;
//   DateTime? _reminderTime;
//   String _priority = 'medium';

//   // Future<void> _submitTask() async {
//   //   if (!_formKey.currentState!.validate()) {
//   //     print("Form validation failed");
//   //     return;
//   //   }

//   //   final userId = await UserPrefs.getUserId();

//   //   if (userId == null) {
//   //     ScaffoldMessenger.of(context).showSnackBar(
//   //       const SnackBar(content: Text("User not logged in")),
//   //     );
//   //     return;
//   //   }

//   //   final task = Task(
//   //     title: _titleController.text,
//   //     description: _descriptionController.text,
//   //     priority: _priority,
//   //     category: widget.category,
//   //     userId: userId,
//   //     isQuickTask: false,
//   //     dueDate: _dueDate,
//   //     reminderTime: _reminderTime,
//   //   );

//   //   final success = await TaskService().createTask(task);
//   //   //   if (success && context.mounted) {
//   //   //     Navigator.pop(context, true);
//   //   //   }
//   //   // }
//   //   if (!success) {
//   //     ScaffoldMessenger.of(context).showSnackBar(
//   //       const SnackBar(content: Text('Failed to create task')),
//   //     );
//   //   } else if (context.mounted) {
//   //     Navigator.pop(context, true);
//   //   }
//   // }

//   // Future<void> _submitTask() async {
//   //   if (!_formKey.currentState!.validate()) {
//   //     print("Form validation failed");
//   //     return;
//   //   }

//   //   final userId = await UserPrefs.getUserId();

//   //   if (userId == null) {
//   //     ScaffoldMessenger.of(context).showSnackBar(
//   //       const SnackBar(content: Text("User not logged in")),
//   //     );
//   //     return;
//   //   }

//   //   final task = Task(
//   //     title: _titleController.text,
//   //     description: _descriptionController.text,
//   //     priority: _priority,
//   //     category: widget.category,
//   //     userId: userId,
//   //     isQuickTask: false,
//   //     dueDate: _dueDate,
//   //     reminderTime: _reminderTime,
//   //   );
//   //   print("User ID: $userId");
//   //   print("Task JSON: ${task.toJson()}");

//   //   //  print("Creating task with: ${task.toJson()}");

//   //   final success = await TaskService().createTask(task);

//   //   if (!success) {
//   //     ScaffoldMessenger.of(context).showSnackBar(
//   //       const SnackBar(content: Text('Failed to create task')),
//   //     );
//   //   } else if (context.mounted) {
//   //     Navigator.pop(context, true);
//   //   }
//   // }

//   Future<void> _submitTask() async {
//     if (!_formKey.currentState!.validate()) {
//       print("Form validation failed");
//       return;
//     }

//     final userId = await UserPrefs.getUserId();

//     if (userId == null) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text("User not logged in")),
//       );
//       return;
//     }

//     final task = Task(
//       title: _titleController.text,
//       description: _descriptionController.text,
//       priority: _priority,
//       category: widget.category,
//       userId: userId,
//       isQuickTask: false,
//       dueDate: _dueDate,
//       reminderTime: _reminderTime,
//     );

//     print("User ID: $userId");
//     print("Task JSON: ${task.toJson()}");

//     final success = await TaskService().createTask(task);

//     if (!success) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Failed to create task')),
//       );
//     } else if (context.mounted) {
//       // ✅ NEW: Return the created task back to TaskPage
//       Navigator.pop(context, {
//         'title': task.title,
//         'isCompleted': false,
//         'category': task.category,
//       });
//     }
//   }

//   Future<void> _pickDate(BuildContext context, bool isDue) async {
//     final picked = await showDatePicker(
//       context: context,
//       initialDate: DateTime.now(),
//       firstDate: DateTime.now().subtract(const Duration(days: 1)),
//       lastDate: DateTime(2100),
//     );

//     if (picked != null) {
//       final time = await showTimePicker(
//         context: context,
//         initialTime: const TimeOfDay(hour: 12, minute: 0),
//       );

//       if (time != null) {
//         final dateTime = DateTime(
//           picked.year,
//           picked.month,
//           picked.day,
//           time.hour,
//           time.minute,
//         );
//         setState(() {
//           if (isDue) {
//             _dueDate = dateTime;
//           } else {
//             _reminderTime = dateTime;
//           }
//         });
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Add Task')),
//       body: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Form(
//           key: _formKey,
//           child: ListView(
//             children: [
//               TextFormField(
//                 controller: _titleController,
//                 decoration: const InputDecoration(labelText: 'Title'),
//                 validator: (val) =>
//                     val == null || val.isEmpty ? 'Title cannot be empty' : null,
//               ),
//               TextFormField(
//                 controller: _descriptionController,
//                 decoration: const InputDecoration(labelText: 'Description'),
//                 maxLines: 3,
//               ),
//               const SizedBox(height: 16),
//               Row(
//                 children: [
//                   const Text('Priority:'),
//                   const SizedBox(width: 12),
//                   DropdownButton<String>(
//                     value: _priority,
//                     items: ['low', 'medium', 'high'].map((value) {
//                       return DropdownMenuItem<String>(
//                           value: value, child: Text(value));
//                     }).toList(),
//                     onChanged: (val) {
//                       if (val != null) setState(() => _priority = val);
//                     },
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 16),
//               Row(
//                 children: [
//                   const Text("Due Date: "),
//                   TextButton(
//                     onPressed: () => _pickDate(context, true),
//                     child:
//                         Text(_dueDate != null ? _dueDate.toString() : 'Select'),
//                   ),
//                 ],
//               ),
//               Row(
//                 children: [
//                   const Text("Reminder: "),
//                   TextButton(
//                     onPressed: () => _pickDate(context, false),
//                     child: Text(_reminderTime != null
//                         ? _reminderTime.toString()
//                         : 'Select'),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 24),
//               ElevatedButton.icon(
//                 onPressed: _submitTask,
//                 icon: const Icon(Icons.check),
//                 label: const Text("Create Task"),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import '../models/task_model.dart';
import '../services/task_service.dart';
import '../utils/user_prefs.dart';

class AddTaskPage extends StatefulWidget {
  final String category;

  const AddTaskPage({super.key, required this.category});

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  DateTime? _dueDate;
  DateTime? _reminderTime;
  String _priority = 'medium';

  // ✅ MODIFIED: This version returns task map back to TaskPage
  Future<void> _submitTask() async {
    if (!_formKey.currentState!.validate()) {
      print("Form validation failed");
      return;
    }

    final userId = await UserPrefs.getUserId();

    if (userId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("User not logged in")),
      );
      return;
    }

    final task = Task(
      title: _titleController.text,
      description: _descriptionController.text,
      priority: _priority,
      category: widget.category,

      userId: userId,
      isCompleted: false, // ✅ ADDED: Matches model default
      isQuickTask: false,
      dueDate: _dueDate,
      completedAt: null, // ✅ ADDED: Initialize explicitly
      reminderTime: _reminderTime,
    );

    print("User ID: $userId");
    print("Task JSON: ${task.toJson()}");

    final success = await TaskService().createTask(task);

    if (!success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to create task')),
      );
    } else if (context.mounted) {
      // ✅ MODIFIED: Return task data as a map so TaskPage can add it to UI
      Navigator.pop(context, {
        'title': task.title,
        'isCompleted': false,
        'category': task.category,
      });
    }
  }

  // 🆕 Helper to pick date and time (for due or reminder)
  Future<void> _pickDate(BuildContext context, bool isDue) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now().subtract(const Duration(days: 1)),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      final time = await showTimePicker(
        context: context,
        initialTime: const TimeOfDay(hour: 12, minute: 0),
      );

      if (time != null) {
        final dateTime = DateTime(
          picked.year,
          picked.month,
          picked.day,
          time.hour,
          time.minute,
        );
        setState(() {
          if (isDue) {
            _dueDate = dateTime;
          } else {
            _reminderTime = dateTime;
          }
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Task')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'Title'),
                validator: (val) =>
                    val == null || val.isEmpty ? 'Title cannot be empty' : null,
              ),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(labelText: 'Description'),
                maxLines: 3,
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  const Text('Priority:'),
                  const SizedBox(width: 12),
                  DropdownButton<String>(
                    value: _priority,
                    items: ['low', 'medium', 'high'].map((value) {
                      return DropdownMenuItem<String>(
                          value: value, child: Text(value));
                    }).toList(),
                    onChanged: (val) {
                      if (val != null) setState(() => _priority = val);
                    },
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  const Text("Due Date: "),
                  TextButton(
                    onPressed: () => _pickDate(context, true),
                    child:
                        Text(_dueDate != null ? _dueDate.toString() : 'Select'),
                  ),
                ],
              ),
              Row(
                children: [
                  const Text("Reminder: "),
                  TextButton(
                    onPressed: () => _pickDate(context, false),
                    child: Text(_reminderTime != null
                        ? _reminderTime.toString()
                        : 'Select'),
                  ),
                ],
              ),
              const SizedBox(height: 24),
//               ElevatedButton.icon(
//                 onPressed: _submitTask,
//                 icon: const Icon(Icons.check),
//                 label: const Text("Create Task"),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
              ElevatedButton(
                onPressed: () async {
                  // Create the new task
                  final userId =
                      await UserPrefs.getUserId(); // Fetch the userId
                  if (userId == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("User not logged in")),
                    );
                    return;
                  }

                  final newTask = Task(
                    title: _titleController.text,
                    description: _descriptionController.text,
                    category: widget.category,
                    priority: _priority, // If you have priority handling
                    dueDate: _dueDate, // If you have a due date
                    reminderTime: _reminderTime, // If you have a reminder
                    isCompleted: false,
                    userId: userId, // Add the required userId
                    isQuickTask: false, // Add the required isQuickTask
                  );

                  // Return the task back to the previous screen
                  Navigator.pop(context, newTask);
                },
                child: Text('Save Task'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
