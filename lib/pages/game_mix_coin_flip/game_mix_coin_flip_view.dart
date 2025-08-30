import 'package:flutter/material.dart';
import 'package:game_mix/main.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:math';
import 'game_mix_coin_flip_logic.dart';

class GameMixCoinFlipPage extends GetView<GameMixCoinFlipController> {
  const GameMixCoinFlipPage({super.key});

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
              SizedBox(height: 80.h),
              _buildLargeCoins(),
              SizedBox(height: 64.h),
              _buildCoinCounters(),
              SizedBox(height: 76.h),
              _buildActionButtons(),
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
          "Coin Game",
          style: TextStyle(
            fontSize: 27.sp,
            color: Color(0xFF0F0F0F),
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildLargeCoins() {
    return GestureDetector(
      onTap: controller.startFlip,
      child: AnimatedBuilder(
        animation: controller.flipAnimation,
        builder: (context, child) {
          final angle = controller.flipAnimation.value;
          final normalizedAngle = angle % (2 * pi);
          bool isFrontVisible =
              controller.isCrown.value
                  ? (normalizedAngle < pi / 2 || normalizedAngle >= 3 * pi / 2)
                  : !(normalizedAngle < pi / 2 ||
                      normalizedAngle >= 3 * pi / 2);

          return Transform(
            alignment: Alignment.center,
            transform:
                Matrix4.identity()
                  ..setEntry(3, 2, 0.001)
                  ..rotateY(angle),
            child:
                isFrontVisible
                    ? Image.asset(
                      'assets/coin_front.png',
                      width: 156.w,
                      height: 150.h,
                    )
                    : Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.identity()..rotateY(pi),
                      child: Image.asset(
                        'assets/coin_back.png',
                        width: 156.w,
                        height: 150.h,
                      ),
                    ),
          );
        },
      ),
    );
  }

  Widget _buildCoinCounters() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          children: [
            Container(
              width: 24.w,
              height: 24.h,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFFFFD700),
              ),
              child: Center(
                child: Image.asset(
                  'assets/coin_back.png',
                  width: 26.w,
                  height: 27.h,
                ),
              ),
            ),
            SizedBox(width: 4.w),
            Obx(
              () => Text(
                '${controller.crownCount.value}',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0F0F0F),
                ),
              ),
            ),
          ],
        ),
        SizedBox(width: 30.w),
        Row(
          children: [
            Container(
              width: 24.w,
              height: 24.h,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFFFFD700),
              ),
              child: Center(
                child: Image.asset(
                  'assets/coin_front.png',
                  width: 26.w,
                  height: 27.h,
                ),
              ),
            ),
            SizedBox(width: 4.w),
            Obx(
              () => Text(
                '${controller.smileyCount.value}',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0F0F0F),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildActionButtons() {
    return Row(
      children: [
        Expanded(
          child: SizedBox(
            height: 57.h,
            child: ElevatedButton(
              onPressed: controller.startFlip,
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25.r),
                ),
                elevation: 0,
              ),
              child: Text(
                'Start',
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ),
        SizedBox(width: 16.w),
        Expanded(
          child: SizedBox(
            height: 57.h,
            child: ElevatedButton(
              onPressed: controller.resetGame,
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25.r),
                ),
                side: BorderSide(color: Color(0xFF6B73FF), width: 1),
                elevation: 0,
              ),
              child: Text(
                'Reset',
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
