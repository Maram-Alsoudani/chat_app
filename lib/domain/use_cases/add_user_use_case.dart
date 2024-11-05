import 'package:chat_app/domain/entities/user_entity.dart';
import 'package:chat_app/domain/repositories/firebase_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class AddUserUseCase {
  FirebaseRepository firebaseRepository;

  AddUserUseCase({required this.firebaseRepository});

  Future<void> call(UserEntity userEntity) {
    return firebaseRepository.addUserToFireStore(userEntity);
  }
}
