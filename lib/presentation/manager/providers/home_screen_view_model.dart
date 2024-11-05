import 'package:chat_app/domain/entities/room_entity.dart';
import 'package:chat_app/domain/use_cases/get_all_rooms_use_case.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

@injectable
class HomeScreenViewModel extends ChangeNotifier {
  //holding data
  List<RoomEntity> roomsList = [];
  GetAllRoomsUseCase getAllRoomsUseCase;

  HomeScreenViewModel({required this.getAllRoomsUseCase});

  Stream<List<RoomEntity?>> getRooms() {
    return getAllRoomsUseCase.call();
  }
}
