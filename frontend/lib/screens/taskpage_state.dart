//three dots
// import 'package:flutter/material.dart';
// import 'package:smart_task_management/screens/add_task_page.dart';
// import '../services/task_service.dart';
// import '../models/task_model.dart';

// class TaskSearchDelegate extends SearchDelegate {
//   final List<Map<String, dynamic>> tasks;

//   TaskSearchDelegate(this.tasks);

//   @override
//   List<Widget>? buildActions(BuildContext context) {
//     return [
//       IconButton(
//         icon: const Icon(Icons.clear),
//         onPressed: () {
//           query = '';
//         },
//       ),
//     ];
//   }

//   @override
//   Widget? buildLeading(BuildContext context) {
//     return IconButton(
//       icon: const Icon(Icons.arrow_back),
//       onPressed: () {
//         close(context, null);
//       },
//     );
//   }

//   @override
//   Widget buildResults(BuildContext context) {
//     final results = tasks
//         .where(
//             (task) => task['title'].toLowerCase().contains(query.toLowerCase()))
//         .toList();

//     if (results.isEmpty) {
//       return const Center(child: Text("No matching tasks found"));
//     }

//     return ListView.builder(
//       itemCount: results.length,
//       itemBuilder: (context, index) {
//         final task = results[index];
//         return ListTile(
//           title: Text(task['title']),
//           trailing: task['isCompleted']
//               ? const Icon(Icons.check, color: Colors.green)
//               : null,
//         );
//       },
//     );
//   }

//   @override
//   Widget buildSuggestions(BuildContext context) {
//     final suggestions = tasks
//         .where(
//             (task) => task['title'].toLowerCase().contains(query.toLowerCase()))
//         .toList();

//     return ListView.builder(
//       itemCount: suggestions.length,
//       itemBuilder: (context, index) {
//         final task = suggestions[index];
//         return ListTile(
//           title: Text(task['title']),
//         );
//       },
//     );
//   }
// }

// class TaskPage extends StatefulWidget {
//   const TaskPage({super.key});

//   @override
//   State<TaskPage> createState() => _TaskPageState();
// }

// class _TaskPageState extends State<TaskPage> {
//   String selectedList = 'All Lists';

//   final Map<String, List<Map<String, dynamic>>> taskLists = {
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

//     final newTask = {
//       'title': title,
//       'isCompleted': false,
//     };

//     setState(() {
//       taskLists['Default']!.add(newTask);
//       taskController.clear();
//     });
//   }

//   void completeTask(String list, int index) {
//     final task = taskLists[list]![index];
//     setState(() {
//       task['isCompleted'] = true;
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
//       appBar: AppBar(
//         title: Text(selectedList, style: const TextStyle(color: Colors.brown)),
//         backgroundColor: const Color(0xFFE6C89F),
//         iconTheme: const IconThemeData(color: Colors.brown),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.search),
//             onPressed: () {
//               List<Map<String, dynamic>> searchTasks =
//                   selectedList == 'All Lists'
//                       ? taskLists.entries
//                           .where((entry) => entry.key != 'Finished')
//                           .expand((entry) => entry.value)
//                           .toList()
//                       : taskLists[selectedList] ?? [];

//               showSearch(
//                 context: context,
//                 delegate: TaskSearchDelegate(searchTasks),
//               );
//             },
//           ),
//           PopupMenuButton<String>(
//             onSelected: (value) {
//               // Handle your action for the menu items
//               if (value == 'Sort') {
//                 // Example action
//               } else if (value == 'Clear') {
//                 setState(() {
//                   taskLists[selectedList]?.clear();
//                 });
//               }
//             },
//             itemBuilder: (context) => [
//               const PopupMenuItem(
//                 value: 'Sort',
//                 child: Text('Sort by name'),
//               ),
//               const PopupMenuItem(
//                 value: 'Clear',
//                 child: Text('Clear this list'),
//               ),
//             ],
//           ),
//         ],
//       ),
//       body: buildTaskList(selectedList),
//       bottomNavigationBar: GestureDetector(
//         onTap: () {
//           Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (_) => AddTaskPage(category: selectedList),
//             ),
//           );
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
// import 'package:smart_task_management/screens/add_task_page.dart';
// import '../services/task_service.dart';
// import '../models/task_model.dart';

// class TaskSearchDelegate extends SearchDelegate {
//    final List<Map<String, dynamic>> tasks; // ✅ Change: List of Maps
// // final List<Task> tasks;
//   TaskSearchDelegate(this.tasks);

//   @override
//   List<Widget>? buildActions(BuildContext context) {
//     return [
//       IconButton(
//         icon: const Icon(Icons.clear),
//         onPressed: () {
//           query = '';
//         },
//       ),
//     ];
//   }

//   @override
//   Widget? buildLeading(BuildContext context) {
//     return IconButton(
//       icon: const Icon(Icons.arrow_back),
//       onPressed: () {
//         close(context, null);
//       },
//     );
//   }

//   @override
//   Widget buildResults(BuildContext context) {
//     final results = tasks
//         .where(
//             (task) => task['title'].toLowerCase().contains(query.toLowerCase())) // ✅ Change: Accessing map key 'title'
//         .toList();

//     if (results.isEmpty) {
//       return const Center(child: Text("No matching tasks found"));
//     }

//     return ListView.builder(
//       itemCount: results.length,
//       itemBuilder: (context, index) {
//         final task = results[index];
//         return ListTile(
//           title: Text(task['title']), // ✅ Change: Accessing map key 'title'
//           trailing: task['isCompleted'] // ✅ Change: Accessing map key 'isCompleted'
//               ? const Icon(Icons.check, color: Colors.green)
//               : null,
//         );
//       },
//     );
//   }

//   @override
//   Widget buildSuggestions(BuildContext context) {
//     final suggestions = tasks
//         .where(
//             (task) => task['title'].toLowerCase().contains(query.toLowerCase())) // ✅ Change: Accessing map key 'title'
//         .toList();

//     return ListView.builder(
//       itemCount: suggestions.length,
//       itemBuilder: (context, index) {
//         final task = suggestions[index];
//         return ListTile(
//           title: Text(task['title']), // ✅ Change: Accessing map key 'title'
//         );
//       },
//     );
//   }
// }

// class TaskPage extends StatefulWidget {
//   const TaskPage({super.key});

//   @override
//   State<TaskPage> createState() => _TaskPageState();
// }

// class _TaskPageState extends State<TaskPage> {
//   String selectedList = 'All Lists';

//   // ✅ Change: taskLists now stores List<Map<String, dynamic>>
//   final Map<String, List<Map<String, dynamic>>> taskLists = {
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

//     // ✅ Change: New task is a map with 'title' and 'isCompleted'
//     final newTask = {
//       'title': title,
//       'isCompleted': false,
//     };

//     setState(() {
//       taskLists['Default']!.add(newTask); // ✅ Change: Adding map to taskLists
//       taskController.clear();
//     });
//   }

//   void completeTask(String list, int index) {
//     final task = taskLists[list]![index];
//     setState(() {
//       task['isCompleted'] = true; // ✅ Change: Updating 'isCompleted' in map
//       taskLists['Finished']!.add(task); // ✅ Change: Adding task to 'Finished'
//       taskLists[list]!.removeAt(index); // ✅ Change: Removing task from original list
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
//         final task = tasks[index]; // ✅ Change: task is now a map
//         return Card(
//           color: const Color(0xFFD6C2A8), // light brown card
//           shape:
//               RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//           margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//           child: ListTile(
//             title: Text(task['title'], // ✅ Change: Accessing map key 'title'
//                 style: const TextStyle(color: Colors.brown)),
//             trailing: !task['isCompleted'] // ✅ Change: Accessing map key 'isCompleted'
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
//             icon: const Icon(Icons.search),
//             onPressed: () {
//               List<Map<String, dynamic>> searchTasks =
//                   selectedList == 'All Lists'
//                       ? taskLists.entries
//                           .where((entry) => entry.key != 'Finished')
//                           .expand((entry) => entry.value)
//                           .toList()
//                       : taskLists[selectedList] ?? [];

//               showSearch(
//                 context: context,
//                 delegate: TaskSearchDelegate(searchTasks), // ✅ Pass map list to search
//               );
//             },
//           ),
//           PopupMenuButton<String>(
//             onSelected: (value) {
//               // Handle your action for the menu items
//               if (value == 'Sort') {
//                 // Example action
//               } else if (value == 'Clear') {
//                 setState(() {
//                   taskLists[selectedList]?.clear(); // ✅ Clear current list
//                 });
//               }
//             },
//             itemBuilder: (context) => [
//               const PopupMenuItem(
//                 value: 'Sort',
//                 child: Text('Sort by name'),
//               ),
//               const PopupMenuItem(
//                 value: 'Clear',
//                 child: Text('Clear this list'),
//               ),
//             ],
//           ),
//         ],
//       ),
//       body: buildTaskList(selectedList),
//       bottomNavigationBar: GestureDetector(
//         onTap: () {
//           Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (_) => AddTaskPage(category: selectedList),
//             ),
//           );
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
// import 'package:smart_task_management/screens/add_task_page.dart';
// import '../services/task_service.dart';
// import '../models/task_model.dart';

// class TaskSearchDelegate extends SearchDelegate {
//   final List<Map<String, dynamic>> tasks; // ✅ Change: List of Maps

//   TaskSearchDelegate(this.tasks);

//   @override
//   List<Widget>? buildActions(BuildContext context) {
//     return [
//       IconButton(
//         icon: const Icon(Icons.clear),
//         onPressed: () {
//           query = '';
//         },
//       ),
//     ];
//   }

//   @override
//   Widget? buildLeading(BuildContext context) {
//     return IconButton(
//       icon: const Icon(Icons.arrow_back),
//       onPressed: () {
//         close(context, null);
//       },
//     );
//   }

//   @override
//   Widget buildResults(BuildContext context) {
//     final results = tasks
//         .where(
//             (task) => task['title'].toLowerCase().contains(query.toLowerCase())) // ✅ Change: Accessing map key 'title'
//         .toList();

//     if (results.isEmpty) {
//       return const Center(child: Text("No matching tasks found"));
//     }

//     return ListView.builder(
//       itemCount: results.length,
//       itemBuilder: (context, index) {
//         final task = results[index];
//         return ListTile(
//           title: Text(task['title']), // ✅ Change: Accessing map key 'title'
//           trailing: task['isCompleted'] // ✅ Change: Accessing map key 'isCompleted'
//               ? const Icon(Icons.check, color: Colors.green)
//               : null,
//         );
//       },
//     );
//   }

//   @override
//   Widget buildSuggestions(BuildContext context) {
//     final suggestions = tasks
//         .where(
//             (task) => task['title'].toLowerCase().contains(query.toLowerCase())) // ✅ Change: Accessing map key 'title'
//         .toList();

//     return ListView.builder(
//       itemCount: suggestions.length,
//       itemBuilder: (context, index) {
//         final task = suggestions[index];
//         return ListTile(
//           title: Text(task['title']), // ✅ Change: Accessing map key 'title'
//         );
//       },
//     );
//   }
// }

// class TaskPage extends StatefulWidget {
//   const TaskPage({super.key});

//   @override
//   State<TaskPage> createState() => _TaskPageState();
// }

// class _TaskPageState extends State<TaskPage> {
//   String selectedList = 'All Lists';

//   // ✅ Change: taskLists now stores List<Map<String, dynamic>>
//   final Map<String, List<Map<String, dynamic>>> taskLists = {
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

//     // ✅ Change: New task is a map with 'title' and 'isCompleted'
//     final newTask = {
//       'title': title,
//       'isCompleted': false,
//     };

//     setState(() {
//       taskLists['Default']!.add(newTask); // ✅ Change: Adding map to taskLists
//       taskController.clear();
//     });
//   }

//   void completeTask(String list, int index) {
//     final task = taskLists[list]![index];
//     setState(() {
//       task['isCompleted'] = true; // ✅ Change: Updating 'isCompleted' in map
//       taskLists['Finished']!.add(task); // ✅ Change: Adding task to 'Finished'
//       taskLists[list]!.removeAt(index); // ✅ Change: Removing task from original list
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
//         final task = tasks[index]; // ✅ Change: task is now a map
//         return Card(
//           color: const Color(0xFFD6C2A8), // light brown card
//           shape:
//               RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//           margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//           child: ListTile(
//             title: Text(task['title'], // ✅ Change: Accessing map key 'title'
//                 style: const TextStyle(color: Colors.brown)),
//             trailing: !task['isCompleted'] // ✅ Change: Accessing map key 'isCompleted'
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
//             icon: const Icon(Icons.search),
//             onPressed: () {
//               List<Map<String, dynamic>> searchTasks =
//                   selectedList == 'All Lists'
//                       ? taskLists.entries
//                           .where((entry) => entry.key != 'Finished')
//                           .expand((entry) => entry.value)
//                           .toList()
//                       : taskLists[selectedList] ?? [];

//               showSearch(
//                 context: context,
//                 delegate: TaskSearchDelegate(searchTasks), // ✅ Pass map list to search
//               );
//             },
//           ),
//           PopupMenuButton<String>(
//             onSelected: (value) {
//               // Handle your action for the menu items
//               if (value == 'Sort') {
//                 // Example action
//               } else if (value == 'Clear') {
//                 setState(() {
//                   taskLists[selectedList]?.clear(); // ✅ Clear current list
//                 });
//               }
//             },
//             itemBuilder: (context) => [
//               const PopupMenuItem(
//                 value: 'Sort',
//                 child: Text('Sort by name'),
//               ),
//               const PopupMenuItem(
//                 value: 'Clear',
//                 child: Text('Clear this list'),
//               ),
//             ],
//           ),
//         ],
//       ),
//       body: buildTaskList(selectedList),
//       bottomNavigationBar: GestureDetector(
//         onTap: () {
//           Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (_) => AddTaskPage(category: selectedList),
//             ),
//           );
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
// import 'package:smart_task_management/screens/add_task_page.dart';
// import '../services/task_service.dart';
// import '../models/task_model.dart';

// class TaskSearchDelegate extends SearchDelegate {
//   final List<Map<String, dynamic>> tasks; // ✅ Change: List of Maps

//   TaskSearchDelegate(this.tasks);

//   @override
//   List<Widget>? buildActions(BuildContext context) {
//     return [
//       IconButton(
//         icon: const Icon(Icons.clear),
//         onPressed: () {
//           query = '';
//         },
//       ),
//     ];
//   }

//   @override
//   Widget? buildLeading(BuildContext context) {
//     return IconButton(
//       icon: const Icon(Icons.arrow_back),
//       onPressed: () {
//         close(context, null);
//       },
//     );
//   }

//   @override
//   Widget buildResults(BuildContext context) {
//     final results = tasks
//         .where((task) => task['title']
//             .toLowerCase()
//             .contains(query.toLowerCase())) // ✅ Change: Accessing map key 'title'
//         .toList();

//     if (results.isEmpty) {
//       return const Center(child: Text("No matching tasks found"));
//     }

//     return ListView.builder(
//       itemCount: results.length,
//       itemBuilder: (context, index) {
//         final task = results[index];
//         return ListTile(
//           title: Text(task['title']), // ✅ Change: Accessing map key 'title'
//           trailing: task['isCompleted'] // ✅ Change: Accessing map key 'isCompleted'
//               ? const Icon(Icons.check, color: Colors.green)
//               : null,
//         );
//       },
//     );
//   }

//   @override
//   Widget buildSuggestions(BuildContext context) {
//     final suggestions = tasks
//         .where((task) => task['title']
//             .toLowerCase()
//             .contains(query.toLowerCase())) // ✅ Change: Accessing map key 'title'
//         .toList();

//     return ListView.builder(
//       itemCount: suggestions.length,
//       itemBuilder: (context, index) {
//         final task = suggestions[index];
//         return ListTile(
//           title: Text(task['title']), // ✅ Change: Accessing map key 'title'
//         );
//       },
//     );
//   }
// }

// class TaskPage extends StatefulWidget {
//   const TaskPage({super.key});

//   @override
//   State<TaskPage> createState() => _TaskPageState();
// }

// class _TaskPageState extends State<TaskPage> {
//   String selectedList = 'All Lists';

//   // ✅ Change: taskLists now stores List<Map<String, dynamic>>
//   final Map<String, List<Map<String, dynamic>>> taskLists = {
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

//     // ✅ Change: New task is a map with 'title' and 'isCompleted'
//     final newTask = {
//       'title': title,
//       'isCompleted': false,
//     };

//     setState(() {
//       taskLists['Default']!.add(newTask); // ✅ Change: Adding map to taskLists
//       taskController.clear();
//     });
//   }

//   void completeTask(String list, int index) {
//     final task = taskLists[list]![index];
//     setState(() {
//       task['isCompleted'] = true; // ✅ Change: Updating 'isCompleted' in map
//       taskLists['Finished']!.add(task); // ✅ Change: Adding task to 'Finished'
//       taskLists[list]!.removeAt(index); // ✅ Change: Removing task from original list
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
//         final task = tasks[index]; // ✅ Change: task is now a map
//         return Card(
//           color: const Color(0xFFD6C2A8), // light brown card
//           shape:
//               RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//           margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//           child: ListTile(
//             title: Text(task['title'], // ✅ Change: Accessing map key 'title'
//                 style: const TextStyle(color: Colors.brown)),
//             trailing: !task['isCompleted'] // ✅ Change: Accessing map key 'isCompleted'
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
//             icon: const Icon(Icons.search),
//             onPressed: () {
//               List<Map<String, dynamic>> searchTasks =
//                   selectedList == 'All Lists'
//                       ? taskLists.entries
//                           .where((entry) => entry.key != 'Finished')
//                           .expand((entry) => entry.value)
//                           .toList()
//                       : taskLists[selectedList] ?? [];

//               showSearch(
//                 context: context,
//                 delegate: TaskSearchDelegate(searchTasks), // ✅ Pass map list to search
//               );
//             },
//           ),
//           PopupMenuButton<String>(
//             onSelected: (value) {
//               // Handle your action for the menu items
//               if (value == 'Sort') {
//                 // Example action
//               } else if (value == 'Clear') {
//                 setState(() {
//                   taskLists[selectedList]?.clear(); // ✅ Clear current list
//                 });
//               }
//             },
//             itemBuilder: (context) => [
//               const PopupMenuItem(
//                 value: 'Sort',
//                 child: Text('Sort by name'),
//               ),
//               const PopupMenuItem(
//                 value: 'Clear',
//                 child: Text('Clear this list'),
//               ),
//             ],
//           ),
//         ],
//       ),
//       body: buildTaskList(selectedList),
//       bottomNavigationBar: GestureDetector(
//         onTap: () {
//           Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (_) => AddTaskPage(category: selectedList),
//             ),
//           );
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
import 'package:flutter/material.dart';
import 'package:smart_task_management/screens/add_task_page.dart';
import '../services/task_service.dart';
import '../models/task_model.dart';

class TaskSearchDelegate extends SearchDelegate {
  final List<Task>
      tasks; // ✅ Change: Use List<Task> instead of List<Map<String, dynamic>>

  TaskSearchDelegate(this.tasks);

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final results = tasks
        .where((task) => task.title.toLowerCase().contains(
            query.toLowerCase())) // ✅ Change: Access Task properties directly
        .toList();

    if (results.isEmpty) {
      return const Center(child: Text("No matching tasks found"));
    }

    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        final task = results[index];
        return ListTile(
          title: Text(task.title), // ✅ Change: Access Task properties directly
          trailing: task.isCompleted
              ? const Icon(Icons.check, color: Colors.green)
              : null,
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = tasks
        .where((task) => task.title.toLowerCase().contains(
            query.toLowerCase())) // ✅ Change: Access Task properties directly
        .toList();

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        final task = suggestions[index];
        return ListTile(
          title: Text(task.title), // ✅ Change: Access Task properties directly
        );
      },
    );
  }
}
