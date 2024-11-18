import 'package:chat_app/core/utils/colors.dart';
import 'package:chat_app/core/utils/font_constants.dart';
import 'package:chat_app/core/utils/text_style_manager.dart';
import 'package:chat_app/domain/entities/message_entity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class MessageWidget extends StatelessWidget {
  final bool isSender;
  final MessageEntity? msg;

  const MessageWidget({
    super.key,
    required this.isSender,
    required this.msg,
  });

  @override
  Widget build(BuildContext context) {
    String formattedTime = formatMessageTime(msg?.dateTime ?? 0);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Column(
        crossAxisAlignment:
            isSender ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          isSender
              ? Container(
                  padding: EdgeInsets.all(15),
                  constraints: BoxConstraints(
                      // maxWidth: 250.w,
                      minHeight: 50.h,
                      minWidth: 50.h),
                  decoration: BoxDecoration(
                      color: ColorManager.primaryColor,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(20),
                        topLeft: Radius.circular(20),
                        bottomLeft: Radius.circular(20),
                      )),
                  child: Text(
                    msg?.content ?? '',
                    style: getTextStyle(
                        fontSize: FontSize.s14,
                        fontWeight: FontWeightManager.regular,
                        color: ColorManager.white,
                        fontFamily: FontConstants.poppins),
                  ),
                )
              : Container(
                  padding: EdgeInsets.all(15),
                  constraints: BoxConstraints(
                      // maxWidth: 250.w,
                      minHeight: 50.h,
                      minWidth: 50.h),
                  decoration: BoxDecoration(
                      color: ColorManager.lightGrey,
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(20),
                        topLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                      )),
                  child: Text(
                    msg?.content ?? '',
                    style: getTextStyle(
                        fontSize: FontSize.s14,
                        fontWeight: FontWeightManager.regular,
                        color: ColorManager.black,
                        fontFamily: FontConstants.poppins),
                  ),
                ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              formattedTime,
              style: getTextStyle(
                  fontSize: FontSize.s10,
                  fontWeight: FontWeightManager.regular,
                  color: ColorManager.black,
                  fontFamily: FontConstants.poppins),
            ),
          )
        ],
      ),
    );
  }

  String formatMessageTime(int timestamp) {
    // Convert the timestamp from milliseconds to DateTime
    final dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp);

    // Format the DateTime to "mm:ss"
    return DateFormat('h:m a').format(dateTime);
  }
}
