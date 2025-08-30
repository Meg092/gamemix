import 'package:game_mix/db_game_mix/game_mix_entity.dart';
import 'package:game_mix/db_game_mix/game_mix_util.dart';
import 'package:get/get.dart';

import 'package:game_mix/db_game_mix/db_game_mix.dart';

class GameMixSetGridPlayController extends GetxController {
  final DB db = Get.find<DB>();
  final gridList = RxList<GridGameEntity>([]);

  @override
  void onInit() {
    super.onInit();
    getGridList();
  }

  initGrid() {
    gridList.value = gridGameInitList.map((item) => item.copyWith()).toList();
  }

  saveGrid() async {
    for (var item in gridList) {
      await db.updateGridGame(item);
    }

    successToast('Grid game saved successfully');

    Get.back();
  }

  getGridList() async {
    final result = await db.getAllGridGames();
    gridList.value = result;
  }

  getGridItem(int order) {
    return gridList.firstWhere((element) => element.order == order);
  }

  updateGridItem(int order, String value) async {
    final item = getGridItem(order);
    item.value = value;
    gridList.value =
        gridList
            .map<GridGameEntity>((e) => e.order == order ? item : e)
            .toList();
  }
}
