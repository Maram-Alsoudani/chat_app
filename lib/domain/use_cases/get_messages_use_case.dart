import 'package:chat_app/domain/repositories/firebase_repository.dart';
import 'package:injectable/injectable.dart';

import '../entities/message_entity.dart';

@injectable
class GetMessagesUseCase {
  FirebaseRepository firebaseRepository;

  GetMessagesUseCase({required this.firebaseRepository});

  Stream<List<MessageEntity?>> call(String roomId) {
    return firebaseRepository.getMessages(roomId);
  }
}
