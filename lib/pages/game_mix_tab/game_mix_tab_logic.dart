import 'package:game_mix/main.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:game_mix/db_game_mix/db_game_mix.dart';

class GameMixTabController extends GetxController {
  final DB db = Get.find<DB>();
  PageController pageController = PageController();
  var currentIndex = 0.obs;

  void changeTabIndex(int index) {
    if (currentIndex.value == index) return;
    currentIndex.value = index;
    var routeName = '';
    switch (index) {
      case 0:
        routeName = '/game_mix_grid_play';
        break;
      case 1:
        routeName = '/game_mix_coin_flip';
        break;
      case 2:
        routeName = '/game_mix_randomizer';
        break;
      case 3:
        routeName = '/game_mix_draw_lots';
        break;
      case 4:
        routeName = '/game_mix_setting';
        break;
      default:
        routeName = '/game_mix_grid_play';
    }
    Get.offNamed(routeName, id: 1);
  }

  Widget getPage(String? routeName) {
    if (routeName == '/') {
      routeName = '/game_mix_grid_play';
    }
    final page = Road.firstWhere(
      (element) => element.name == routeName,
    );
    return page.page();
  }

  Bindings? getBinding(String? routeName) {
    if (routeName == '/') {
      routeName = '/game_mix_grid_play';
    }
    final page = Road.firstWhere(
      (element) => element.name == routeName,
    );
    return page.binding;
  }
}
