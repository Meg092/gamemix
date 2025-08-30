import 'package:get/get.dart';

import 'game_mix_config_logic.dart';

class GameMixConfigBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(
      GameMixConfigLogic(),
      permanent: true,
    );
  }
}
