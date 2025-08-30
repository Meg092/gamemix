import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import './game_mix_tab_logic.dart';

class GameMixTabPage extends GetView<GameMixTabController> {
  const GameMixTabPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Navigator(
        key: Get.nestedKey(1),
        onGenerateRoute:
            (settings) => GetPageRoute(
              settings: settings,
              page: () => controller.getPage(settings.name),
              binding: controller.getBinding(settings.name),
              transition: Transition.fade,
            ),
      ),
      bottomNavigationBar: _bottomNavBar(),
    );
  }

  Widget _bottomNavBar() {
    return Obx(
      () => BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Padding(
              padding: EdgeInsets.symmetric(vertical: 2.h),
              child: Image.asset(
                controller.currentIndex.value == 0
                    ? 'assets/tabs/grid_play_active.png'
                    : 'assets/tabs/grid_play.png',
                width: 22.w,
                height: 22.h,
                fit: BoxFit.cover,
              ),
            ),
            label: 'Grid play',
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: EdgeInsets.symmetric(vertical: 2.h),
              child: Image.asset(
                controller.currentIndex.value == 1
                    ? 'assets/tabs/coin_flip_active.png'
                    : 'assets/tabs/coin_flip.png',
                width: 22.w,
                height: 22.h,
                fit: BoxFit.cover,
              ),
            ),
            label: 'Coin flip',
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: EdgeInsets.symmetric(vertical: 2.h),
              child: Image.asset(
                controller.currentIndex.value == 2
                    ? 'assets/tabs/randomizer_active.png'
                    : 'assets/tabs/randomizer.png',
                width: 22.w,
                height: 22.h,
                fit: BoxFit.cover,
              ),
            ),
            label: 'Randomizer',
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: EdgeInsets.symmetric(vertical: 2.h),
              child: Image.asset(
                controller.currentIndex.value == 3
                    ? 'assets/tabs/draw_lots_active.png'
                    : 'assets/tabs/draw_lots.png',
                width: 22.w,
                height: 22.h,
                fit: BoxFit.cover,
              ),
            ),
            label: 'Draw lots',
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: EdgeInsets.symmetric(vertical: 2.h),
              child: Image.asset(
                controller.currentIndex.value == 4
                    ? 'assets/tabs/setting_active.png'
                    : 'assets/tabs/setting.png',
                width: 22.w,
                height: 22.h,
                fit: BoxFit.cover,
              ),
            ),
            label: 'Setting',
          ),
        ],
        currentIndex: controller.currentIndex.value,
        onTap: (index) => controller.changeTabIndex(index),
      ),
    );
  }
}
