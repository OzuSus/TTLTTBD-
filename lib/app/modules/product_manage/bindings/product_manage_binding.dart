import 'package:ecommerce_app/app/modules/product_manage/controller/product_manage_controller.dart';
import 'package:get/get.dart';

class ProductManageBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<ProductManageController>(
          () => ProductManageController(),
    );
  }
}