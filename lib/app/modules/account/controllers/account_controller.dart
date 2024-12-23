import 'dart:convert';
import 'package:ecommerce_app/utils/UserUtils.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;


class AccountController extends GetxController {
  final avatarUrl = ''.obs;

  final usernameController = TextEditingController();
  final fullnameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();

  final isEditing = <String, bool>{
    'Username': false,
    'Fullname': false,
    'Email': false,
    'Phone': false,
    'Address': false,
  }.obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    fetchUserData(await UserUtils.getUserId());
  }

  Future<void> fetchUserData(int id) async {
    try {
      final response = await http.get(
        Uri.parse('http://localhost:8080/api/users/id?id=$id'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        usernameController.text = data['username'];
        fullnameController.text = data['fullname'];
        emailController.text = data['email'];
        phoneController.text = data['phone'];
        addressController.text = data['address'];

        avatarUrl.value = data['avata']?.isNotEmpty == true
            ? 'http://localhost:8080/uploads/${data['avata']}'
            : '';
      } else {
        Get.snackbar('Error', 'Failed to fetch user data');
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred: $e');
    }
  }

  void changeAvatar() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.image,
        withData: true,
      );

      if (result != null && result.files.isNotEmpty) {
        final userId = await UserUtils.getUserId();
        final file = result.files.first;

        final uri = Uri.parse('http://localhost:8080/api/users/updateAvata');
        final request = http.MultipartRequest('PUT', uri);

        request.headers.addAll({'Content-Type': 'multipart/form-data'});

        request.fields['id'] = userId.toString();
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
          Get.snackbar('Thành công', 'Avatar đã được cập nhật!');
          fetchUserData(userId);
        } else {
          Get.snackbar('Lỗi', 'Cập nhật avatar thất bại. Vui lòng thử lại.');
        }
      } else {
        Get.snackbar('Thông báo', 'Bạn chưa chọn ảnh.');
      }
    } catch (e) {
      Get.snackbar('Lỗi', 'Đã xảy ra lỗi: $e');
    }
  }


  void toggleEditing(String field) {
    isEditing[field] = !isEditing[field]!;
  }

  TextEditingController getFieldController(String field) {
    switch (field) {
      case 'Username':
        return usernameController;
      case 'Fullname':
        return fullnameController;
      case 'Email':
        return emailController;
      case 'Phone':
        return phoneController;
      case 'Address':
        return addressController;
      default:
        throw Exception('Unknown field: $field');
    }
  }

  void saveChanges() async {
    try {
      final userId = await UserUtils.getUserId();
      final uri = Uri.parse('http://localhost:8080/api/users/updateInfoAccount');
      final request = http.MultipartRequest('PUT', uri);

      request.headers.addAll({'Content-Type': 'multipart/form-data'});

      request.fields['id'] = userId.toString();
      request.fields['username'] = usernameController.text;
      request.fields['fullname'] = fullnameController.text;
      request.fields['email'] = emailController.text;
      request.fields['phone'] = phoneController.text;
      request.fields['address'] = addressController.text;

      final response = await request.send();

      if (response.statusCode == 200) {
        Get.snackbar('Thành công', 'Thông tin đã được cập nhật!');
      } else {
        Get.snackbar('Lỗi', 'Cập nhật thông tin thất bại. Vui lòng thử lại.');
      }
    } catch (e) {
      Get.snackbar('Lỗi', 'Đã xảy ra lỗi: $e');
    }
  }


}

