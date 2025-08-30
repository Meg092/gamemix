import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'game_mix_draw_lots_history_logic.dart';

class GameMixDrawLotsHistoryPage
    extends GetView<GameMixDrawLotsHistoryController> {
  const GameMixDrawLotsHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('yyyy-MM-dd');

    return Scaffold(
      appBar: AppBar(title: Text('Draw Lots History')),
      body: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFE5E5FF), Color(0xFFFFFFFF)],
          ),
        ),
        child: SingleChildScrollView(
          child: Obx(
            () =>
                <Widget>[
                  if (controller.drawLots.value.isEmpty)
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(40.w),
                      margin: EdgeInsets.only(top: 40.h),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16.r),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.08),
                            blurRadius: 12,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Container(
                            width: 80.w,
                            height: 80.w,
                            decoration: BoxDecoration(
                              color: Color(0xFFE3F2FD),
                              borderRadius: BorderRadius.circular(40.r),
                            ),
                            child: Icon(
                              Icons.auto_awesome,
                              color: Color(0xFF2196F3),
                              size: 40.sp,
                            ),
                          ),
                          SizedBox(height: 20.h),
                          Text(
                            'No Good Things Yet',
                            style: TextStyle(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF333333),
                            ),
                          ),
                          SizedBox(height: 8.h),
                          Text(
                            'Start capturing your daily moments of joy!',
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: Color(0xFF666666),
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    )
                  else
                    ...controller.drawLots.value.map((drawLot) {
                      return Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(19.w),
                        margin: EdgeInsets.only(bottom: 14.h),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        child: <Widget>[
                          Text(dateFormat.format(drawLot.createdAt!))
                              .textColor(Color(0xFF2282F2))
                              .fontSize(18.sp)
                              .fontWeight(FontWeight.w600),
                          SizedBox(height: 12.h),
                          Text(
                            '${drawLot.result} (${(drawLot.probability * 100).toInt()}%)',
                          ).textColor(Color(0xFF5D5D5D)).fontSize(14.sp),
                        ].toColumn(
                          crossAxisAlignment: CrossAxisAlignment.start,
                        ),
                      );
                    }),
                ].toColumn(),
          ),
        ),
      ),
    );
  }
}
