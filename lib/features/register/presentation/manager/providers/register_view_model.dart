import 'package:chat_app/features/register/presentation/manager/providers/register_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import '../../../../../core/utils/strings.dart';

class RegisterViewModel extends ChangeNotifier {
  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController confirmPassController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  late RegisterController controller;

  void createUser(
      {required String emailAddress, required String password}) async {
    if (formKey.currentState?.validate() == true) {
      controller.showLoading(AppStrings.loading);
      try {
        final credential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailAddress,
          password: password,
        );
        controller.hideLoading();
        controller.showMessage(
            AppStrings.registerSuccessful, AppStrings.success,
            posActionName: AppStrings.Continue);
      } on FirebaseAuthException catch (e) {
        if (e.code == AppStrings.weakPassword) {
          controller.hideLoading();
          controller.showMessage(AppStrings.weakPassMsg, AppStrings.failed,
              posActionName: AppStrings.close);
        } else if (e.code == AppStrings.existingEmail) {
          controller.hideLoading();
          controller.showMessage(AppStrings.existingEmailMsg, AppStrings.failed,
              posActionName: AppStrings.close);
        }
      } catch (e) {
        controller.hideLoading();
        controller.showMessage(e.toString(), AppStrings.failed,
            posActionName: AppStrings.close);
      }
    }
  }
}