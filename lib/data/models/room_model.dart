import 'package:chat_app/domain/entities/room_entity.dart';

class RoomModel extends RoomEntity {
  RoomModel({
    required super.roomId,
    required super.title,
    required super.description,
    required super.categoryId,
  });

  RoomModel.fromJson(Map<String, dynamic> jsonData)
      : this(
          roomId: jsonData['roomId'],
          title: jsonData['title'],
          description: jsonData['description'],
          categoryId: jsonData['categoryId'],
        );

  Map<String, dynamic> toJson() {
    return {
      "roomId": roomId,
      "title": title,
      "description": description,
      "categoryId": categoryId
    };
  }
}
