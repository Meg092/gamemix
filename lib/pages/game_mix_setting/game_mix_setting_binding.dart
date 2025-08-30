import 'package:get/get.dart';
import './game_mix_setting_logic.dart';

class GameMixSettingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => GameMixSettingController());
  }
}
