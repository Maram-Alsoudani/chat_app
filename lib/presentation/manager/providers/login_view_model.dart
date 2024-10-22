import 'package:chat_app/presentation/manager/view_viewModel_controller/register_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import '../../../../core/utils/strings.dart';

class LoginViewModel extends ChangeNotifier {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();

  var formKey = GlobalKey<FormState>();
  late RegisterController controller;

  void signIn({required String emailAddress, required String password}) async {
    if (formKey.currentState?.validate() == true) {
      controller.showLoading(AppStrings.loading);
      try {
        final credential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
                email: emailAddress, password: password);
        controller.hideLoading();
        controller.showMessage(AppStrings.loginSuccessful, AppStrings.success,
            posActionName: AppStrings.Continue);
        print(credential.user?.uid);
      } on FirebaseAuthException catch (e) {
        controller.hideLoading();
        controller.showMessage(AppStrings.invalidCredentials, AppStrings.failed,
            posActionName: AppStrings.close);
      } catch (e) {
        controller.hideLoading();
        controller.showMessage(e.toString(), AppStrings.failed,
            posActionName: AppStrings.close);
      }
    }
  }
}
