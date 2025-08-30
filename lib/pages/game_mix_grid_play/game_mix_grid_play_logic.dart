import 'package:game_mix/db_game_mix/game_mix_entity.dart';
import 'package:game_mix/db_game_mix/game_mix_util.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:game_mix/db_game_mix/db_game_mix.dart';

class GameMixGridPlayController extends GetxController {
  final DB db = Get.find<DB>();

  final RxInt selectedGridIndex = 1.obs;
  final gridList = RxList<GridGameEntity>([]);

  @override
  void onInit() {
    super.onInit();
    getGridList();
  }

  void selectGrid(int index) {
    selectedGridIndex.value = index;
  }

  void startGame() async {
    if (gridList.isEmpty) return;

    final int totalGrids = gridList.length - 1;

    List<int> randomPath1 = generateUniqueRandomNumbers(1, totalGrids);
    List<int> randomPath2 = generateUniqueRandomNumbers(1, totalGrids);
    List<int> randomPath = [...randomPath1, ...randomPath2];

    for (int i = 0; i < randomPath.length; i++) {
      int delay = 50 + (i * 12);
      await Future.delayed(Duration(milliseconds: delay));
      selectedGridIndex.value = randomPath[i];
    }

    Get.snackbar(
      '${getGridItem(0).value} Result',
      'Pick grid ${getGridItem(randomPath.last).value}',
      snackPosition: SnackPosition.BOTTOM,
      duration: Duration(seconds: 1),
      backgroundColor: Color(0xFF6873F7).withOpacity(0.9),
      colorText: Colors.white,
    );
  }

  getGridList() async {
    final result = await db.getAllGridGames();
    if (result.isNotEmpty) {
      gridList.value = result;
    } else {
      gridList.value = gridGameInitList.map((item) => item.copyWith()).toList();
      for (var grid in gridGameInitList) {
        await db.insertGridGame(grid);
      }
    }
  }

  getGridItem(int order) {
    return gridList.firstWhere((element) => element.order == order);
  }

  editGrid() async {
    await Get.toNamed('/game_mix_set_grid_play');
    getGridList();
  }
}
