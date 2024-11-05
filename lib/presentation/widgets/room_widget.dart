import 'package:chat_app/core/utils/font_constants.dart';
import 'package:chat_app/core/utils/text_style_manager.dart';
import 'package:chat_app/domain/entities/room_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/utils/colors.dart';

class RoomWidget extends StatelessWidget {
  RoomEntity? room;

  RoomWidget({super.key, required this.room});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0.sp),
      child: Material(
        elevation: 5.0.sp,
        borderRadius: BorderRadius.circular(15),
        child: Container(
          padding: EdgeInsets.all(10),
          width: 142.w,
          height: 180.h,
          decoration: BoxDecoration(
            color: ColorManager.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.asset(
                'assets/images/${room?.categoryId}.png',
                width: 86.w,
                height: 90.h,
                fit: BoxFit.fill,
              ),
              Text(
                room?.title ?? '',
                style: getTextStyle(
                    fontSize: FontSize.s16,
                    fontWeight: FontWeightManager.medium,
                    color: ColorManager.black,
                    fontFamily: FontConstants.poppins),
              )
            ],
          ),
        ),
      ),
    );
  }
}
