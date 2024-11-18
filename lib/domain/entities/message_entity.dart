class MessageEntity {
  String messageId;
  String roomId;
  String senderId;
  String senderName;
  String content;
  int dateTime;

  MessageEntity(
      {this.messageId = '',
      required this.roomId,
      required this.senderId,
      required this.senderName,
      required this.content,
      required this.dateTime});
}
