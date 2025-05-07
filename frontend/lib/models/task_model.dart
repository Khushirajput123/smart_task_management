// class Task {
//   String? id;
//   String title;
//   String? description;
//   String priority;
//   String category; // No normalization here
//   String userId;
//   bool isQuickTask;
//   DateTime? dueDate;
//   DateTime? completedAt;

//   // ✅ ADDED:
//   DateTime? reminderTime;

//   Task({
//     this.id,
//     required this.title,
//     this.description,
//     required this.priority,
//     required this.category, // No normalization here
//     required this.userId,
//     required this.isQuickTask,
//     this.dueDate,
//     this.completedAt,
//     this.reminderTime, // ✅ added here
//   });

//   factory Task.fromJson(Map<String, dynamic> json) {
//     return Task(
//       id: json['_id'],
//       title: json['title'],
//       description: json['description'],
//       priority: json['priority'],
//       category: json['category'], // Category comes as it is from the API
//       userId: json['userId'],
//       isQuickTask: json['isQuickTask'] ?? false,
//       dueDate:
//           json['dueDate'] != null ? DateTime.tryParse(json['dueDate']) : null,
//       completedAt: json['completedAt'] != null
//           ? DateTime.tryParse(json['completedAt'])
//           : null,
//       reminderTime: json['reminderTime'] != null
//           ? DateTime.tryParse(json['reminderTime'])
//           : null, // ✅ Added this part
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       if (id != null) "_id": id,
//       "title": title,
//       "description": description,
//       "priority": priority,
//       "category": category, // No normalization here
//       "userId": userId,
//       "isQuickTask": isQuickTask,
//       "dueDate": dueDate?.toIso8601String(),
//       "completedAt": completedAt?.toIso8601String(),
//       "reminderTime": reminderTime?.toIso8601String(), // ✅ Added this part
//     };
//   }

//   // ✅ Added copyWith method
//   Task copyWith({
//     String? id,
//     String? title,
//     String? description,
//     String? priority,
//     String? category,
//     String? userId,
//     bool? isQuickTask,
//     DateTime? dueDate,
//     DateTime? completedAt,
//     DateTime? reminderTime,
//   }) {
//     return Task(
//       id: id ?? this.id,
//       title: title ?? this.title,
//       description: description ?? this.description,
//       priority: priority ?? this.priority,
//       category: category ?? this.category,
//       userId: userId ?? this.userId,
//       isQuickTask: isQuickTask ?? this.isQuickTask,
//       dueDate: dueDate ?? this.dueDate,
//       completedAt: completedAt ?? this.completedAt,
//       reminderTime: reminderTime ?? this.reminderTime,
//     );
//   }
// }

class Task {
  String? id;
  String title;
  String? description;
  String priority;
  String category;
  bool isCompleted; // No normalization here
  String userId;
  bool isQuickTask;
  DateTime? dueDate;
  DateTime? completedAt;

  // ✅ ADDED: Reminder field for notification support
  DateTime? reminderTime;

  Task({
    this.id,
    required this.title,
    this.description,
    required this.priority,
    required this.category,
    this.isCompleted = false, // No normalization here
    required this.userId,
    required this.isQuickTask,
    this.dueDate,
    this.completedAt,
    this.reminderTime, // ✅ added here
  });

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['_id'],
      title: json['title'],
      description: json['description'],
      priority: json['priority'],
      category: json['category'],
      isCompleted:
          json['isCompleted'] ?? false, // Category comes as it is from the API
      userId: json['userId'],
      isQuickTask: json['isQuickTask'] ?? false,
      dueDate:
          json['dueDate'] != null ? DateTime.tryParse(json['dueDate']) : null,
      completedAt: json['completedAt'] != null
          ? DateTime.tryParse(json['completedAt'])
          : null,

      // ✅ ADDED: Parse reminderTime from API
      reminderTime: json['reminderTime'] != null
          ? DateTime.tryParse(json['reminderTime'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null) "_id": id,
      "title": title,
      "description": description,
      "priority": priority,
      "category": category,
      'isCompleted': isCompleted, // No normalization here
      "userId": userId,
      "isQuickTask": isQuickTask,
      "dueDate": dueDate?.toIso8601String(),
      "completedAt": completedAt?.toIso8601String(),

      // ✅ ADDED: Include reminderTime in request
      "reminderTime": reminderTime?.toIso8601String(),
    };
  }

  // ✅ ADDED: Handy method to create copies of Task with modified fields
  Task copyWith({
    String? id,
    String? title,
    String? description,
    String? priority,
    String? category,
    bool? isCompleted, // ✅ ADDED this
    String? userId,
    bool? isQuickTask,
    DateTime? dueDate,
    DateTime? completedAt,
    DateTime? reminderTime,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      priority: priority ?? this.priority,
      category: category ?? this.category,
      isCompleted: isCompleted ?? this.isCompleted, // ✅ ADDED this
      userId: userId ?? this.userId,
      isQuickTask: isQuickTask ?? this.isQuickTask,
      dueDate: dueDate ?? this.dueDate,
      completedAt: completedAt ?? this.completedAt,
      reminderTime: reminderTime ?? this.reminderTime,
    );
  }
}
