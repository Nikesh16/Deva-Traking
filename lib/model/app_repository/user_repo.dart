// ignore_for_file: unnecessary_brace_in_string_interps

import 'package:bot_toast/bot_toast.dart';
import 'package:dio/dio.dart';
import 'package:Deva_Tracking/model/app_models/memberList.dart';
import 'package:Deva_Tracking/view/components/custom_bottoast.dart';
import 'package:Deva_Tracking/view_model/config/storage.dart';
import 'package:Deva_Tracking/view_model/utils/constant.dart';
import 'package:fpdart/fpdart.dart';

import '../app_models/message_model.dart';
import '../export_model.dart';

class UserRepository {
  final UserRequest _userRequest = UserRequest();

  ///USER LOGIN
  EitherFunction<bool> userLogin(
      {required Map<String, dynamic> loginDatas}) async {
    loading();
    try {
      final response = await _userRequest.loginUser(loginDatas: loginDatas);

      BotToast.closeAllLoading();
      showBotToast(text: "Вы успешно вошли в систему");

      String? accessToken = response.data?["access_token"].toString();
      String? userType = response.data?["user"]?["type"].toString();
      String? userName = response.data["user"]?["name"].toString();
      String? id = response.data["user"]?["id"].toString();

      if (accessToken != null) {
        SecureStorage.setData(AppConstant.accessToken, accessToken);
      }
      if (userType != null) {
        SecureStorage.setData(AppConstant.usertype, userType);
      }
      if (userName != null) {
        SecureStorage.setData(AppConstant.username, userName);
      }
      String? photo = response.data["user"]?["photo"].toString();

      if (photo != null) {
        final photof = "https://$photo";
        SecureStorage.setData(AppConstant.photo1, photof);
      }

      if (id != null) {
        SecureStorage.setData(AppConstant.id, id);
      }

      return right(true);
    } on DioException catch (e) {
      BotToast.closeAllLoading();
      showBotToast(text: "${e.response?.data["message"]}", isError: true);

      return left(e.toString());
    } catch (e) {
      BotToast.closeAllLoading();
      showBotToast(text: "$e", isError: true);
      return left(e.toString());
    }
  }

  ///USER LOGIN
  EitherFunction<bool> generate(
      {required Map<String, dynamic> generate}) async {
    loading();
    try {
      final response = await _userRequest.generate(generate: generate);

      BotToast.closeAllLoading();
      showBotToast(text: "успешно сгенерирован новый код");

      return right(true);
    } on DioException catch (e) {
      BotToast.closeAllLoading();
      showBotToast(text: "${e.response?.data["message"]}", isError: true);
      showBotToast(text: "${e.response?.data["message"]}", isError: true);

      return left(e.toString());
    } catch (e) {
      BotToast.closeAllLoading();
      showBotToast(text: "$e", isError: true);
      return left(e.toString());
    }
  }

  // EitherFunction<bool> register(
  //     {required Map<String, dynamic> register}) async {
  //   loading();
  //   try {
  //     final response = await _userRequest.memberegister(registerForm: register);

  //     BotToast.closeAllLoading();
  //     showBotToast(text: "register sucessufully ");
  //     return right(true);
  //   } on DioException catch (e) {
  //     BotToast.closeAllLoading();
  //     print(e.response);

  //     return left("An unexpected error occurred");
  //   } catch (e) {
  //     BotToast.closeAllLoading();
  //     final errorMessage = "$e";
  //     showBotToast(text: errorMessage, isError: true);
  //     return left(e.toString());
  //   }
  // }
  EitherFunction<bool> register(
      {required Map<String, dynamic> register}) async {
    loading();
    try {
      final response = await _userRequest.memberegister(registerForm: register);

      BotToast.closeAllLoading();

      return right(true);
    } on DioException catch (e) {
      BotToast.closeAllLoading();
      showBotToast(text: "${e.response?.data["message"]}", isError: true);

      return left(e.toString());
    } catch (e) {
      BotToast.closeAllLoading();
      showBotToast(text: "$e", isError: true);
      return left(e.toString());
    }
  }

  EitherFunction<MemberMetaModel> memberList() async {
    loading();
    try {
      final response = await _userRequest.memberList();

      BotToast.closeAllLoading();
      return right(MemberMetaModel.fromMap(response.data));
    } on DioException catch (e) {
      BotToast.closeAllLoading();
      return Left(e.response?.data["message"]);
    } catch (e) {
      return left(e.toString());
    }
  }

  EitherFunction<MessageMetaModel> message() async {
    // loading();
    try {
      final response = await _userRequest.message();

      BotToast.closeAllLoading();
      return right(MessageMetaModel.fromMap(response.data));
    } on DioException catch (e) {
      BotToast.closeAllLoading();
      return Left(e.response?.data["message"]);
    } catch (e) {
      return left(e.toString());
    }
  }

  EitherFunction<bool> sendmessage(
      {required Map<String, dynamic> message}) async {
    loading();
    try {
      final response = await _userRequest.sendmessage(message: message);

      BotToast.closeAllLoading();
      // showBotToast(text: "Вы успешно вошли в систему");

      return right(true);
    } on DioException catch (e) {
      BotToast.closeAllLoading();
      showBotToast(text: "${e.response?.data["message"]}", isError: true);

      return left(e.toString());
    } catch (e) {
      BotToast.closeAllLoading();
      showBotToast(text: "$e", isError: true);
      return left(e.toString());
    }
  }

  EitherFunction<bool> deleteuser({required String id}) async {
    loading();
    try {
      final response = await _userRequest.deleteUser(id: id);

      // Check if the delete request was successful (you may need to adjust this condition based on the response structure)
      if (response.statusCode == 200) {
        BotToast.closeAllLoading();
        showBotToast(text: "пользователь успешно удален");
        return right(true);
      } else {
        BotToast.closeAllLoading();
        showBotToast(text: "ошибка при удалении пользователя", isError: true);
        return right(false);
      }
    } on DioException catch (e) {
      BotToast.closeAllLoading();
      showBotToast(text: "${e.response?.data["message"]}", isError: true);
      return left(e.toString());
    } catch (e) {
      BotToast.closeAllLoading();
      showBotToast(text: "$e", isError: true);
      return left(e.toString());
    }
  }

  EitherFunction<bool> deleteusermsg(
      {required Map<String, dynamic> deletedatamsg}) async {
    loading();
    try {
      final response =
          await _userRequest.deleteusermsg(deletedatamsg: deletedatamsg);

      // Check if the delete request was successful (you may need to adjust this condition based on the response structure)
      if (response.statusCode == 200) {
        BotToast.closeAllLoading();
        showBotToast(text: "сообщение пользователя успешно удалено");
        return right(true);
      } else {
        BotToast.closeAllLoading();
        showBotToast(
            text: "не удалось удалить сообщение пользователя ", isError: true);
        return right(false);
      }
    } on DioException catch (e) {
      BotToast.closeAllLoading();
      showBotToast(text: "${e.response?.data["message"]}", isError: true);
      return left(e.toString());
    } catch (e) {
      BotToast.closeAllLoading();
      showBotToast(text: "$e", isError: true);
      return left(e.toString());
    }
  }

  EitherFunction<bool> update({required String id, dynamic datas}) async {
    loading();
    try {
      final response = await _userRequest.update(datas: datas, id: id);

      // BotToast.closeAllLoading();
      // showBotToast(text: "профиль успешно обновлен");

      String? photo = response.data["data"]?["photo"].toString();

      if (photo != null) {
        final photof = "https://${photo}";
        SecureStorage.setData(AppConstant.photo1, photof);
      }

      return right(true);
    } on DioException catch (e) {
      BotToast.closeAllLoading();
      showBotToast(text: "${e.response?.data["message"]}", isError: true);

      return left(e.toString());
    } catch (e) {
      BotToast.closeAllLoading();
      showBotToast(text: "$e", isError: true);
      return left(e.toString());
    }
  }

  EitherFunction<bool> logout() async {
    loading();
    try {
      final response = await _userRequest.logout();

      BotToast.closeAllLoading();

      return right(true);
    } on DioException catch (e) {
      BotToast.closeAllLoading();
      // showBotToast(text: "${e.response?.data["message"]}", isError: true);

      return left(e.toString());
    } catch (e) {
      BotToast.closeAllLoading();
      showBotToast(text: "$e", isError: true);
      return left(e.toString());
    }
  }

  EitherFunction<bool> picMsg({dynamic message}) async {
    loading();
    try {
      final response = await _userRequest.picMsg(
        message: message,
      );
      BotToast.closeAllLoading();

      return right(true);
    } on DioException catch (e) {
      BotToast.closeAllLoading();
      // showBotToast(text: "${e.response?.data["message"]}", isError: true);

      return left(e.toString());
    } catch (e) {
      BotToast.closeAllLoading();
      showBotToast(text: "$e", isError: true);
      return left(e.toString());
    }
  }
}
