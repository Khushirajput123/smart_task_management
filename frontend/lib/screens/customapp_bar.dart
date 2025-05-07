import 'package:flutter/material.dart';

class CustomAppBarWithMenu extends StatelessWidget
    implements PreferredSizeWidget {
  const CustomAppBarWithMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xFFE6C89F), // Signup theme color
      title: const Text(
        'All Lists',
        style: TextStyle(color: Colors.brown, fontWeight: FontWeight.bold),
      ),
      iconTheme: const IconThemeData(color: Colors.brown),
      actions: [
        PopupMenuButton<String>(
          color: const Color(0xFFD6C2A8), // Light brown background for menu
          icon: const Icon(Icons.more_vert, color: Colors.brown),
          onSelected: (value) {
            // Add functionality here as needed
            switch (value) {
              case 'task_lists':
                // Navigate or show dialog
                break;
              case 'feedback':
                break;
              case 'follow':
                break;
              case 'invite':
                break;
              case 'settings':
                break;
            }
          },
          itemBuilder: (BuildContext context) {
            return const [
              PopupMenuItem<String>(
                value: 'task_lists',
                child: Text(
                  'Task Lists',
                  style: TextStyle(color: Colors.brown),
                ),
              ),
              PopupMenuItem<String>(
                value: 'feedback',
                child: Text(
                  'Send feedback',
                  style: TextStyle(color: Colors.brown),
                ),
              ),
              PopupMenuItem<String>(
                value: 'follow',
                child: Text(
                  'Follow us',
                  style: TextStyle(color: Colors.brown),
                ),
              ),
              PopupMenuItem<String>(
                value: 'invite',
                child: Text(
                  'Invite friends to the app',
                  style: TextStyle(color: Colors.brown),
                ),
              ),
              PopupMenuItem<String>(
                value: 'settings',
                child: Text(
                  'Settings',
                  style: TextStyle(color: Colors.brown),
                ),
              ),
            ];
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
