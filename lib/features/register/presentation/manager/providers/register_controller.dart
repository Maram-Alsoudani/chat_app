abstract class RegisterController {
  void hideLoading();

  void showLoading(
    String message,
  );

  void showMessage(String message, String title,
      {String posActionName, Function posAction});
}
