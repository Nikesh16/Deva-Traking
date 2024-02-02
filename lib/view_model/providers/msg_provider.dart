import 'package:Deva_Tracking/model/app_repository/export_app_repo.dart';
import 'package:flutter/material.dart';
import 'package:Deva_Tracking/model/app_models/memberList.dart';
import 'package:Deva_Tracking/model/app_models/message_model.dart';
import 'package:Deva_Tracking/model/app_repository/user_repo.dart';

class MessageProvider extends ChangeNotifier {
  final UserRepository _userRepo = UserRepository();

  String? errorForgenerate;
  bool? isUserLogin;
  String? errorForLogin;
  bool? iserrorForgenerate;

  MessageMetaModel? messageMetaModel;
  List<Message> message = [];

  Future<MessageMetaModel?> messages() async {
    final response = await _userRepo.message();

    response.fold((l) => errorForLogin = l, (r) => messageMetaModel = r);

    if (messageMetaModel != null) {
      message = messageMetaModel?.data ?? [];
    }
    notifyListeners();

    return messageMetaModel;
  }

  Future<bool> sendmessage({required Map<String, dynamic> message}) async {
    final response = await _userRepo.sendmessage(message: message);

    response.fold((l) => errorForLogin = l, (r) => isUserLogin = r);
    notifyListeners();
    if (isUserLogin != null) {
      return isUserLogin!;
    } else {
      return false;
    }
  }

  bool? isupdatepic;
  String? errorforupdatepic;

  Future<bool> picMsg({dynamic message}) async {
    final response = await _userRepo.picMsg(message: message);

    response.fold((l) => errorforupdatepic = l, (r) => isupdatepic = r);
    notifyListeners();
    if (isupdatepic != null) {
      return isupdatepic!;
    } else {
      return false;
    }
  }
}
