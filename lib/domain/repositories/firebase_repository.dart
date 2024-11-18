import 'package:chat_app/domain/entities/message_entity.dart';
import 'package:chat_app/domain/entities/room_entity.dart';
import 'package:chat_app/domain/entities/user_entity.dart';

abstract class FirebaseRepository {
  Future<void> addUserToFireStore(UserEntity userEntity);

  Future<UserEntity?> getUserFromFireStore(String userId);

  Future<void> addRoomToFireStore(RoomEntity room);

  Stream<List<RoomEntity?>> getAllRoomsFromFireStore();

  Future<void> insertMessage(MessageEntity messageEntity);

  Stream<List<MessageEntity?>> getMessages(String roomId);
}
