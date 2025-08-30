import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:styled_widget/styled_widget.dart';

import './game_mix_setting_logic.dart';

class GameMixSettingPage extends GetView<GameMixSettingController> {
  const GameMixSettingPage({super.key});

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
              SizedBox(height: 26.h),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 19.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildItem(
                      title: 'Clear All Record',
                      onTap: controller.clearAllRecord,
                    ),
                    Divider(color: Color(0xFFE5E5FF)),
                    _buildItem(
                      title: 'Draw Lots History',
                      onTap:
                          () =>
                              Get.toNamed('/game_mix_draw_lots_history'),
                    ),
                    Divider(color: Color(0xFFE5E5FF)),
                    _buildItem(title: 'Version', value: 'v1.0.0'),
                  ],
                ),
              ),
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
          "Setting",
          style: TextStyle(
            fontSize: 27.sp,
            color: Color(0xFF0F0F0F),
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildItem({
    required String title,
    String? value,
    VoidCallback? onTap,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 6.h),
      decoration: BoxDecoration(color: Colors.transparent),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 14.sp,
              color: Color(0xFF0F0F0F),
              fontWeight: FontWeight.w400,
            ),
          ),
          Text(
            value ?? '',
            style: TextStyle(fontSize: 14.sp, color: Color(0xFF0F0F0F)),
          ),
        ],
      ),
    ).gestures(onTap: onTap);
  }
}
