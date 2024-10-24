import 'package:chat_app/domain/entities/user_entity.dart';
import 'package:chat_app/domain/repositories/firebase_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetUserUseCase {
  FirebaseRepository firebaseRepository;

  GetUserUseCase({required this.firebaseRepository});

  Future<UserEntity?> call(String userId) async {
    return firebaseRepository.getUserFromFireStore(userId);
  }
}
