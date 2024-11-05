abstract class RegisterController {
  void hideLoading();

  void showLoading();

  void showMessage(String msgTitle, {String? error = ''});
}