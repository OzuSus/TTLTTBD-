import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {
  Future<Map<String, dynamic>?> login(String username, String password) async {
    const String apiUrl = "http://10.0.167.232:8080/api/users/login"; // Thay bằng endpoint thực tế
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"username": username, "password": password}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data;
    } else if (response.statusCode == 401) {
      return null; // Sai username/password
    } else {
      throw Exception("Lỗi kết nối tới API");
    }
  }
}
