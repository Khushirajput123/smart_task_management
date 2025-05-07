//add task page
import 'package:flutter/material.dart';
import '../models/task_model.dart';
import '../services/task_service.dart';
import 'add_task_page.dart';

class TaskListPage extends StatefulWidget {
  final String category;

  const TaskListPage({super.key, required this.category});

  @override
  State<TaskListPage> createState() => _TaskListPageState();
}

class _TaskListPageState extends State<TaskListPage> {
  List<Task> _tasks = [];
  bool _isLoading = true;

  Future<void> _fetchTasks() async {
    setState(() => _isLoading = true);
    final tasks = await TaskService().getTasksByCategory(widget.category);
    setState(() {
      _tasks = tasks;
      _isLoading = false;
    });
  }

  // Function to navigate to AddTaskPage and add the new task
  Future<void> _addTask() async {
    final newTask = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => AddTaskPage(category: widget.category),
      ),
    );

    // Ensure the returned task is added to the list
    if (newTask != null && newTask is Task) {
      setState(() {
        _tasks.add(newTask); // Add new task to the list
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchTasks();
  }

  Future<void> _goToAddTask() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddTaskPage(category: widget.category),
      ),
    );

    if (result == true) {
      _fetchTasks();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.category} Tasks'),
        backgroundColor: Theme.of(context).primaryColor,
        actions: [
          IconButton(
            onPressed: _fetchTasks,
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _tasks.isEmpty
              ? const Center(child: Text('No tasks found.'))
              : ListView.builder(
                  itemCount: _tasks.length,
                  itemBuilder: (context, index) {
                    final task = _tasks[index];
                    return ListTile(
                      title: Text(task.title),
                      subtitle: Text(task.description ?? ''),
                      trailing: Text(task.priority),
                    );
                  },
                ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _goToAddTask,
        icon: const Icon(Icons.add),
        label: const Text("Add Task"),
        backgroundColor: Theme.of(context).primaryColor,
      ),
    );
  }
}
