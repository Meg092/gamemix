import 'package:flutter/material.dart';
import 'package:game_mix/components/game_mix_text_field.dart';
import 'package:game_mix/main.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'game_mix_randomizer_logic.dart';

class GameMixRandomizerPage extends GetView<GameMixRandomizerController> {
  const GameMixRandomizerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
                SizedBox(height: 40.h),
                Text(
                  "Random Number",
                  style: TextStyle(
                    fontSize: 27.sp,
                    color: Color(0xFF0F0F0F),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 23.h),
                Row(
                  children: [
                    Expanded(
                      child: _buildBoundInput(
                        'lower bound',
                        controller.lowerBound,
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Transform.translate(
                      offset: Offset(0, 10.h),
                      child: Text(
                        '～',
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: Color(0xFF0F0F0F),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Expanded(
                      child: _buildBoundInput(
                        'upper bound',
                        controller.upperBound,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10.h),
                Row(
                  children: [
                    Expanded(
                      child: _buildBoundInput('Count', controller.count),
                    ),
                    SizedBox(width: 34.w),
                    Expanded(child: SizedBox.shrink()),
                  ],
                ),
                _buildNoRepeatCheckbox(),
                SizedBox(height: 86.h),
                _buildResultDisplay(),
                SizedBox(height: 70.h),
                _buildActionButtons(),
                SizedBox(height: 20.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBoundInput(String title, RxInt value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 14.sp,
            color: Color(0xFF0F0F0F),
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10.h),
        SizedBox(
          height: 40.h,
          child: Transform.translate(
            offset: Offset(0, -4.h),
            child: GameMixTextField(
              value: value.toString(),
              hintText: '0',
              textAlign: TextAlign.center,
              onChange: (v) {
                if (v.isEmpty) {
                  value.value = 0;
                } else {
                  try {
                    value.value = int.parse(v);
                  } catch (e) {
                    value.value = 0;
                  }
                }
              },
              keyboardType: TextInputType.number,
              isNumber: true,
              isInteger: true,
              bgColor: Colors.white,
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xFFD1D1D1), width: 1),
                borderRadius: BorderRadius.circular(4.r),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildNoRepeatCheckbox() {
    return Obx(
      () => Transform.translate(
        offset: Offset(-8.w, 0),
        child: Row(
          children: [
            Transform.scale(
              scale: 0.9,
              child: Checkbox(
                value: controller.noRepeat.value,
                onChanged: (value) => controller.noRepeat.value = value ?? true,
                activeColor: primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4.r),
                ),
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
            ),
            Text(
              'Numbers do not repeat.',
              style: TextStyle(
                fontSize: 14.sp,
                color: Color(0xFF0F0F0F),
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildResultDisplay() {
    return Obx(() {
      if (controller.randomNumbers.isEmpty) {
        return Container(
          height: 80.h,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.8),
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: Color(0xFFD1D1D1), width: 1),
          ),
          child: Center(
            child: Text(
              'Click the button to start',
              style: TextStyle(
                fontSize: 16.sp,
                color: Color(0xFF999999),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        );
      }

      return Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 16.w),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.9),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: Color(0xFFD1D1D1), width: 1),
        ),
        child: Text(
          controller.randomNumbers.join(' '),
          style: TextStyle(
            fontSize: 24.sp,
            color: Color(0xFF0F0F0F),
            fontWeight: FontWeight.bold,
            height: 1.2,
          ),
          textAlign: TextAlign.center,
        ),
      );
    });
  }

  Widget _buildActionButtons() {
    return Row(
      children: [
        Expanded(
          child: SizedBox(
            height: 57.h,
            child: ElevatedButton(
              onPressed: () => controller.startGame(),
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
              onPressed: () => controller.copyResult(),
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
                'Copy',
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
