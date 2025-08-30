import 'package:get/get.dart';
import 'game_mix_draw_lots_logic.dart';

class GameMixDrawLotsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => GameMixDrawLotsController());
  }
}
