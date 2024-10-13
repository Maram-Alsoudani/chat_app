import 'package:flutter/material.dart';

import '../utils/colors.dart';
import '../utils/font_constants.dart';
import '../utils/text_style_manager.dart';

class CustomTextFormField extends StatefulWidget {
  final String label;
  final TextEditingController controller;
  final String? Function(String?) validator;
  final TextInputType keyboardType;
  final bool? isSecured;

  CustomTextFormField({
    required this.label,
    required this.validator,
    required this.controller,
    this.keyboardType = TextInputType.text,
    this.isSecured = false,
  });

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  late bool _isSecured;

  @override
  void initState() {
    super.initState();
    _isSecured = widget.isSecured ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: TextFormField(
        style: getTextStyle(
            fontSize: FontSize.s16,
            fontWeight: FontWeightManager.regular,
            color: ColorManager.black,
            fontFamily: FontConstants.poppins),
        controller: widget.controller,
        keyboardType: widget.keyboardType,
        validator: widget.validator,
        obscureText: _isSecured,
        cursorColor: ColorManager.grey,
        decoration: InputDecoration(
          label: Text(widget.label),
          labelStyle: getTextStyle(
              fontSize: FontSize.s16,
              fontWeight: FontWeightManager.regular,
              color: ColorManager.grey,
              fontFamily: FontConstants.poppins),
          helperStyle: TextStyle(color: ColorManager.grey),
          // fillColor: ColorManager.white,
          // filled: true,
          suffixIcon: widget.isSecured == true
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      _isSecured = !_isSecured;
                    });
                  },
                  icon: Icon(
                    _isSecured ? Icons.visibility_off : Icons.visibility,
                    color: ColorManager.primaryColor,
                  ),
                )
              : null,
          border: UnderlineInputBorder(
            borderSide: BorderSide(color: ColorManager.grey),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: ColorManager.primaryColor),
          ),
          errorBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: ColorManager.red),
          ),
          focusedErrorBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: ColorManager.red),
          ),
        ),
      ),
    );
  }
}
