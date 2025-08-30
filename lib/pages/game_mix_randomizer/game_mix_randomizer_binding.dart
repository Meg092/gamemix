import 'package:get/get.dart';
import 'game_mix_randomizer_logic.dart';

class GameMixRandomizerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => GameMixRandomizerController());
  }
}
