import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/task_provider.dart';

class DashboardScreen extends StatefulWidget {
  @override
  State<DashboardScreen> createState() => _DashState();
}

class _DashState extends State<DashboardScreen> {
  final t = TextEditingController();
  final d = TextEditingController();

  @override
  void initState() {
    super.initState();
    Provider.of<TaskProvider>(context, listen: false).loadTasks();
  }

  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<TaskProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text("Task Manager"),
      ),

      body: Column(
        children: [
          /// STATUS
          Padding(
            padding: EdgeInsets.all(10),
            child: Row(
              children: [
                stat("New", "0"),
                stat("Progress", "0"),
                stat("Completed", "0"),
                stat("Cancel", "0"),
              ],
            ),
          ),

          /// TASK LIST
          Expanded(
            child: ListView.builder(
              itemCount: prov.tasks.length,
              itemBuilder: (_, i) {
                final task = prov.tasks[i];

                return Card(
                  margin: EdgeInsets.all(8),
                  child: ListTile(
                    title: Text(task['title']),
                    subtitle: Text(task['description'] ?? ""),
                    trailing: IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () =>
                          prov.deleteTask(task['_id']),
                    ),
                  ),
                );
              },
            ),
          ),

          TextField(controller: t, decoration: InputDecoration(labelText: "Title")),
          TextField(controller: d, decoration: InputDecoration(labelText: "Description")),

          ElevatedButton(
            onPressed: () {
              prov.addTask(t.text, d.text);
            },
            child: Text("Add Task"),
          )
        ],
      ),
    );
  }

  Widget stat(String title, String count) {
    return Expanded(
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              Text(count, style: TextStyle(fontWeight: FontWeight.bold)),
              Text(title)
            ],
          ),
        ),
      ),
    );
  }
}