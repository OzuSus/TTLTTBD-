import 'package:get/get.dart';
import '../controllers/purchase_history_controller.dart';

class PurchaseHistoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PurchaseHistoryController>(
          () => PurchaseHistoryController(),
    );
  }
}
