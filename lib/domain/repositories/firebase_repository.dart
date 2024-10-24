import 'package:chat_app/domain/entities/user_entity.dart';

abstract class FirebaseRepository {
  Future<void> addUserToFireStore(UserEntity userEntity);

  Future<UserEntity?> getUserFromFireStore(String userId);
}
