import 'package:get/get.dart';
import 'dart:math';

import 'package:game_mix/db_game_mix/db_game_mix.dart';
import 'package:flutter/material.dart';

class GameMixCoinFlipController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final DB db = Get.find<DB>();
  final isCrown = false.obs;
  final RxBool isFlipping = false.obs;

  final RxInt crownCount = 0.obs;
  final RxInt smileyCount = 0.obs;

  late AnimationController animationController;
  late Animation<double> flipAnimation;

  @override
  void onInit() async {
    super.onInit();
    animationController = AnimationController(
      duration: Duration(milliseconds: 1500),
      vsync: this,
    );

    flipAnimation = Tween<double>(begin: 0.0, end: 6 * pi).animate(
      CurvedAnimation(parent: animationController, curve: Curves.easeIn),
    );
  }

  @override
  void onClose() {
    animationController.dispose();
    super.onClose();
  }

  void startFlip() {
    if (isFlipping.value) return;

    isFlipping.value = true;
    final bool finalIsCrown = Random().nextBool();

    animationController.forward().then((_) {
      isFlipping.value = false;
      isCrown.value = finalIsCrown;

      if (isCrown.value) {
        smileyCount.value++;
      } else {
        crownCount.value++;
      }
      Get.snackbar(
        'Coin Flip Result',
        isCrown.value ? 'Smiley' : 'Crown',
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 1),
        backgroundColor: const Color(0xFF6873F7).withOpacity(0.9),
        colorText: Colors.white,
      );
      animationController.reset();
    });
  }

  void resetGame() {
    crownCount.value = 0;
    smileyCount.value = 0;
    isFlipping.value = false;

    Get.snackbar(
      'Reset Complete',
      'Coin count has been reset',
      snackPosition: SnackPosition.BOTTOM,
      duration: Duration(seconds: 1),
      backgroundColor: Color(0xFF6873F7).withOpacity(0.9),
      colorText: Colors.white,
    );
  }
}
