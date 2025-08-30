import 'package:get/get.dart';

import './game_mix_tab_logic.dart';

class GameMixTabBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => GameMixTabController());
  }
}
