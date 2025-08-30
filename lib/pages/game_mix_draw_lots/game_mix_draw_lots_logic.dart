import 'package:flutter/material.dart';
import 'package:game_mix/db_game_mix/game_mix_util.dart';
import 'package:get/get.dart';
import 'dart:math';

import 'package:game_mix/db_game_mix/db_game_mix.dart';
import 'package:game_mix/db_game_mix/game_mix_entity.dart';

class GameMixDrawLotsController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final DB db = Get.find<DB>();

  final drawLot = Rxn<DrawLotsEntity>(null);
  final isDrawing = false.obs;
  final remainingTimes = 0.obs;

  late AnimationController _animationController;
  late Animation<double> _shakeAnimation;
  final animationValue = 0.0.obs;

  @override
  void onInit() async {
    super.onInit();

    await getTodayDrawLots();

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 2400),
      vsync: this,
    );

    _shakeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _animationController, curve: _ShakeCurve()),
    )..addListener(() {
      animationValue.value = _shakeAnimation.value;
    });

    _animationController.addStatusListener((status) async {
      if (status == AnimationStatus.completed) {
        await Future.delayed(const Duration(milliseconds: 300));
        _performDraw();
      } else if (status == AnimationStatus.dismissed) {
        animationValue.value = 0.0;
      }
    });
  }

  getTodayDrawLots() async {
    final today = DateTime.now();
    try {
      drawLot.value = await db.getDrawLotsByDate(today);
      if (drawLot.value == null) {
        remainingTimes.value = 1;
        return;
      }
      if (drawLot.value!.result.isEmpty) {
        remainingTimes.value = 1;
      } else {
        remainingTimes.value = 0;
      }
    } catch (e) {
      drawLot.value = null;
      remainingTimes.value = 1;
    }
  }

  startDraw() {
    if (remainingTimes.value <= 0 || isDrawing.value) {
      return;
    }
    isDrawing.value = true;
    animationValue.value = 0.0;
    _animationController.reset();
    _animationController.forward();
  }

  _performDraw() async {
    final random = Random();
    final randomValue = random.nextDouble();

    String result;
    if (randomValue >= 0.5) {
      result = 'Lucky';
    } else {
      result = 'Unlucky';
    }
    final drawLotsEntity = DrawLotsEntity(
      result: result,
      probability: randomValue,
    );

    isDrawing.value = false;
    animationValue.value = 0.0;

    try {
      Get.snackbar(
        'Draw Result',
        result == 'Lucky' ? 'You are lucky' : 'You are unlucky',
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 1),
        backgroundColor: const Color(0xFF6873F7).withOpacity(0.9),
        colorText: Colors.white,
      );
      await db.insertDrawLots(drawLotsEntity);
      await getTodayDrawLots();
    } catch (err) {
      errorToast('Save draw lots error');
    }
  }

  @override
  void onClose() {
    _animationController.dispose();
    super.onClose();
  }
}

class _ShakeCurve extends Curve {
  @override
  double transformInternal(double t) {
    const double maxIntensity = 120.0;
    const double baseFrequency = 12.0;

    double intensity, frequency;
    if (t < 0.6) {
      intensity = maxIntensity * (0.9 + 0.1 * sin(t * 5 * pi));
      frequency = baseFrequency * (1.0 + 0.2 * sin(t * 3 * pi));
    } else {
      double slowProgress = (t - 0.6) / 0.4;
      double decay = 1.0 - slowProgress * slowProgress;
      intensity = maxIntensity * 0.8 * decay;
      frequency = baseFrequency * (0.8 - 0.6 * slowProgress);
    }

    double value = sin(t * frequency * 2 * pi) * intensity;
    double microShake = 3.0 * sin(t * 17 * pi) * exp(-2 * t);

    final result = value + microShake;
    return result;
  }
}
