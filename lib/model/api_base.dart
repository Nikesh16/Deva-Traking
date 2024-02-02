import 'dart:math';

import 'package:Deva_Tracking/model/api_endpoints.dart';
import 'package:Deva_Tracking/view/components/custom_bottoast.dart';
import 'package:Deva_Tracking/view/screens/auth%20screens/login.dart';
import 'package:Deva_Tracking/view/screens/auth%20screens/register.dart';
import 'package:Deva_Tracking/view_model/config/routes.dart';
import 'package:Deva_Tracking/view_model/config/storage.dart';
import 'package:Deva_Tracking/view_model/utils/constant.dart';
import 'package:Deva_Tracking/view_model/utils/logs.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';

import 'package:fpdart/fpdart.dart';

typedef EitherFunction<T> = Future<Either<String, T>>;

class ApiBase {
  static final _dio = Dio(BaseOptions(baseUrl: AppEndpoint.baseUrl));

  var headerRequests = {
    'Accept': 'application/json',
    'Content-Type': 'application/json',
  };

  static Future<void> _dioInterceptor() async {
    debugPrint("dddd");
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          debugPrint("${options.uri}");
          if (options.connectTimeout?.inSeconds == 60) {
            BotToast.closeAllLoading();
            showBotToast(text: "Connection Timed Out");
          }
          return handler.next(options);
        },
        onResponse: (response, handler) {
          return handler.next(response);
        },
        onError: (DioException e, handler) async {
          CustomLog.error(e.toString());

          try {
            if (e.response?.statusCode == 401) {
              BotToast.closeAllLoading();
              GoRouteNavigation().goRouter.push(LoginScreen.routeName);
              // showBotToast(text: "${e.response?.statusMessage}", isError: true);
            } else if (e.response?.statusCode == 417) {
              BotToast.closeAllLoading();
              GoRouteNavigation().goRouter.push(LoginScreen.routeName,
                  extra: const FlutterErrorDetails(
                      exception: "Forbidden !! \n Permission not given "));
              showBotToast(
                  text: "inavlid input field please fill again ",
                  isError: true);
            } else if (e.response?.statusCode == 422) {
              BotToast.closeAllLoading();
              showBotToast(
                  text: "${e.response?.data["message"]}", isError: true);
              debugPrint("${e.response}");
            } else if (e.response?.statusCode == 500) {
              BotToast.closeAllLoading();
              GoRouteNavigation().goRouter.push(LoginScreen.routeName,
                  extra: const FlutterErrorDetails(exception: "Server Error"));
            }
          } catch (ew) {
            CustomLog.error(e.toString());
            handler.reject(e);
          }
        },
      ),
    );
  }

  Future<Response> getRequest({
    required String path,
    Map<String, dynamic>? queryParameters,
  }) async {
    debugPrint("geeettttttttt inside heree");
    String? token = await SecureStorage.getData(AppConstant.accessToken);

    headerRequests["Authorization"] = "Bearer $token";

    await _dioInterceptor();

    // print(headerRequests);

    var response = await _dio.get(
      path,
      options: Options(
        headers: headerRequests,
      ),
      queryParameters: queryParameters,
    );
    return response;
  }

  Future<Response> getRequestWithoutToken({
    required String path,
    Map<String, dynamic>? queryParameters,
  }) async {
    debugPrint("geeettttttttt");

    var response = await _dio.get(path, queryParameters: queryParameters);
    return response;
  }

  Future<Response> postRequestWithToken({
    required String path,
    required dynamic data,
  }) async {
    String? token = await SecureStorage.getData(AppConstant.accessToken);

    headerRequests["Authorization"] = "Bearer $token";

    await _dioInterceptor();
    debugPrint("after interpreting");
    var response = await _dio.post(
      path,
      data: data,
      options: Options(
        headers: headerRequests,
      ),
    );

    debugPrint("$response");
    debugPrint("$token");
    return response;
  }

  Future<Response> putRequestWithToken({
    required String path,
    required dynamic data,
  }) async {
    String? token = await SecureStorage.getData(AppConstant.accessToken);

    headerRequests["Authorization"] = "Bearer $token";

    await _dioInterceptor();
    debugPrint("after interpreting");

    var response = await _dio.put(
      path,
      data: data,
      options: Options(
        headers: headerRequests,
      ),
    );

    debugPrint("$response");
    return response;
  }

  Future<Response> deleteWithToken({
    required String path,
    required dynamic data,
  }) async {
    String? token = await SecureStorage.getData(AppConstant.accessToken);

    headerRequests["Authorization"] = "Bearer $token";

    await _dioInterceptor();
    debugPrint("after interpreting");
    var response = await _dio.delete(
      path,
      data: data,
      options: Options(
        headers: headerRequests,
      ),
    );

    debugPrint("$response");
    return response;
  }

  Future<Response> postRequestWithoutToken({
    required String path,
    required dynamic data,
  }) async {
    var response = await _dio.post(
      path,
      data: data,
    );

    debugPrint("\n$response");
    return response;
  }

  Future<Response> patchRequest({
    required String path,
    required dynamic data,
  }) async {
    // print("Patchhh");
    String? token = await SecureStorage.getData(AppConstant.accessToken);

    headerRequests["Authorization"] = "Bearer $token";

    await _dioInterceptor();
    debugPrint("after interpreting");
    var response = await _dio.patch(
      path,
      data: data,
      options: Options(
        headers: headerRequests,
      ),
    );

    debugPrint("$response");
    return response;
  }
}
