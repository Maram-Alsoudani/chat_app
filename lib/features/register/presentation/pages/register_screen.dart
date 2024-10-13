import 'package:chat_app/core/reusable_components/app_validators.dart';
import 'package:chat_app/core/reusable_components/base_screen_layout.dart';
import 'package:chat_app/core/reusable_components/custom_text_form_field.dart';
import 'package:chat_app/core/utils/colors.dart';
import 'package:chat_app/core/utils/font_constants.dart';
import 'package:chat_app/core/utils/strings.dart';
import 'package:chat_app/core/utils/text_style_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/reusable_components/custom_elevated_button.dart';

class RegisterScreen extends StatefulWidget {
  RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  var formKey = GlobalKey<FormState>();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController confirmPassController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BaseScreenLayout(
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
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                CustomTextFormField(
                  label: AppStrings.fullName,
                  validator: (val) => AppValidators.validateFullName(val),
                  controller: fullNameController,
                ),
                CustomTextFormField(
                  label: AppStrings.email,
                  validator: (val) => AppValidators.validateEmail(val),
                  controller: emailController,
                ),
                CustomTextFormField(
                  label: AppStrings.password,
                  validator: (val) => AppValidators.validatePassword(val),
                  controller: passController,
                ),
                CustomTextFormField(
                  label: AppStrings.confirmPassword,
                  validator: (val) => AppValidators.validateConfirmPassword(
                      val, passController),
                  controller: confirmPassController,
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
                  onClicked: () {},
                  child:
                      Text(AppStrings.registerButton), // Add a register button
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
