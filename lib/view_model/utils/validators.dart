import 'package:flutter/material.dart';

class Validators {
  static String? emailValidator(String? input) {
    if (input!.isEmpty) {
      return "Требуется электронная почта";
    }
    bool isValid = RegExp(
            "^[a-zA-Z0-9.a-zA-Z0-9.!#%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(input);
    if (!isValid) {
      return "Пожалуйста, введите действительный адрес электронной почты";
    }
    return null;
  }

  static String? isRequiredValidator(String? input, {String? validatorTitle}) {
    if (input!.isEmpty) {
      return validatorTitle ?? "Это поле обязательно ";
    }
    return null;
  }

  static String? nameValidator(String? input) {
    if (input!.isEmpty) {
      return "Это поле обязательно ";
    }
    if (input.length < 2) {
      return "Вводимые данные не кажутся допустимыми";
    }
    return null;
  }

  static String? passwordValidator(String? input) {
    bool isValid = RegExp(r"(?=.*[a-z])(?=.*[A-Z])\w+").hasMatch(input!);
    if (input.isEmpty) {
      return "Требуется пароль";
    }
    if (input.length < 8) {
      return "Пароль должен содержать не менее 8 символов";
    }

    return null;
  }

  static String? phoneValidator(String? input) {
    if (input!.isEmpty) {
      return "Требуется телефон";
    }
    bool isValid = RegExp(r"^(?:[+0]9)?[0-9]{10}$").hasMatch(input);
    if (!isValid) {
      return "Введите действительный номер телефона";
    }
    return null;
  }

  static String? phoneNoRequiredValidator(String? input) {
    if (input!.isEmpty) {
      return null;
    }
    bool isValid = RegExp(r"^(?:[+0]9)?[0-9]{10}$").hasMatch(input);
    if (!isValid) {
      return "Введите действительный номер телефона";
    }
    return null;
  }

  static validateAndSave(formKey) {
    final FormState? form = formKey.currentState;
    if (form!.validate()) {
      return true;
    } else {
      return false;
    }
  }

  static changePasswordValidaator(String? newPass, String? confirmPass) {
    if (confirmPass!.isEmpty) {
      return "Требуется пароль";
    } else if (newPass != confirmPass) {
      return "Пароли не совпадают";
    } else {
      return null;
    }
  }
}
