import 'package:ecommerce_app/app/modules/category_manage/controllers/category_manage_controller.dart';
import 'package:get/get.dart';

class CategoryManageBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<CategoryManageController>(() => CategoryManageController());
  }
}