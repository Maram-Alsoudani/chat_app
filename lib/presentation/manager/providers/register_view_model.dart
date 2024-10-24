import 'package:chat_app/domain/entities/user_entity.dart';
import 'package:chat_app/domain/use_cases/add_user_use_case.dart';
import 'package:chat_app/presentation/manager/view_viewModel_controller/register_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/utils/strings.dart';

@injectable
class RegisterViewModel extends ChangeNotifier {
  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController confirmPassController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  late RegisterController controller;
  AddUserUseCase addUserUseCase;

  RegisterViewModel({required this.addUserUseCase});

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
        //Save user
        UserEntity user = UserEntity(
            id: credential.user?.uid ?? "",
            email: emailAddress,
            fullName: fullNameController.text);
        var savedUserData = await addUserUseCase.call(user);
        //hide loading - show message
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