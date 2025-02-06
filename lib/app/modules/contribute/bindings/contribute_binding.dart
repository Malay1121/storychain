import 'package:get/get.dart';

import '../controllers/contribute_controller.dart';

class ContributeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ContributeController>(
      () => ContributeController(),
    );
  }
}
