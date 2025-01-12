import 'package:get/get.dart';
import '../controllers/user_manage_controller.dart';

class UserManageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UserManageController>(
          () => UserManageController(),
    );
  }
}
