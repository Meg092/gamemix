import 'package:get/get.dart';
import 'game_mix_draw_lots_history_logic.dart';

class GameMixDrawLotsHistoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => GameMixDrawLotsHistoryController());
  }
}
