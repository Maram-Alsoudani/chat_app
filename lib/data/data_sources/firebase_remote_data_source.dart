import '../models/user_model.dart';

abstract class FirebaseRemoteDataSource {
  Future<void> addUserToFireStore(UserModel userModel);

  Future<UserModel?> getUserFromFireStore(String userId);
}
