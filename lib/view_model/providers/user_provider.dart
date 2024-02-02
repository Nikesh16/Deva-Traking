import 'package:Deva_Tracking/model/app_repository/export_app_repo.dart';
import 'package:flutter/material.dart';
import 'package:Deva_Tracking/model/app_models/memberList.dart';
import 'package:Deva_Tracking/model/app_models/message_model.dart';
import 'package:Deva_Tracking/model/app_repository/user_repo.dart';

class UserProvider extends ChangeNotifier {
  final UserRepository _userRepo = UserRepository();

  String? errorForgenerate;
  bool? isUserLogin;
  String? errorForLogin;
  bool? iserrorForgenerate;
  Future<bool> loginUser({required Map<String, dynamic> loginDatas}) async {
    final response = await _userRepo.userLogin(loginDatas: loginDatas);

    response.fold((l) => errorForLogin = l, (r) => isUserLogin = r);
    notifyListeners();
    if (isUserLogin != null) {
      return isUserLogin!;
    } else {
      return false;
    }
  }

  Future<bool> generatcode({required Map<String, dynamic> generate}) async {
    final response = await _userRepo.generate(generate: generate);

    response.fold((l) => errorForgenerate = l, (r) => iserrorForgenerate = r);
    notifyListeners();
    if (iserrorForgenerate != null) {
      return iserrorForgenerate!;
    } else {
      return false;
    }
  }

  Future<bool> register({required Map<String, dynamic> register}) async {
    final response = await _userRepo.register(register: register);

    response.fold((l) => errorForLogin = l, (r) => isUserLogin = r);
    notifyListeners();
    if (isUserLogin != null) {
      return isUserLogin!;
    } else {
      return false;
    }
  }

  List<MemberList> memberList = [];
  MemberMetaModel? memberMetaModel;

  Future<MemberMetaModel?> member() async {
    final response = await _userRepo.memberList();

    response.fold((l) => errorForLogin = l, (r) => memberMetaModel = r);

    if (memberMetaModel != null) {
      memberList = memberMetaModel?.members ?? [];
    }
    notifyListeners();

    return memberMetaModel;
  }

  // Future<MessageMetaModel?> messages() async {
  //   final response = await _userRepo.message();

  //   response.fold((l) => errorForLogin = l, (r) => messageMetaModel = r);

  //   if (messageMetaModel != null) {
  //     message = messageMetaModel?.data ?? [];
  //   }
  //   notifyListeners();

  //   return messageMetaModel;
  // }

  // Future<bool> sendmessage({required Map<String, dynamic> message}) async {
  //   final response = await _userRepo.sendmessage(message: message);

  //   response.fold((l) => errorForLogin = l, (r) => isUserLogin = r);
  //   notifyListeners();
  //   if (isUserLogin != null) {
  //     return isUserLogin!;
  //   } else {
  //     return false;
  //   }
  // }

  String? errorForDelete;
  bool? isDeleted;

  Future<bool> deleteuser({required String id}) async {
    final response = await _userRepo.deleteuser(id: id);

    response.fold((l) => errorForDelete = l, (r) => isDeleted = r);
    notifyListeners();

    if (isDeleted != null) {
      return isDeleted!;
    } else {
      return false;
    }
  }

  String? errorFormsgDelete;
  bool? isDeletedmsg;

  Future<bool> deleteusermsg(
      {required Map<String, dynamic> deletedatamsg}) async {
    final response =
        await _userRepo.deleteusermsg(deletedatamsg: deletedatamsg);

    response.fold((l) => errorForDelete = l, (r) => isDeleted = r);
    notifyListeners();

    if (isDeleted != null) {
      return isDeleted!;
    } else {
      return false;
    }
  }

  bool? isupdate;
  String? errorforupdate;

  Future<bool> update({required String id, dynamic datas}) async {
    final response = await _userRepo.update(id: id, datas: datas);

    response.fold((l) => errorforupdate = l, (r) => isupdate = r);
    notifyListeners();
    if (isupdate != null) {
      return isupdate!;
    } else {
      return false;
    }
  }

  bool? islogout;
  String? errorlogout;

  Future<bool> logout() async {
    final response = await _userRepo.logout();

    response.fold((l) => errorlogout = l, (r) => islogout = r);
    notifyListeners();
    if (islogout != null) {
      return islogout!;
    } else {
      return false;
    }
  }
}
