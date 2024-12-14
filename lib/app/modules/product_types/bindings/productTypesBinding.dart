import 'package:ecommerce_app/app/modules/product_types/controllers/productTypes_controller.dart';
import 'package:get/get.dart';

class ProductTypesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProductTypesController>(
          () => ProductTypesController(),
    );
  }
}