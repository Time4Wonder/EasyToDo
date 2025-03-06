import 'package:flutter/material.dart';

void main() {
  runApp(MyApp()); // Startet die App
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Entfernt das Debug-Banner
      title: 'EasyToDo',
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      home: HomeScreen(), // Hauptbildschirm
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text('ToDo')), body: ToDoList());
  }
}

class ToDoList extends StatefulWidget {
  @override
  _ToDoListState createState() => _ToDoListState();
}

class _ToDoListState extends State<ToDoList> {
  List<String> tasks = []; // To-Do-Liste

  void addTask(String task) {
    setState(() {
      tasks.add(task);
    });
  }

  void removeTask(int index) {
    setState(() {
      tasks.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: tasks.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(tasks[index]),
                trailing: IconButton(
                  icon: Icon(Icons.delete, color: Colors.black),
                  onPressed: () => removeTask(index),
                ),
              );
            },
          ),
        ),
        AddTaskButton(onTaskAdded: addTask),
      ],
    );
  }
}

class AddTaskButton extends StatelessWidget {
  final Function(String) onTaskAdded;

  const AddTaskButton({super.key, required this.onTaskAdded});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) {
            TextEditingController taskController = TextEditingController();
            return AlertDialog(
              title: Text("New Task"),
              content: TextField(controller: taskController),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("Cancel"),
                ),
                TextButton(
                  onPressed: () {
                    if (taskController.text.isNotEmpty) {
                      onTaskAdded(taskController.text);
                      Navigator.pop(context);
                    }
                  },
                  child: Text("Add"),
                ),
              ],
            );
          },
        );
      },
      child: Icon(Icons.add),
    );
  }
}
