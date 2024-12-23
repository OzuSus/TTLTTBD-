import 'package:ecommerce_app/app/modules/product_manage/views/Create_Product/controller/create_product_controlller.dart';
import 'package:get/get.dart';

class CreateProductBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CreateProductController>(
          () => (CreateProductController()),
    );
  }
}