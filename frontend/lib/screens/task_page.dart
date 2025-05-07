// //main taskpage

// import 'package:flutter/material.dart';
// import 'package:smart_task_management/screens/add_task_page.dart';
// import '../services/task_service.dart';
// import '../models/task_model.dart';
// import 'add_task_page.dart';
// import 'taskpage_state.dart';

// class TaskPage extends StatefulWidget {
//   const TaskPage({super.key});

//   @override
//   State<TaskPage> createState() => _TaskPageState();
// }

// class _TaskPageState extends State<TaskPage> {
//   String selectedList = 'All Lists';

//   // final Map<String, List<Map<String, dynamic>>> taskLists = {
//   //   'Default': [],
//   //   'Personal': [],
//   //   'Shopping': [],
//   //   'Wishlist': [],
//   //   'Work': [],
//   //   'Finished': [],
//   // };
//     final Map<String, List<Task>> taskLists = {
//     'Default': [],
//     'Personal': [],
//     'Shopping': [],
//     'Wishlist': [],
//     'Work': [],
//     'Finished': [],
//   };

//   final TextEditingController taskController = TextEditingController();

//   // void addTask(String title) {
//   //   if (title.isEmpty) return;

//   //   final newTask = {
//   //     'title': title,
//   //     'isCompleted': false,
//   //   };

//   //   setState(() {
//   //     taskLists['Default']!.add(newTask);
//   //     taskController.clear();
//   //   });
//   // }

// void addTask(String title) {
//     if (title.isEmpty) return;

//     final newTask = Task(title: title, category: 'Default');

//     setState(() {
//       taskLists['Default']!.add(newTask);
//       taskController.clear();
//     });
//   }

//   // void completeTask(String list, int index) {
//   //   final task = taskLists[list]![index];
//   //   setState(() {
//   //     task['isCompleted'] = true;
//   //     taskLists['Finished']!.add(task);
//   //     taskLists[list]!.removeAt(index);
//   //   });
//   // }
//    void completeTask(String list, int index) {
//     final task = taskLists[list]![index];
//     setState(() {
//       task.isCompleted = true;
//       taskLists['Finished']!.add(task);
//       taskLists[list]!.removeAt(index);
//     });
//   }

//   Widget buildTaskList(String listName) {
//     final tasks = listName == 'All Lists'
//         ? taskLists.entries
//             .where((entry) => entry.key != 'Finished')
//             .expand((entry) => entry.value)
//             .toList()
//         : taskLists[listName]!;

//     if (tasks.isEmpty) {
//       return const Center(
//         child: Text("Nothing to do",
//             style: TextStyle(color: Colors.brown, fontSize: 16)),
//       );
//     }

//     return ListView.builder(
//       itemCount: tasks.length,
//       itemBuilder: (context, index) {
//         final task = tasks[index];
//         return Card(
//           color: const Color(0xFFD6C2A8), // light brown card
//           shape:
//               RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//           margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//           child: ListTile(
//             title: Text(task['title'],
//                 style: const TextStyle(color: Colors.brown)),
//             trailing: !task['isCompleted']
//                 ? IconButton(
//                     icon: const Icon(Icons.check, color: Color(0xFFE6C89F)),
//                     onPressed: () => completeTask(listName, index),
//                   )
//                 : null,
//           ),
//         );
//       },
//     );
//   }

//   Drawer buildDrawer() {
//     final lists = taskLists.keys.toList();
//     return Drawer(
//       backgroundColor: const Color(0xFFE6C89F),
//       child: ListView(
//         padding: EdgeInsets.zero,
//         children: [
//           const DrawerHeader(
//             decoration: BoxDecoration(color: Color(0xFFD6C2A8)),
//             child: Text('All Lists',
//                 style: TextStyle(color: Colors.brown, fontSize: 24)),
//           ),
//           ...lists.map((list) {
//             return ListTile(
//               leading: const Icon(Icons.list, color: Colors.brown),
//               title: Text(list, style: const TextStyle(color: Colors.brown)),
//               trailing: list == 'Finished'
//                   ? Text('${taskLists['Finished']!.length}',
//                       style: const TextStyle(color: Colors.brown))
//                   : null,
//               tileColor: selectedList == list ? const Color(0xFFFCF2DE) : null,
//               onTap: () {
//                 Navigator.pop(context);
//                 setState(() => selectedList = list);
//               },
//             );
//           }).toList(),
//           const Divider(color: Colors.brown),
//           const ListTile(
//             leading: Icon(Icons.add, color: Colors.brown),
//             title: Text("New List", style: TextStyle(color: Colors.brown)),
//           ),
//         ],
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFFCF2DE),
//       drawer: buildDrawer(),
//       //
//       appBar: AppBar(
//         title: Text(selectedList, style: const TextStyle(color: Colors.brown)),
//         backgroundColor: const Color(0xFFE6C89F),
//         iconTheme: const IconThemeData(color: Colors.brown),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.search, color: Colors.brown),
//             onPressed: () {
//               List<Map<String, dynamic>> searchTasks;

//               if (selectedList == 'All Lists') {
//                 searchTasks = taskLists.entries
//                     .where((entry) => entry.key != 'Finished')
//                     .expand((entry) => entry.value)
//                     .toList();
//               } else {
//                 searchTasks = taskLists[selectedList] ?? [];
//               }

//               showSearch(
//                 context: context,
//                 delegate: TaskSearchDelegate(searchTasks),
//               );
//             },
//           ),
//           PopupMenuButton<String>(
//             icon: const Icon(Icons.more_vert, color: Colors.brown),
//             onSelected: (value) {
//               if (value == 'Settings') {
//                 // TODO: Navigate to settings
//               } else if (value == 'Help') {
//                 // TODO: Show help
//               }
//             },
//             itemBuilder: (context) => [
//               const PopupMenuItem(value: 'Settings', child: Text('Settings')),
//               const PopupMenuItem(value: 'Help', child: Text('Help')),
//             ],
//           ),
//         ],
//       ),

//       body: buildTaskList(selectedList),
//       // bottomNavigationBar: GestureDetector(
//       //   onTap: () {
//       //     Navigator.push(
//       //       context,
//       //       MaterialPageRoute(
//       //         builder: (_) => AddTaskPage(category: selectedList),
//       //       ),
//       //     );
//       bottomNavigationBar: GestureDetector(
//         onTap: () async {
//           final newTask = await Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (_) => AddTaskPage(category: selectedList),
//             ),
//           );
//           if (newTask != null && newTask is Map<String, dynamic>) {
//             setState(() {
//               final category = newTask['category'] ?? 'Default';
//               taskLists[category]?.add(newTask);
//             });
//           }
//           //     // Navigate to the AddTaskPage
//         },
//         child: Container(
//           height: 60,
//           color: const Color(0xFFD6C2A8), // Light brown background
//           padding: const EdgeInsets.all(16),
//           child: const Center(
//             child: Text(
//               "Add Task +",
//               style: TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.brown,
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import '../models/task_model.dart';
// import 'add_task_page.dart';
// import 'taskpage_state.dart';

// class TaskPage extends StatefulWidget {
//   const TaskPage({super.key});

//   @override
//   State<TaskPage> createState() => _TaskPageState();
// }

// class _TaskPageState extends State<TaskPage> {
//   String selectedList = 'All Lists';

//   final Map<String, List<Task>> taskLists = {
//     'Default': [],
//     'Personal': [],
//     'Shopping': [],
//     'Wishlist': [],
//     'Work': [],
//     'Finished': [],
//   };

//   final TextEditingController taskController = TextEditingController();

//   void addTask(String title) {
//     if (title.isEmpty) return;

//     final newTask = Task(title: title, category: 'Default');
//     setState(() {
//       taskLists['Default']!.add(newTask);
//       taskController.clear();
//     });
//   }

//   void completeTask(String list, int index) {
//     setState(() {
//       final task = taskLists[list]![index];
//       task.isCompleted = true;
//       taskLists['Finished']!.add(task);
//       taskLists[list]!.removeAt(index);
//     });
//   }

//   Widget buildTaskList(String listName) {
//     final tasks = listName == 'All Lists'
//         ? taskLists.entries
//             .where((entry) => entry.key != 'Finished')
//             .expand((entry) => entry.value)
//             .toList()
//         : taskLists[listName]!;

//     if (tasks.isEmpty) {
//       return const Center(
//         child: Text("Nothing to do",
//             style: TextStyle(color: Colors.brown, fontSize: 16)),
//       );
//     }

//     return ListView.builder(
//       itemCount: tasks.length,
//       itemBuilder: (context, index) {
//         final task = tasks[index];
//         return Card(
//           color: const Color(0xFFD6C2A8),
//           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//           margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//           child: ListTile(
//             title: Text(task.title,
//                 style: const TextStyle(color: Colors.brown)),
//             trailing: !task.isCompleted
//                 ? IconButton(
//                     icon: const Icon(Icons.check, color: Color(0xFFE6C89F)),
//                     onPressed: () => completeTask(listName, index),
//                   )
//                 : null,
//           ),
//         );
//       },
//     );
//   }

//   Drawer buildDrawer() {
//     final lists = taskLists.keys.toList();
//     return Drawer(
//       backgroundColor: const Color(0xFFE6C89F),
//       child: ListView(
//         padding: EdgeInsets.zero,
//         children: [
//           const DrawerHeader(
//             decoration: BoxDecoration(color: Color(0xFFD6C2A8)),
//             child: Text('All Lists',
//                 style: TextStyle(color: Colors.brown, fontSize: 24)),
//           ),
//           ...lists.map((list) {
//             return ListTile(
//               leading: const Icon(Icons.list, color: Colors.brown),
//               title: Text(list, style: const TextStyle(color: Colors.brown)),
//               trailing: list == 'Finished'
//                   ? Text('${taskLists['Finished']!.length}',
//                       style: const TextStyle(color: Colors.brown))
//                   : null,
//               tileColor: selectedList == list ? const Color(0xFFFCF2DE) : null,
//               onTap: () {
//                 Navigator.pop(context);
//                 setState(() => selectedList = list);
//               },
//             );
//           }).toList(),
//           const Divider(color: Colors.brown),
//           const ListTile(
//             leading: Icon(Icons.add, color: Colors.brown),
//             title: Text("New List", style: TextStyle(color: Colors.brown)),
//           ),
//         ],
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFFCF2DE),
//       drawer: buildDrawer(),
//       appBar: AppBar(
//         title: Text(selectedList, style: const TextStyle(color: Colors.brown)),
//         backgroundColor: const Color(0xFFE6C89F),
//         iconTheme: const IconThemeData(color: Colors.brown),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.search, color: Colors.brown),
//             onPressed: () {
//               List<Task> searchTasks;

//               if (selectedList == 'All Lists') {
//                 searchTasks = taskLists.entries
//                     .where((entry) => entry.key != 'Finished')
//                     .expand((entry) => entry.value)
//                     .toList();
//               } else {
//                 searchTasks = taskLists[selectedList] ?? [];
//               }

//               showSearch(
//                 context: context,
//                 delegate: TaskSearchDelegate(searchTasks),
//               );
//             },
//           ),
//           PopupMenuButton<String>(
//             icon: const Icon(Icons.more_vert, color: Colors.brown),
//             onSelected: (value) {
//               if (value == 'Settings') {
//                 // TODO: Navigate to settings
//               } else if (value == 'Help') {
//                 // TODO: Show help
//               }
//             },
//             itemBuilder: (context) => [
//               const PopupMenuItem(value: 'Settings', child: Text('Settings')),
//               const PopupMenuItem(value: 'Help', child: Text('Help')),
//             ],
//           ),
//         ],
//       ),
//       body: buildTaskList(selectedList),
//       bottomNavigationBar: GestureDetector(
//         onTap: () async {
//           final newTask = await Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (_) => AddTaskPage(category: selectedList),
//             ),
//           );
//           if (newTask != null && newTask is Task) {
//             setState(() {
//               final category = newTask.category;
//               taskLists[category]?.add(newTask);
//             });
//           }
//         },
//         child: Container(
//           height: 60,
//           color: const Color(0xFFD6C2A8),
//           padding: const EdgeInsets.all(16),
//           child: const Center(
//             child: Text(
//               "Add Task +",
//               style: TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.brown,
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'add_task_page.dart';
import 'package:smart_task_management/screens/add_task_page.dart';
import '../services/task_service.dart';
import '../models/task_model.dart';
import 'taskpage_state.dart';

class TaskPage extends StatefulWidget {
  const TaskPage({super.key});

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  String selectedList = 'All Lists';

  // ✅ MODIFIED: Changed to use Task model instead of Map
  final Map<String, List<Task>> taskLists = {
    'Default': [],
    'Personal': [],
    'Shopping': [],
    'Wishlist': [],
    'Work': [],
    'Finished': [],
  };

  final TextEditingController taskController = TextEditingController();

  // ✅ MODIFIED: Create Task object instead of using a Map
  void addTask(String title) {
    if (title.isEmpty) return;

    final newTask = Task(
        title: title,
        category: 'Default',
        priority: 'medium',
        userId: '',
        isQuickTask: false);

    setState(() {
      taskLists['Default']!.add(newTask);
      taskController.clear();
    });
  }

  // ✅ MODIFIED: Handle Task object instead of map
  void completeTask(String list, int index) {
    final task = taskLists[list]![index];
    setState(() {
      task.isCompleted = true;
      taskLists['Finished']!.add(task);
      taskLists[list]!.removeAt(index);
    });
  }

  Widget buildTaskList(String listName) {
    final tasks = listName == 'All Lists'
        ? taskLists.entries
            .where((entry) => entry.key != 'Finished')
            .expand((entry) => entry.value)
            .toList()
        : taskLists[listName]!;

    if (tasks.isEmpty) {
      return const Center(
        child: Text("Nothing to do",
            style: TextStyle(color: Colors.brown, fontSize: 16)),
      );
    }

    return ListView.builder(
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        final task = tasks[index]; // ✅ Task object
        return Card(
          color: const Color(0xFFD6C2A8),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          child: ListTile(
            title:
                Text(task.title, style: const TextStyle(color: Colors.brown)),
            trailing: !task.isCompleted
                ? IconButton(
                    icon: const Icon(Icons.check, color: Color(0xFFE6C89F)),
                    onPressed: () => completeTask(listName, index),
                  )
                : null,
          ),
        );
      },
    );
  }

  Drawer buildDrawer() {
    final lists = taskLists.keys.toList();
    return Drawer(
      backgroundColor: const Color(0xFFE6C89F),
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(color: Color(0xFFD6C2A8)),
            child: Text('All Lists',
                style: TextStyle(color: Colors.brown, fontSize: 24)),
          ),
          ...lists.map((list) {
            return ListTile(
              leading: const Icon(Icons.list, color: Colors.brown),
              title: Text(list, style: const TextStyle(color: Colors.brown)),
              trailing: list == 'Finished'
                  ? Text('${taskLists['Finished']!.length}',
                      style: const TextStyle(color: Colors.brown))
                  : null,
              tileColor: selectedList == list ? const Color(0xFFFCF2DE) : null,
              onTap: () {
                Navigator.pop(context);
                setState(() => selectedList = list);
              },
            );
          }).toList(),
          const Divider(color: Colors.brown),
          const ListTile(
            leading: Icon(Icons.add, color: Colors.brown),
            title: Text("New List", style: TextStyle(color: Colors.brown)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFCF2DE),
      drawer: buildDrawer(),
      appBar: AppBar(
        title: Text(selectedList, style: const TextStyle(color: Colors.brown)),
        backgroundColor: const Color(0xFFE6C89F),
        iconTheme: const IconThemeData(color: Colors.brown),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.brown),
            onPressed: () {
              List<Task> searchTasks;

              if (selectedList == 'All Lists') {
                searchTasks = taskLists.entries
                    .where((entry) => entry.key != 'Finished')
                    .expand((entry) => entry.value)
                    .toList();
              } else {
                searchTasks = taskLists[selectedList] ?? [];
              }

              showSearch(
                context: context,
                delegate: TaskSearchDelegate(searchTasks), // ✅ FIXED
              );
            },
          ),
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert, color: Colors.brown),
            onSelected: (value) {
              if (value == 'Settings') {
                // TODO: Navigate to settings
              } else if (value == 'Help') {
                // TODO: Show help
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(value: 'Settings', child: Text('Settings')),
              const PopupMenuItem(value: 'Help', child: Text('Help')),
            ],
          ),
        ],
      ),
      body: buildTaskList(selectedList),
      bottomNavigationBar: GestureDetector(
        onTap: () async {
          // ✅ MODIFIED: Get Task object instead of Map
          final newTask = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => AddTaskPage(category: selectedList),
            ),
          );
          if (newTask != null && newTask is Task) {
            setState(() {
              final category = newTask.category;
              taskLists[category]?.add(newTask);
            });
          }
        },
        child: Container(
          height: 60,
          color: const Color(0xFFD6C2A8),
          padding: const EdgeInsets.all(16),
          child: const Center(
            child: Text(
              "Add Task +",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.brown,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
