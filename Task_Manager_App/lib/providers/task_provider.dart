import 'package:flutter/material.dart';
import '../services/api_service.dart';

class TaskProvider with ChangeNotifier {
  final api = ApiService();
  List tasks = [];

  void setToken(String token) {
    api.token = token;
  }

  Future loadTasks() async {
    final data = await api.getTasks();
    tasks = data['data'];
    notifyListeners();
  }

  Future addTask(String t, String d) async {
    await api.createTask(t, d);
    await loadTasks();
  }

  Future deleteTask(String id) async {
    await api.deleteTask(id);
    await loadTasks();
  }
}