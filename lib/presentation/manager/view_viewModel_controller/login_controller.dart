abstract class LoginController {
  void hideLoading();

  void showLoading();

  void showMessage(String msgTitle, {String? error = ''});
}
