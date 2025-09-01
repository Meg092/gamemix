import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'game_mix_config_logic.dart';

class GameMixConfigView extends GetView<GameMixConfigLogic> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Obx(
          () => controller.swaniawski.value
              ? CircularProgressIndicator(color: Colors.blue[800])
              : buildError(),
        ),
      ),
    );
  }

  Widget buildError() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            onPressed: () {
              controller.ltwrg();
            },
            icon: const Icon(
              Icons.restart_alt,
              size: 50,
            ),
          ),
        ],
      ),
    );
  }
}
