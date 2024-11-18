import 'package:chat_app/core/utils/strings.dart';
import 'package:chat_app/domain/entities/message_entity.dart';
import 'package:chat_app/domain/entities/room_entity.dart';
import 'package:chat_app/domain/entities/user_entity.dart';
import 'package:chat_app/domain/use_cases/get_messages_use_case.dart';
import 'package:chat_app/domain/use_cases/insert_message_use_case.dart';
import 'package:chat_app/presentation/manager/view_viewModel_controller/chat_controller.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@injectable
class ChatScreenViewModel extends ChangeNotifier {
  //hold data
  TextEditingController messageController = TextEditingController();
  InsertMessageUseCase insertMessageUseCase;
  GetMessagesUseCase getMessagesUseCase;
  late ChatController controller;
  late UserEntity user;
  late RoomEntity room;

  ChatScreenViewModel(
      {required this.insertMessageUseCase, required this.getMessagesUseCase});

  Future<void> sendMessage() async {
    MessageEntity message = MessageEntity(
        roomId: room.roomId,
        senderId: user.id,
        senderName: user.fullName,
        content: messageController.text,
        dateTime: DateTime.now().millisecondsSinceEpoch);
    try {
      await insertMessageUseCase.call(message);
      messageController.clear();
    } catch (e) {
      controller.showMessage(AppStrings.failed, error: e.toString());
    }
  }

  Stream<List<MessageEntity?>> receiveMessage() {
    return getMessagesUseCase.call(room.roomId);
  }
}
