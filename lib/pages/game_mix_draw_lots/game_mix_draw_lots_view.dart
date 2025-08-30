import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:game_mix/main.dart';

import 'game_mix_draw_lots_logic.dart';

class GameMixDrawLotsgPage extends GetView<GameMixDrawLotsController> {
  const GameMixDrawLotsgPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height,
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFFE5E5FF), Color(0xFFFFFFFF)],
          stops: [0.0, 0.6],
        ),
      ),
      child: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildHeader(),
              SizedBox(height: 54.h),
              _buildDrawTubes(),
              SizedBox(height: 28.h),
              _buildRemainingTimes(),
              SizedBox(height: 28.h),
              _buildDrawResult(),
              SizedBox(height: 38.h),
              _buildStartButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        SizedBox(height: 40.h),
        Text(
          "Draw Lots Game",
          style: TextStyle(
            fontSize: 27.sp,
            color: Color(0xFF0F0F0F),
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildDrawTubes() {
    return Obx(
      () => Transform.translate(
        offset: Offset(controller.animationValue.value, 0),
        child:
            controller.remainingTimes.value > 0
                ? Image.asset('assets/un_drawn.png', width: 82.w, height: 200.h)
                : Image.asset('assets/drawn.png', width: 82.w, height: 200.h),
      ),
    );
  }

  Widget _buildRemainingTimes() {
    return Obx(
      () => Text(
        "Todays remaining times: ${controller.remainingTimes.value}",
        style: TextStyle(
          fontSize: 14.sp,
          color: Color(0xFF0F0F0F),
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildDrawResult() {
    return Obx(
      () =>
          controller.drawLot.value != null
              ? Text(
                "${controller.drawLot.value!.result} (${(controller.drawLot.value!.probability * 100).toInt()}%)",
                style: TextStyle(
                  fontSize: 27.sp,
                  color: Color(0xFF0F0F0F),
                  fontWeight: FontWeight.bold,
                ),
              )
              : SizedBox(height: 38.h),
    );
  }

  Widget _buildStartButton() {
    return SizedBox(
      width: double.infinity,
      height: 57.h,
      child: Obx(
        () => ElevatedButton(
          onPressed: controller.startDraw,
          style: ElevatedButton.styleFrom(
            backgroundColor:
                (controller.remainingTimes.value > 0 &&
                        !controller.isDrawing.value)
                    ? primaryColor
                    : Colors.grey[300],
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25.r),
            ),
            elevation: 0,
          ),
          child: Text(
            controller.isDrawing.value ? 'Drawing...' : 'Start',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
