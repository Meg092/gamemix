import 'package:flutter/material.dart';
import 'package:game_mix/db_game_mix/game_mix_util.dart';
import 'package:get/get.dart';
import 'dart:math';
import 'package:flutter/services.dart';

import 'package:game_mix/db_game_mix/db_game_mix.dart';

class GameMixRandomizerController extends GetxController {
  final DB db = Get.find<DB>();

  final lowerBound = 1.obs;
  final upperBound = 1.obs;
  final count = 1.obs;
  final noRepeat = true.obs;

  final randomNumbers = <int>[].obs;

  void generateRandomNumbers() {
    try {
      int lower = lowerBound.value;
      int upper = upperBound.value;
      int numCount = count.value;

      if (lower > upper) {
        Get.snackbar(
          'Error',
          'Lower bound cannot be greater than upper bound',
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 1),
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        return;
      }

      if (noRepeat.value && (upper - lower + 1) < numCount) {
        Get.snackbar(
          'Error',
          'Cannot generate non-repeating random numbers within the specified range',
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 1),
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        return;
      }

      List<int> numbers = [];

      if (noRepeat.value) {
        List<int> range = List.generate(
          upper - lower + 1,
          (index) => lower + index,
        );
        range.shuffle();
        numbers = range.take(numCount).toList();
      } else {
        Random random = Random();
        for (int i = 0; i < numCount; i++) {
          numbers.add(lower + random.nextInt(upper - lower + 1));
        }
      }

      randomNumbers.value = numbers;
    } catch (e) {
      errorToast('Please enter a valid number');
    }
  }

  void copyResult() {
    if (randomNumbers.isEmpty) {
      errorToast('Please generate random numbers first');
      return;
    }

    String result = randomNumbers.join(' ');
    Clipboard.setData(ClipboardData(text: result));

    successToast('Copied to clipboard');
  }

  void startGame() {
    randomNumbers.value = [];
    generateRandomNumbers();
  }
}
