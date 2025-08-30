import 'package:get/get.dart';
import 'game_mix_grid_play_logic.dart';

class GameMixGridPlayBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => GameMixGridPlayController());
  }
}
