import 'package:flutter/cupertino.dart';

class AppValidators {
  AppValidators._();

  static String? validateEmail(String? val) {
    if (val == null || val.isEmpty) {
      return "Please enter your email.";
    }
    final bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(val);
    if (!emailValid) {
      return "Email is not valid, pleas enter a valid email.";
    }
    return null;
  }

  static String? validatePassword(String? val) {
    if (val == null || val.isEmpty) {
      return "Please enter your password.";
    }
    if (val.length < 6) {
      return "password should has at least 6 characters.";
    }
    return null;
  }

  static String? validateConfirmPassword(
      String? val, TextEditingController passwordController) {
    if (val == null || val.isEmpty) {
      return "Please confirm password";
    }
    if (passwordController.text != val) {
      return "passwords do not match";
    }
    return null;
  }

  static String? validateFullName(String? val) {
    if (val == null || val.isEmpty) {
      return "Please enter your full name.";
    }
    if (val.length < 2) {
      return "Full name should have at least 2 characters.";
    }
    final bool nameValid = RegExp(r"^[a-zA-Z\s]+$").hasMatch(val);
    if (!nameValid) {
      return "Full name should contain only letters.";
    }
    return null;
  }

  static String? validatePhoneNumber(String? val) {
    if (val == null || val.isEmpty) {
      return "Please enter your phone number.";
    }
    final bool phoneValid = RegExp(r"^\d{11}$").hasMatch(val);
    if (!phoneValid) {
      return "Please enter a valid phone number.";
    }
    return null;
  }
}
