import 'package:chat_app/domain/entities/room_entity.dart';
import 'package:chat_app/domain/repositories/firebase_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetAllRoomsUseCase {
  FirebaseRepository firebaseRepository;

  GetAllRoomsUseCase({required this.firebaseRepository});

  Stream<List<RoomEntity?>> call() {
    return firebaseRepository.getAllRoomsFromFireStore();
  }
}
