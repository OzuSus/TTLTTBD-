import 'dart:convert'; // Để xử lý JSON
import 'package:ecommerce_app/app/models/user.dart';
import 'package:ecommerce_app/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart'; // Để điều hướng
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isPasswordVisible = false;

  Future<void> saveUserInfo(User user) async {
    final prefs = await SharedPreferences.getInstance();
    String userInfo = json.encode({
      "id": user.id,
      "username": user.username,
      "fullname": user.fullname,
      "address": user.address,
      "phone": user.phone,
      "email": user.email,
      "role": user.role,
      "avatar": user.avatar,
    });
    await prefs.setString('user_info', userInfo);
  }

  Future<void> login() async {
    String username = _usernameController.text.trim();
    String password = _passwordController.text.trim();

    if (username.isEmpty || password.isEmpty) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Lỗi"),
            content: const Text("Vui lòng nhập tên đăng nhập và mật khẩu."),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("OK"),
              ),
            ],
          );
        },
      );
      return;
    }

    final String apiUrl =
        "http://10.0.167.232:8080/api/users/login?username=$username&password=$password";

    try {
      final response = await http.post(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        User user = User.fromJson(responseData);
        await saveUserInfo(user);
        Get.toNamed(Routes.BASE);
      } else if (response.statusCode == 400) {
        // Xử lý lỗi Bad Request
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text("Lỗi"),
              content: const Text("Yêu cầu không hợp lệ. Kiểm tra lại thông tin."),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("OK"),
                ),
              ],
            );
          },
        );
      } else {
        // Xử lý các mã lỗi khác
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text("Lỗi"),
              content: Text("Đã xảy ra lỗi: ${response.statusCode}"),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("OK"),
                ),
              ],
            );
          },
        );
      }
    } catch (e) {
      // Lỗi kết nối hoặc server không phản hồi
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Lỗi"),
            content: const Text("Sai username hoặc mật khẩu"),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("OK"),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Ảnh nền
          Image.asset(
            "assets/images/login_background.jpg",
            fit: BoxFit.cover,
          ),
          Container(
            color: Colors.black.withOpacity(0.5),
          ),
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    "LOGIN",
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 32),
                  // Username
                  TextField(
                    controller: _usernameController,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      labelText: 'Username',
                      labelStyle: const TextStyle(color: Colors.white70),
                      filled: true,
                      fillColor: Colors.white10,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      prefixIcon: const Icon(Icons.person, color: Colors.white70),
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Password
                  TextField(
                    controller: _passwordController,
                    obscureText: !_isPasswordVisible,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      labelText: 'Password',
                      labelStyle: const TextStyle(color: Colors.white70),
                      filled: true,
                      fillColor: Colors.white10,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      prefixIcon: const Icon(Icons.lock, color: Colors.white70),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isPasswordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Colors.white70,
                        ),
                        onPressed: () {
                          setState(() {
                            _isPasswordVisible = !_isPasswordVisible;
                          });
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Button Login
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: const Color(0xFF6A1B9A),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 64,
                        vertical: 16,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: login,
                    child: const Text(
                      "Đăng nhập",
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Đăng ký
                  GestureDetector(
                    onTap: () {
                      Get.offNamed(Routes.REGISTER);
                    },
                    child: const Text.rich(
                      TextSpan(
                        text: "Chưa có tài khoản? ",
                        style: TextStyle(color: Colors.white),
                        children: [
                          TextSpan(
                            text: "Đăng ký",
                            style: TextStyle(
                              color: Colors.yellow,
                              decoration: TextDecoration.none,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Model User
// class User {
//   final int id;
//   final String username;
//   final String fullname;
//   final String address;
//   final String phone;
//   final String email;
//   final bool role;
//   final String? avatar;
//
//   User({
//     required this.id,
//     required this.username,
//     required this.fullname,
//     required this.address,
//     required this.phone,
//     required this.email,
//     required this.role,
//     this.avatar,
//   });
//
//   factory User.fromJson(Map<String, dynamic> json) {
//     return User(
//       id: json['id'] as int,
//       username: json['username'] as String,
//       fullname: json['fullname'] as String,
//       address: json['address'] as String,
//       phone: json['phone'] as String,
//       email: json['email'] as String,
//       role: json['role'] as bool,
//       avatar: json['avatar'],
//     );
//   }
// }
