import 'package:chat_app/data/models/room_model.dart';

import '../models/message_model.dart';
import '../models/user_model.dart';

abstract class FirebaseRemoteDataSource {
  Future<void> addUserToFireStore(UserModel userModel);

  Future<UserModel?> getUserFromFireStore(String userId);

  Future<void> addRoomToFireStore(RoomModel roomModel);

  Stream<List<RoomModel?>> getAllRoomsFromFireStore();

  Future<void> insertMessage(MessageModel messageModel);

  Stream<List<MessageModel?>> getMessages(String roomId);
}
