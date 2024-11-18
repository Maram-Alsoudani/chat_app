import 'package:chat_app/core/reusable_components/app_validators.dart';
import 'package:chat_app/core/reusable_components/base_screen_layout.dart';
import 'package:chat_app/core/reusable_components/custom_text_form_field.dart';
import 'package:chat_app/core/reusable_components/dialog_utils.dart';
import 'package:chat_app/core/utils/colors.dart';
import 'package:chat_app/core/utils/font_constants.dart';
import 'package:chat_app/core/utils/strings.dart';
import 'package:chat_app/core/utils/text_style_manager.dart';
import 'package:chat_app/di/di.dart';
import 'package:chat_app/domain/entities/user_entity.dart';
import 'package:chat_app/presentation/manager/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../config/routes.dart';
import '../../../core/reusable_components/custom_elevated_button.dart';
import '../manager/providers/login_view_model.dart';
import '../manager/view_viewModel_controller/login_controller.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> implements LoginController {
  LoginViewModel viewModel = getIt<LoginViewModel>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewModel.controller = this;
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => viewModel,
      child: BaseScreenLayout(
        scaffold: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              AppStrings.loginTitle,
              style: getTextStyle(
                  fontSize: FontSize.s20,
                  fontWeight: FontWeightManager.bold,
                  fontFamily: FontConstants.poppins,
                  color: ColorManager.white),
            ),
          ),
          body: Form(
            key: viewModel.formKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    AppStrings.welcomeBack,
                    style: getTextStyle(
                        fontSize: FontSize.s20,
                        fontWeight: FontWeightManager.bold,
                        fontFamily: FontConstants.poppins,
                        color: ColorManager.black),
                  ),
                  CustomTextFormField(
                    label: AppStrings.email,
                    validator: (val) => AppValidators.validateEmail(val),
                    controller: viewModel.emailController,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  CustomTextFormField(
                    label: AppStrings.password,
                    validator: (val) => AppValidators.validatePassword(val),
                    controller: viewModel.passController,
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  CustomElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            WidgetStateProperty.all(ColorManager.primaryColor),
                        foregroundColor:
                            WidgetStateProperty.all(ColorManager.white),
                        shape: WidgetStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)))),
                    onClicked: () {
                      viewModel.signIn(
                          emailAddress: viewModel.emailController.text,
                          password: viewModel.passController.text);
                    },
                    child:
                        Text(AppStrings.loginButton), // Add a register button
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.pushNamed(
                            context, Routes.registerScreenRoute);
                      },
                      child: Text(
                        AppStrings.doNotHaveAnAcc,
                        style: getTextStyle(
                            fontSize: FontSize.s12,
                            fontWeight: FontWeightManager.regular,
                            color: ColorManager.primaryColor,
                            fontFamily: FontConstants.poppins),
                      ))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void hideLoading() {
    DialogUtils.hideLoading(context);
  }

  @override
  void showLoading() {
    DialogUtils.showLoading(context: context, message: AppStrings.loading);
  }

  @override
  void showMessage(String msgTitle, {UserEntity? user, String? error = ''}) {
    if (msgTitle == AppStrings.success) {
      //saving logged in user will be done during navigating to home
      var userProvider = Provider.of<UserProvider>(context, listen: false);
      userProvider.user = user;
      DialogUtils.showMessage(
          context: context,
          message: AppStrings.loginSuccessful,
          title: AppStrings.success,
          posActionName: AppStrings.Continue,
          posAction: () {
            Navigator.pushReplacementNamed(context, Routes.homeScreenRoute);
          });
    } else if (msgTitle == AppStrings.failed && error != '') {
      DialogUtils.showMessage(
        context: context,
        message: error!,
        title: AppStrings.failed,
        posActionName: AppStrings.close,
      );
    }
  }
}
