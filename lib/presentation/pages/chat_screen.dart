import 'package:chat_app/core/utils/strings.dart';
import 'package:chat_app/core/utils/text_style_manager.dart';
import 'package:chat_app/domain/entities/room_entity.dart';
import 'package:chat_app/presentation/manager/providers/chat_screen_view_model.dart';
import 'package:chat_app/presentation/manager/providers/user_provider.dart';
import 'package:chat_app/presentation/manager/view_viewModel_controller/chat_controller.dart';
import 'package:chat_app/presentation/widgets/message_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../core/reusable_components/base_screen_layout.dart';
import '../../core/reusable_components/dialog_utils.dart';
import '../../core/utils/colors.dart';
import '../../core/utils/font_constants.dart';
import '../../di/di.dart';

class ChatScreen extends StatefulWidget {
  RoomEntity room;

  ChatScreen({super.key, required this.room});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> implements ChatController {
  ChatScreenViewModel viewModel = getIt<ChatScreenViewModel>();

  @override
  void initState() {
    super.initState();
    viewModel.controller = this;
  }

  @override
  Widget build(BuildContext context) {
    viewModel.room = widget.room;
    var provider = Provider.of<UserProvider>(context);
    viewModel.user = provider.user!;
    viewModel.receiveMessage();
    return ChangeNotifierProvider(
      create: (context) => viewModel,
      child: BaseScreenLayout(
          scaffold: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          iconTheme: IconThemeData(
            color: Colors.white, // Change the color to whatever you prefer
          ),
          title: Text(
            widget.room?.title ?? '',
            style: getTextStyle(
                fontSize: FontSize.s20,
                fontWeight: FontWeightManager.bold,
                color: ColorManager.white,
                fontFamily: FontConstants.poppins),
          ),
        ),
        body: Center(
          child: Material(
            elevation: 5.0,
            borderRadius: BorderRadius.circular(20),
            child: Container(
              padding: EdgeInsets.all(10),
              width: 335.w,
              height: 700.h,
              decoration: BoxDecoration(
                color: ColorManager.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  Expanded(
                      child: StreamBuilder(
                          stream: viewModel.receiveMessage(),
                          builder: (context, asyncSnapshot) {
                            if (asyncSnapshot.hasError) {
                              return Center(
                                child:
                                    Text("Error Occurred at loading messages"),
                              );
                            } else if (asyncSnapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(
                                child: CircularProgressIndicator(
                                  color: ColorManager.primaryColor,
                                ),
                              );
                            } else {
                              final messagesList = asyncSnapshot.data ?? [];
                              return ListView.builder(
                                  itemCount: messagesList.length,
                                  itemBuilder: (context, index) {
                                    final isCurrentUser =
                                        messagesList[index]?.senderId ==
                                            provider.user!.id;
                                    return MessageWidget(
                                        isSender: isCurrentUser,
                                        msg: messagesList[index]);
                                  });
                            }
                          })),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: viewModel.messageController,
                          cursorColor: ColorManager.grey,
                          maxLines: null,
                          decoration: InputDecoration(
                              hintText: "Type a message..",
                              hintStyle: getTextStyle(
                                  fontSize: FontSize.s14,
                                  fontWeight: FontWeightManager.regular,
                                  color: ColorManager.grey,
                                  fontFamily: FontConstants.poppins),
                              enabled: true,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25),
                                  borderSide: BorderSide(
                                    color: ColorManager.lightGrey,
                                  )),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25),
                                  borderSide: BorderSide(
                                    color: ColorManager.grey,
                                  ))),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          viewModel.sendMessage();
                        },
                        child: Icon(
                          Icons.send,
                          color: ColorManager.white,
                        ),
                        style: ButtonStyle(
                            padding: WidgetStatePropertyAll(EdgeInsets.all(0)),
                            shape: WidgetStatePropertyAll(CircleBorder()),
                            backgroundColor: WidgetStatePropertyAll(
                                ColorManager.primaryColor)),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      )),
    );
  }

  @override
  void showMessage(String msgTitle, {String? error = ''}) {
    if (msgTitle == AppStrings.success) {
      DialogUtils.showMessage(
          context: context,
          message: AppStrings.success,
          title: AppStrings.success);
    } else {
      DialogUtils.showMessage(
          context: context, message: error!, title: AppStrings.failed);
    }
  }
}
