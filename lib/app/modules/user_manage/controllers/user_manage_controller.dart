import 'dart:convert';
import 'dart:io';
import 'package:ecommerce_app/app/components/custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:file_picker/file_picker.dart';
import '../../../models/user.dart'; // Import model User

class UserManageController extends GetxController {
  var userHeights = <RxDouble>[].obs;
  var avatarFile = Rx<http.MultipartFile?>(null); // Biến lưu MultipartFile của avatar
  var users = <User>[].obs;  // Danh sách người dùng
  final Rxn<User> selectedUser = Rxn<User>();
  final avatar = Rxn<String>(); // Đường dẫn avatar (nếu có)

  // Các controller cho các trường nhập liệu
  var usernameController = TextEditingController();
  var passwordController = TextEditingController();
  var fullnameController = TextEditingController();
  var addressController = TextEditingController();
  var phoneController = TextEditingController();
  var emailController = TextEditingController();
  var isAdmin = false.obs; // Trạng thái quyền Admin

  var isEditing = <String, bool>{
    'Username': false,
    'Fullname': false,
    'Email': false,
    'Phone': false,
    'Address': false,
  }.obs;

  @override
  void onInit() {
    super.onInit();
    fetchUsers(); // Lấy danh sách người dùng khi controller được khởi tạo
    userHeights.value = List.generate(users.length, (index) => 100.0.obs);
  }

  // Lấy danh sách người dùng từ API
  Future<void> fetchUsers() async {
    try {
      final response = await http.get(Uri.parse('http://localhost:8080/api/users'));

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        users.value = data.map((json) {
          // Chuyển URL avatar từ server thành URL hoàn chỉnh
          String avatarUrl = json['avata'] != null && json['avata'].isNotEmpty
              ? 'http://localhost:8080/uploads/${json['avata']}'
              : 'assets/images/default_avatar.png'; // Default avatar nếu không có avatar
          return User.fromJson({
            ...json,
            'avatar': avatarUrl,  // Thêm URL hoàn chỉnh vào dữ liệu user
          });
        }).toList();
      } else {
        Get.snackbar('Error', 'Failed to load users');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to load users: $e');
    }
  }

  // Phương thức thay đổi avatar của người dùng
  // Cập nhật avatar của người dùng
  // Cập nhật avatar của người dùng
  void changeAvatarForUser(User user) async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.image,
        withData: true,
      );

      if (result != null && result.files.isNotEmpty) {
        final file = result.files.first;

        final uri = Uri.parse('http://localhost:8080/api/users/updateAvata');
        final request = http.MultipartRequest('PUT', uri);

        request.headers.addAll({'Content-Type': 'multipart/form-data'});
        request.fields['id'] = user.id.toString(); // Dùng ID của user cần cập nhật
        request.files.add(
          http.MultipartFile.fromBytes(
            'avataFile',
            file.bytes!,
            filename: file.name,
          ),
        );

        // Gửi yêu cầu
        final response = await request.send();

        if (response.statusCode == 200) {
          avatar.value = 'http://localhost:8080/uploads/${file.name}'; // Cập nhật đường dẫn ảnh
          Get.snackbar('Success', 'Avatar updated successfully!');
          fetchUsers(); // Làm mới danh sách người dùng sau khi thay đổi avatar
        } else {
          Get.snackbar('Error', 'Failed to update avatar');
        }
      } else {
        Get.snackbar('Info', 'No image selected');
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred: $e');
    }
  }


  // Thêm người dùng mới
  // Thêm người dùng mới
  void addUser(BuildContext context) async {
    try {
      // Lấy dữ liệu từ các TextEditingController
      final userData = {
        'username': usernameController.text,
        'password': passwordController.text,
        'fullname': fullnameController.text,
        'address': addressController.text,
        'phone': phoneController.text,
        'email': emailController.text,
        'role': isAdmin.value,
      };

      print('Data to be sent to server: $userData');

      // Gửi dữ liệu lên server
      final response = await http.post(
        Uri.parse('http://localhost:8080/api/users/register'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(userData),
      );

      if (response.statusCode == 200) {
        CustomSnackBar.showCustomSnackBar(
          title: 'User',
          message: 'Thêm user thành công',
        );

        fetchUsers(); // Cập nhật lại danh sách người dùng
        Navigator.pop(context);
        clearForm(); // Xóa form

      } else {
        Get.snackbar('Lỗi', 'Thêm người dùng thất bại. Vui lòng thử lại.');
      }
    } catch (e) {
      Get.snackbar('Lỗi', 'Đã xảy ra lỗi: $e');
    }
  }



  void deleteUser(User? user) async {
    if (user == null) {
      Get.snackbar('Error', 'User not found');
      return;
    }

    try {
      // Gửi yêu cầu DELETE đến API
      final response = await http.delete(
        Uri.parse('http://localhost:8080/api/users/delete/${user.id}'),
      );

      if (response.statusCode == 200) {
        CustomSnackBar.showCustomSnackBar(
          title: 'User',
          message: 'Xóa user thành công',
        );
        fetchUsers(); // Làm mới danh sách người dùng
      } else {
        Get.snackbar('Error', 'Failed to delete user');
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred: $e');
    }
  }


  void clearForm() {
    // Xóa tất cả các trường nhập liệu
    usernameController.clear();
    passwordController.clear();
    fullnameController.clear();
    addressController.clear();
    phoneController.clear();
    emailController.clear();

    // Reset trạng thái quyền Admin
    isAdmin.value = false;

    // Reset avatar
    avatar.value = null;
    avatarFile.value = null;
  }

  void editUser(User user, BuildContext context) async {
    try {
      // Lấy dữ liệu từ các TextEditingController
      final userData = {
        'id': user.id.toString(),
        'username': usernameController.text,
        'fullname': fullnameController.text,
        'address': addressController.text,
        'phone': phoneController.text,
        'email': emailController.text,
        'role': isAdmin.value.toString(),
        // Chưa cần thêm avatar ở đây, sẽ gửi dưới dạng file
      };

      // Tạo MultipartRequest để gửi cả dữ liệu text và file
      final uri = Uri.parse('http://localhost:8080/api/users/update');
      final request = http.MultipartRequest('PUT', uri);

      // Thêm các tham số từ userData vào request
      request.fields.addAll(userData);

      // Nếu có avatar, thêm file vào request
      if (avatarFile != null && avatarFile.value != null) {
        print("Adding avatar file: ${avatarFile.value}");
        request.files.add(avatarFile.value!);
      }
      // Gửi yêu cầu
      final response = await request.send();

      if (response.statusCode == 200) {
        CustomSnackBar.showCustomSnackBar(
          title: 'User',
          message: 'Cập nhập thông tin user thành công',
        );
        fetchUsers(); // Cập nhật lại danh sách người dùng
        Navigator.pop(context);
      } else {
        Get.snackbar('Lỗi', 'Cập nhật người dùng thất bại. Vui lòng thử lại.');
      }
    } catch (e) {
      Get.snackbar('Lỗi', 'Đã xảy ra lỗi: $e');
      print(e);
    }
  }

  void setUser(User user) {
    // Cập nhật các TextEditingController với dữ liệu của user
    usernameController.text = user.username;
    fullnameController.text = user.fullname;
    emailController.text = user.email;
    phoneController.text = user.phone;
    addressController.text = user.address;

    // Cập nhật trạng thái quyền (admin hay user)
    isAdmin.value = user.role; // Giả sử role là boolean (true cho Admin, false cho User)
    avatar.value = user.avatar;
  }

  Future<http.MultipartFile?> changeAvatar() async {
    try {
      // Mở hộp thoại để chọn file hình ảnh
      final result = await FilePicker.platform.pickFiles(
        type: FileType.image,  // Chỉ cho phép chọn file ảnh
        withData: true,         // Đảm bảo rằng chúng ta có dữ liệu của file
      );

      if (result != null && result.files.isNotEmpty) {
        final file = result.files.first;  // Lấy file đầu tiên trong danh sách

        // Tạo MultipartFile từ dữ liệu đã chọn
        final multipartFile = http.MultipartFile.fromBytes(
          'avataFile',          // Tên tham số trong API
          file.bytes!,          // Dữ liệu file
          filename: file.name,  // Tên file (để server nhận diện)
        );

        // Trả về MultipartFile
        avatar.value = 'http://localhost:8080/uploads/${file.name}';
        avatarFile.value = multipartFile;
        return multipartFile;
      } else {
        Get.snackbar('Thông báo', 'Bạn chưa chọn ảnh.');
        return null;  // Trả về null nếu không có ảnh được chọn
      }
    } catch (e) {
      Get.snackbar('Lỗi', 'Đã xảy ra lỗi: $e');
      return null;
    }
  }

}
