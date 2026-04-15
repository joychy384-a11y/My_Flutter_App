import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const baseUrl = "https://task.teamrabbil.com/api/v1";
  String token = "";

  Map<String, String> get headers => {
        "Content-Type": "application/json",
        "token": token
      };

  Future login(String email, String pass) async {
    final res = await http.post(
      Uri.parse("$baseUrl/login"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"email": email, "password": pass}),
    );
    final data = jsonDecode(res.body);
    token = data['token'] ?? "";
    return data;
  }

  Future register(Map body) async {
    final res = await http.post(
      Uri.parse("$baseUrl/registration"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(body),
    );
    return jsonDecode(res.body);
  }

  Future getTasks() async {
    final res = await http.get(
      Uri.parse("$baseUrl/listTaskByStatus/New"),
      headers: headers,
    );
    return jsonDecode(res.body);
  }

  Future createTask(String title, String desc) async {
    await http.post(
      Uri.parse("$baseUrl/createTask"),
      headers: headers,
      body: jsonEncode({
        "title": title,
        "description": desc,
        "status": "New"
      }),
    );
  }

  Future deleteTask(String id) async {
    await http.get(
      Uri.parse("$baseUrl/deleteTask/$id"),
      headers: headers,
    );
  }
}