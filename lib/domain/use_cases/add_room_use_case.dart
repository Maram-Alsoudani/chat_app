import 'package:chat_app/domain/entities/room_entity.dart';
import 'package:chat_app/domain/repositories/firebase_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class AddRoomUseCase {
  FirebaseRepository firebaseRepository;

  AddRoomUseCase({required this.firebaseRepository});

  Future<void> call(RoomEntity room) {
    return firebaseRepository.addRoomToFireStore(room);
  }
}
