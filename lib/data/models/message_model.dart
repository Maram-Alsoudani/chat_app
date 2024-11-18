import 'package:chat_app/domain/entities/message_entity.dart';

class MessageModel extends MessageEntity {
  MessageModel(
      {required super.messageId,
      required super.roomId,
      required super.senderId,
      required super.senderName,
      required super.content,
      required super.dateTime});

  MessageModel.fromJson(Map<String, dynamic> jsonData)
      : this(
          messageId: jsonData['messageId'] as String,
          roomId: jsonData['roomId'] as String,
          senderId: jsonData['senderId'] as String,
          senderName: jsonData['senderName'] as String,
          content: jsonData['content'] as String,
          dateTime: jsonData['dateTime'] as int,
        );

  Map<String, dynamic> toJson() {
    return {
      "messageId": messageId,
      "roomId": roomId,
      'senderId': senderId,
      'senderName': senderName,
      'content': content,
      'dateTime': dateTime
    };
  }
}
