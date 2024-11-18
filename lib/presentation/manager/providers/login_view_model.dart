import 'package:chat_app/domain/use_cases/get_user_use_case.dart';
import 'package:chat_app/presentation/manager/view_viewModel_controller/login_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/utils/strings.dart';

@injectable
class LoginViewModel extends ChangeNotifier {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  late LoginController controller;
  GetUserUseCase getUserUseCase;

  LoginViewModel({required this.getUserUseCase});

  void signIn({required String emailAddress, required String password}) async {
    if (formKey.currentState?.validate() == true) {
      //show loading
      controller.showLoading();
      try {
        final credential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
                email: emailAddress, password: password);
        //retrieve logged in user data
        var userObj = await getUserUseCase.call(credential.user?.uid ?? "");
        if (userObj != null) {
          controller.hideLoading();
          controller.showMessage(AppStrings.success, user: userObj);
        } else {
          controller.hideLoading();
          controller.showMessage(AppStrings.failed,
              error: AppStrings.userNotFoundMsg);
        }
        //hide loading - show message
      } on FirebaseAuthException catch (e) {
        controller.hideLoading();
        if (e.code == AppStrings.invalidCredentials) {
          controller.showMessage(AppStrings.failed,
              error: AppStrings.wrongPasswordMsg);
        }
      } catch (e) {
        controller.hideLoading();
        controller.showMessage(AppStrings.failed, error: e.toString());
      }
    }
  }
}
