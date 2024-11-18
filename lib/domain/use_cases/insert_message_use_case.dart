import 'package:chat_app/domain/entities/message_entity.dart';
import 'package:chat_app/domain/repositories/firebase_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class InsertMessageUseCase {
  FirebaseRepository firebaseRepository;

  InsertMessageUseCase({required this.firebaseRepository});

  Future<void> call(MessageEntity messageEntity) {
    return firebaseRepository.insertMessage(messageEntity);
  }
}
