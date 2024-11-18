import 'package:chat_app/core/reusable_components/app_validators.dart';
import 'package:chat_app/core/reusable_components/base_screen_layout.dart';
import 'package:chat_app/core/reusable_components/custom_elevated_button.dart';
import 'package:chat_app/core/reusable_components/custom_text_form_field.dart';
import 'package:chat_app/core/reusable_components/dialog_utils.dart';
import 'package:chat_app/core/utils/colors.dart';
import 'package:chat_app/core/utils/font_constants.dart';
import 'package:chat_app/core/utils/images.dart';
import 'package:chat_app/core/utils/text_style_manager.dart';
import 'package:chat_app/data/models/room_category_model.dart';
import 'package:chat_app/presentation/manager/providers/create_new_room_view_model.dart';
import 'package:chat_app/presentation/manager/view_viewModel_controller/add_room_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../config/routes.dart';
import '../../core/utils/strings.dart';
import '../../di/di.dart';

class CreateNewRoomScreen extends StatefulWidget {
  CreateNewRoomScreen({super.key});

  @override
  State<CreateNewRoomScreen> createState() => _CreateNewRoomScreenState();
}

class _CreateNewRoomScreenState extends State<CreateNewRoomScreen>
    implements AddRoomController {
  late RoomCategoryModel selectedCategory;

  var categoriesLis = RoomCategoryModel.getCategory();
  CreateNewRoomViewModel viewModel = getIt<CreateNewRoomViewModel>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewModel.addRoomController = this;
    selectedCategory = categoriesLis[0];
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => viewModel,
      child: BaseScreenLayout(
          scaffold: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          iconTheme: IconThemeData(
            color: Colors.white, // Change the color to whatever you prefer
          ),
        ),
        body: Center(
          child: Material(
            elevation: 5.0,
            borderRadius: BorderRadius.circular(20),
            child: Container(
              padding: EdgeInsets.all(10),
              width: 335.w,
              height: 555.h,
              decoration: BoxDecoration(
                color: ColorManager.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Form(
                key: viewModel.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Create New Room",
                      textAlign: TextAlign.center,
                      style: getTextStyle(
                          fontSize: FontSize.s20,
                          fontWeight: FontWeightManager.bold,
                          fontFamily: FontConstants.poppins,
                          color: ColorManager.black),
                    ),
                    Padding(
                      padding: EdgeInsets.all(15.sp),
                      child: Image.asset(
                        AppImages.group,
                        width: 160.w,
                        height: 80.h,
                        fit: BoxFit.fill,
                      ),
                    ),
                    CustomTextFormField(
                      label: 'Room Name',
                      validator: (val) => AppValidators.validateFullName(val),
                      controller: viewModel.roomNameController,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Text(
                          "  Category",
                          textAlign: TextAlign.start,
                          style: getTextStyle(
                              fontSize: FontSize.s16,
                              fontWeight: FontWeightManager.regular,
                              color: ColorManager.grey,
                              fontFamily: FontConstants.poppins),
                        ),
                      ],
                    ),
                    DropdownButton<RoomCategoryModel>(
                      value: selectedCategory,
                      items: categoriesLis
                          .map(
                              (category) => DropdownMenuItem<RoomCategoryModel>(
                                  value: category,
                                  child: Container(
                                    width: 284,
                                    height: 48,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(category.title),
                                        Image.asset(
                                          category.imagePath,
                                          width: 30,
                                          height: 30,
                                          fit: BoxFit.fill,
                                        )
                                      ],
                                    ),
                                  )))
                          .toList(),
                      onChanged: (newCategory) {
                        setState(() {
                          if (newCategory == null) {
                            return;
                          }
                          selectedCategory = newCategory;
                        });
                      },
                      dropdownColor: ColorManager.white,
                    ),
                    CustomTextFormField(
                      label: 'Description',
                      validator: (val) => AppValidators.validateFullName(val),
                      controller: viewModel.descriptionController,
                      maxLines: 3,
                    ),
                    CustomElevatedButton(
                        child: Text('Create',
                            style: getTextStyle(
                                fontSize: FontSize.s16,
                                fontWeight: FontWeightManager.regular,
                                color: ColorManager.white,
                                fontFamily: FontConstants.poppins)),
                        onClicked: () {
                          print(selectedCategory.id);
                          viewModel.createRoom(selectedCategory.id);
                        },
                        style: ButtonStyle(
                            backgroundColor: WidgetStatePropertyAll(
                                ColorManager.primaryColor)))
                  ],
                ),
              ),
            ),
          ),
        ),
      )),
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
  void showMessage(String msgTitle, {String? error = ''}) {
    if (msgTitle == AppStrings.success) {
      DialogUtils.showMessage(
          context: context,
          message: AppStrings.roomISAdded,
          title: AppStrings.success,
          posActionName: AppStrings.Continue,
          posAction: () {
            Navigator.pushNamed(context, Routes.homeScreenRoute);
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
