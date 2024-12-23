import 'package:ecommerce_app/app/modules/product_manage/views/Edit_Product/controller/edit_product_controller.dart';
import 'package:get/get.dart';

class EditProductBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EditProductController>(
          () => (EditProductController()),
    );
  }
}