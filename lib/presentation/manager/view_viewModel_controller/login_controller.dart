import 'package:chat_app/domain/entities/user_entity.dart';

abstract class LoginController {
  void hideLoading();

  void showLoading();

  void showMessage(String msgTitle, {UserEntity? user, String? error = ''});
}
