import 'package:chat_app/core/utils/strings.dart';
import 'package:chat_app/domain/entities/room_entity.dart';
import 'package:chat_app/domain/use_cases/add_room_use_case.dart';
import 'package:chat_app/presentation/manager/view_viewModel_controller/add_room_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';

@injectable
class CreateNewRoomViewModel extends ChangeNotifier {
  // hold data
  TextEditingController roomNameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  AddRoomUseCase addRoomUseCase;
  late AddRoomController addRoomController;

  CreateNewRoomViewModel({required this.addRoomUseCase});

  void createRoom(String categoryId) async {
    if (formKey.currentState!.validate() == true) {
      addRoomController.showLoading();
      RoomEntity room = RoomEntity(
          roomId: "",
          title: roomNameController.text,
          description: descriptionController.text,
          categoryId: categoryId);
      try {
        var roomObj = await addRoomUseCase.call(room);
        addRoomController.hideLoading();
        addRoomController.showMessage(AppStrings.success);
      } catch (e) {
        print(e.toString());
        addRoomController.hideLoading();
        addRoomController.showMessage(
          AppStrings.failed,
          error: e.toString(),
        );
      }
    }
  }
}
