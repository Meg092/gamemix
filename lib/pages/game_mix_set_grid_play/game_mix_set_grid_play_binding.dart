import 'package:get/get.dart';
import 'game_mix_set_grid_play_logic.dart';

class GameMixSetGridPlayBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => GameMixSetGridPlayController());
  }
}
