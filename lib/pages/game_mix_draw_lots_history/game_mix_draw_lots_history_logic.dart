import 'package:game_mix/db_game_mix/db_game_mix.dart';
import 'package:game_mix/db_game_mix/game_mix_entity.dart';
import 'package:get/get.dart';

class GameMixDrawLotsHistoryController extends GetxController {
  final DB db = Get.find<DB>();

  final drawLots = Rx<List<DrawLotsEntity>>([]);

  @override
  void onInit() async {
    super.onInit();
    await getDrawLotsHistory();
  }

  getDrawLotsHistory() async {
    drawLots.value = await db.getAllDrawLots();
  }
}
