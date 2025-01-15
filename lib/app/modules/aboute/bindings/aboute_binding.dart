import 'package:ecommerce_app/app/modules/aboute/controllers/aboute_controller.dart';
import 'package:get/get.dart';

class AbouteBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<AbouteController>(() => AbouteController());
  }
}