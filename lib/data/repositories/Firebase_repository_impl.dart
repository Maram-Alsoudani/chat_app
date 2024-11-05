import 'package:chat_app/data/data_sources/firebase_remote_data_source.dart';
import 'package:chat_app/data/models/room_model.dart';
import 'package:chat_app/domain/entities/room_entity.dart';
import 'package:chat_app/domain/entities/user_entity.dart';
import 'package:chat_app/domain/repositories/firebase_repository.dart';
import 'package:injectable/injectable.dart';

import '../models/user_model.dart';

@Injectable(as: FirebaseRepository)
class FirebaseRepositoryImpl implements FirebaseRepository {
  FirebaseRemoteDataSource firebaseRemoteDataSource;

  FirebaseRepositoryImpl({required this.firebaseRemoteDataSource});

  @override
  Future<void> addUserToFireStore(UserEntity userEntity) async {
    final userModel = UserModel(
      id: userEntity.id,
      fullName: userEntity.fullName,
      email: userEntity.email,
    );
    return firebaseRemoteDataSource.addUserToFireStore(userModel);
  }

  @override
  Future<UserEntity?> getUserFromFireStore(String userId) {
    return firebaseRemoteDataSource.getUserFromFireStore(userId);
  }

  @override
  Future<void> addRoomToFireStore(RoomEntity room) {
    final roomModel = RoomModel(
        roomId: room.roomId,
        title: room.title,
        description: room.description,
        categoryId: room.categoryId);
    return firebaseRemoteDataSource.addRoomToFireStore(roomModel);
  }

  @override
  Stream<List<RoomEntity?>> getAllRoomsFromFireStore() {
    return firebaseRemoteDataSource.getAllRoomsFromFireStore();
  }
}
