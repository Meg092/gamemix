import 'package:flutter/material.dart';
import 'package:game_mix/components/game_mix_text_field.dart';
import 'package:game_mix/main.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:styled_widget/styled_widget.dart';

import 'game_mix_set_grid_play_logic.dart';

class GameMixSetGridPlayPage extends GetView<GameMixSetGridPlayController> {
  const GameMixSetGridPlayPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Set up the grid game')),
      body: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: SafeArea(
          child: Obx(
            () =>
                controller.gridList.isEmpty
                    ? Center(child: CircularProgressIndicator())
                    : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildTitle(),
                        SizedBox(height: 18.h),
                        Expanded(child: _buildContent()),
                        SizedBox(height: 18.h),
                        _buildButtons(),
                      ],
                    ),
          ),
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 12.h),
        Text('Project Title')
            .fontSize(14.sp)
            .fontWeight(FontWeight.bold)
            .textColor(Color(0xFF0F0F0F)),
        SizedBox(height: 14.h),
        SizedBox(
          height: 40.h,
          child: Transform.translate(
            offset: Offset(0, -6.h),
            child: GameMixTextField(
              onChange: (v) => controller.updateGridItem(0, v),
              value: controller.getGridItem(0).value,
              textAlign: TextAlign.center,
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent),
                borderRadius: BorderRadius.circular(4.w),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: primaryColor),
                borderRadius: BorderRadius.circular(4.w),
              ),
              bgColor: Color(0xFFF2F3FF),
              textStyle: TextStyle(
                color: primaryColor,
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildContent() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 18.w),
      decoration: BoxDecoration(
        color: Color(0xFFF8F8F8),
        borderRadius: BorderRadius.circular(4.r),
      ),
      child: ListView.builder(
        shrinkWrap: true,
        physics: const AlwaysScrollableScrollPhysics(),
        itemCount: 9,
        itemBuilder: (context, index) {
          return _buildCard(
            index: index + 1,
            value: controller.getGridItem(index + 1).value,
            onChange: (v) => controller.updateGridItem(index + 1, v),
          );
        },
      ),
    );
  }

  Widget _buildCard({
    required int index,
    required String value,
    required Function(String) onChange,
  }) {
    return <Widget>[
      Text('Project $index')
          .fontSize(14.sp)
          .fontWeight(FontWeight.bold)
          .textColor(Color(0xFF0F0F0F)),
      SizedBox(height: 12.h),
      SizedBox(
        height: 40.h,
        child: Transform.translate(
          offset: Offset(0, -6.h),
          child: GameMixTextField(
            onChange: onChange,
            value: value,
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFFD1D1D1)),
              borderRadius: BorderRadius.circular(4.w),
            ),
            bgColor: Colors.white,
            padding: EdgeInsets.symmetric(horizontal: 16.w),
          ),
        ),
      ),
      SizedBox(height: 8.h),
    ].toColumn(crossAxisAlignment: CrossAxisAlignment.start);
  }

  Widget _buildButtons() {
    return Row(
      children: [
        Expanded(
          child: SizedBox(
            height: 57.h,
            child: ElevatedButton(
              onPressed: controller.initGrid,
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(29.r),
                ),
                elevation: 0,
              ),
              child: Text(
                'Initialize',
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
              onPressed: controller.saveGrid,
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(29.r),
                ),
                elevation: 0,
              ),
              child: Text(
                'Save',
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
