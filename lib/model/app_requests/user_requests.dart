import 'package:dio/dio.dart';

import '../export_model.dart';

class UserRequest extends ApiBase {
  Future<Response> loginUser({required Map<String, dynamic> loginDatas}) async {
    final response = await postRequestWithoutToken(
        path: AppEndpoint.login, data: loginDatas);

    return response;
  }

  Future<Response> generate({required Map<String, dynamic> generate}) async {
    final response =
        await postRequestWithToken(path: AppEndpoint.code, data: generate);
    print(response);

    return response;
  }

  Future<Response> memberList() async {
    final response = await getRequest(
      path: AppEndpoint.memberList,
    );

    return response;
  }

  Future<Response> message() async {
    final response = await getRequest(
      path: AppEndpoint.message,
    );
    print(response);

    return response;
  }

  Future<Response> sendmessage({required Map<String, dynamic> message}) async {
    final response =
        await postRequestWithToken(path: AppEndpoint.message, data: message);

    return response;
  }

  Future<Response> logout() async {
    final response =
        await postRequestWithToken(path: AppEndpoint.logout, data: {});

    return response;
  }

  Future<Response> deleteUser({required String id}) async {
    final response =
        await deleteWithToken(path: "${AppEndpoint.delete}$id", data: {});

    return response;
  }

  Future<Response> deleteusermsg(
      {required Map<String, dynamic> deletedatamsg}) async {
    final response = await deleteWithToken(
        path: "${AppEndpoint.deletemsg}", data: deletedatamsg);

    return response;
  }

  Future<Response> memberegister(
      {required Map<String, dynamic> registerForm}) async {
    final response = await postRequestWithoutToken(
        path: AppEndpoint.register, data: registerForm);
    print(response);

    return response;
  }

  Future<Response> update({required String id, dynamic datas}) async {
    final response = await postRequestWithToken(
        path: "${AppEndpoint.updateProfile}id/profile/update", data: datas);

    return response;
  }

  Future<Response> picMsg({dynamic message}) async {
    final response =
        await postRequestWithToken(path: AppEndpoint.message, data: message);
    print(response);

    return response;
  }
}
// /user/:id/profile/update