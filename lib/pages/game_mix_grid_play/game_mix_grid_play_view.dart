import 'package:flutter/material.dart';
import 'package:game_mix/main.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'game_mix_grid_play_logic.dart';

class GameMixGridPlayPage extends GetView<GameMixGridPlayController> {
  const GameMixGridPlayPage({super.key});

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
          child: Obx(
            () =>
                controller.gridList.isEmpty
                    ? Center(child: CircularProgressIndicator())
                    : Column(
                      children: [
                        _buildHeader(),
                        SizedBox(height: 16.h),
                        _buildGrid(),
                        SizedBox(height: 24.h),
                        _buildActionButtons(),
                      ],
                    ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        SizedBox(height: 52.h),
        Image.asset('assets/grid.png', width: 53.w, height: 53.h),
        SizedBox(height: 14.h),
        Text(
          controller.getGridItem(0).value,
          style: TextStyle(
            fontSize: 27.sp,
            fontWeight: FontWeight.bold,
            color: Color(0xFF0F0F0F),
          ),
        ),
        Text(
          controller.getGridItem(controller.selectedGridIndex.value).value,
          style: TextStyle(
            fontSize: 30.sp,
            fontWeight: FontWeight.w900,
            color: Colors.black,
          ),
        ),
      ],
    );
  }

  Widget _buildGrid() {
    return SizedBox(
      height: 345.h,
      child: GridView.builder(
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 1,
        ),
        itemCount: 9,
        itemBuilder: (context, index) {
          final isSelected = controller.selectedGridIndex.value == index + 1;
          final isLightYellow = index % 2 == 0;

          return Container(
            decoration: BoxDecoration(
              color:
                  isLightYellow
                      ? const Color(0xFFF3F0D1)
                      : const Color(0xFFC6E0E5),
              border:
                  isSelected
                      ? Border.all(color: primaryColor, width: 10)
                      : null,
            ),
            child: Center(
              child: Text(
                controller.getGridItem(index + 1).value,
                style: TextStyle(
                  fontSize: 26.sp,
                  fontWeight: FontWeight.w900,
                  color: Colors.black,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildActionButtons() {
    return Row(
      children: [
        Expanded(
          child: SizedBox(
            height: 57.h,
            child: ElevatedButton(
              onPressed: controller.startGame,
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(29.r),
                ),
                elevation: 0,
              ),
              child: Text(
                'Start game',
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
        SizedBox(width: 16.w),
        Expanded(
          child: SizedBox(
            height: 57.h,
            child: ElevatedButton(
              onPressed: controller.editGrid,
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(29.r),
                ),
                elevation: 0,
              ),
              child: Text(
                'Edit',
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
