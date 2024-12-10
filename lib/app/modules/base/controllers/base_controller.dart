import 'package:get/get.dart';

import '../../../../utils/dummy_helper.dart';
import '../../favorites/controllers/favorites_controller.dart';

class BaseController extends GetxController {

  int currentIndex = 0;

  changeScreen(int selectedIndex) {
    currentIndex = selectedIndex;
    update();
  }


}
