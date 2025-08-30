import 'package:get/get.dart';
import 'game_mix_coin_flip_logic.dart';

class GameMixCoinFlipBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => GameMixCoinFlipController());
  }
}
