import 'package:chat_app/config/routes.dart';
import 'package:chat_app/core/reusable_components/app_validators.dart';
import 'package:chat_app/core/reusable_components/base_screen_layout.dart';
import 'package:chat_app/core/reusable_components/custom_text_form_field.dart';
import 'package:chat_app/core/reusable_components/dialog_utils.dart';
import 'package:chat_app/core/utils/colors.dart';
import 'package:chat_app/core/utils/font_constants.dart';
import 'package:chat_app/core/utils/strings.dart';
import 'package:chat_app/core/utils/text_style_manager.dart';
import 'package:chat_app/di/di.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../core/reusable_components/custom_elevated_button.dart';
import '../manager/providers/register_view_model.dart';
import '../manager/view_viewModel_controller/register_controller.dart';

class RegisterScreen extends StatefulWidget {
  RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen>
    implements RegisterController {
  //Field Injection
  RegisterViewModel viewModel = getIt<RegisterViewModel>();

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
              AppStrings.registerTitle,
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
                  CustomTextFormField(
                    label: AppStrings.fullName,
                    validator: (val) => AppValidators.validateFullName(val),
                    controller: viewModel.fullNameController,
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
                  CustomTextFormField(
                    label: AppStrings.confirmPassword,
                    validator: (val) => AppValidators.validateConfirmPassword(
                        val, viewModel.passController),
                    controller: viewModel.confirmPassController,
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
                      viewModel.createUser(
                          emailAddress: viewModel.emailController.text,
                          password: viewModel.passController.text);
                    },
                    child: Text(
                        AppStrings.registerButton), // Add a register button
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, Routes.loginScreenRoute);
                      },
                      child: Text(
                        AppStrings.alreadyHaveAnAcc,
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
  void showLoading(String message) {
    DialogUtils.showLoading(context: context, message: message);
  }

  @override
  void showMessage(String message, String title,
      {String? posActionName, Function? posAction}) {
    DialogUtils.showMessage(
        context: context,
        message: message,
        title: title,
        posActionName: posActionName,
        posAction: posActionName == AppStrings.Continue
            ? () => Navigator.pushNamed(context, Routes.loginScreenRoute)
            : () => Navigator.pop(context));
  }
}