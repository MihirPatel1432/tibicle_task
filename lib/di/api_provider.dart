import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutterprojectsetup/di/app_component_base.dart';
import 'package:flutterprojectsetup/ui/common/api_client.dart';
import 'package:flutterprojectsetup/ui/common/app_exception.dart';
import 'package:flutterprojectsetup/ui/common/strings.dart';
import 'package:get/get.dart';

abstract class IApiProvider {
  Future<Response<T>> postMethod<T>(String? url, dynamic body,
      {String? contentType,
      Map<String, String>? headers,
      Map<String, dynamic>? query,
      Decoder<T>? decoder,
      Progress? uploadProgress});

  Future<Response<T>> getMethod<T>(String url,
      {Map<String, String>? headers,
      String? contentType,
      Map<String, dynamic>? query,
      Decoder<T>? decoder});

  Future<Response<T>> putMethod<T>(String url, dynamic body,
      {String? contentType,
      Map<String, String>? headers,
      Map<String, dynamic>? query,
      Decoder<T>? decoder,
      Progress? uploadProgress});

  Future<Response<T>> patchMethod<T>(String url, dynamic body,
      {String? contentType,
      Map<String, String>? headers,
      Map<String, dynamic>? query,
      Decoder<T>? decoder,
      Progress? uploadProgress});

  Future<Response<T>> requestMethod<T>(String url, String method,
      {dynamic body,
      String? contentType,
      Map<String, String>? headers,
      Map<String, dynamic>? query,
      Decoder<T>? decoder,
      Progress? uploadProgress});

  Future<Response<T>> deleteMethod<T>(String url,
      {Map<String, String>? headers,
      String? contentType,
      Map<String, dynamic>? query,
      Decoder<T>? decoder});
}

class ApiProvider extends GetConnect implements IApiProvider {
  @override
  void onInit() {
    httpClient.baseUrl = ApiClient.baseUrl;
  }

  @override
  Future<Response<T>> postMethod<T>(String? url, body,
      {String? contentType,
      Map<String, String>? headers,
      Map<String, dynamic>? query,
      decoder,
      uploadProgress}) async {
    debugPrint('url: ${httpClient.baseUrl}$url\nrequest: $body');
    if (await AppComponentBase.getInstance()
            ?.getNetworkManager()
            .isConnected() ??
        false) {
      try {
        Response<T> response = await post(url, body,
            contentType: contentType,
            headers: headers,
            decoder: decoder,
            query: query,
            uploadProgress: uploadProgress);
        debugPrint('Response: ${response.bodyString}');
        return response;
      } catch (exception) {
        if (exception is SocketException) {
          throw CustomException(StringConstants.noInternetConnection);
        }
        rethrow;
      }
    } else {
      throw CustomException(StringConstants.noInternetConnection);
    }
  }

  @override
  Future<Response<T>> getMethod<T>(String url,
      {Map<String, String>? headers,
      String? contentType,
      Map<String, dynamic>? query,
      decoder}) async {
    debugPrint('url: ${httpClient.baseUrl}$url');
    if (await AppComponentBase.getInstance()
            ?.getNetworkManager()
            .isConnected() ??
        false) {
      try {
        Response<T> response = await get(url,
            contentType: contentType,
            headers: headers,
            decoder: decoder,
            query: query);
        debugPrint('Response: ${response.body}');
        return response;
      } catch (exception) {
        if (exception is SocketException) {
          throw CustomException(StringConstants.noInternetConnection);
        }
        rethrow;
      }
    } else {
      throw CustomException(StringConstants.noInternetConnection);
    }
  }

  @override
  Future<Response<T>> putMethod<T>(String url, body,
      {String? contentType,
      Map<String, String>? headers,
      Map<String, dynamic>? query,
      decoder,
      uploadProgress}) async {
    debugPrint('url: ${httpClient.baseUrl}$url\nrequest: $body');
    if (await AppComponentBase.getInstance()
            ?.getNetworkManager()
            .isConnected() ??
        false) {
      try {
        Response<T> response = await put(url, body,
            contentType: contentType,
            headers: headers,
            decoder: decoder,
            query: query,
            uploadProgress: uploadProgress);
        debugPrint('Response: ${response.body}');
        return response;
      } catch (exception) {
        if (exception is SocketException) {
          throw CustomException(StringConstants.noInternetConnection);
        }
        rethrow;
      }
    } else {
      throw CustomException(StringConstants.noInternetConnection);
    }
  }

  @override
  Future<Response<T>> patchMethod<T>(String url, body,
      {String? contentType,
      Map<String, String>? headers,
      Map<String, dynamic>? query,
      decoder,
      uploadProgress}) async {
    debugPrint('url: ${httpClient.baseUrl}$url\nrequest: $body');
    if (await AppComponentBase.getInstance()
            ?.getNetworkManager()
            .isConnected() ??
        false) {
      try {
        Response<T> response = await patch(url, body,
            contentType: contentType,
            headers: headers,
            decoder: decoder,
            query: query,
            uploadProgress: uploadProgress);
        debugPrint('Response: ${response.body}');
        return response;
      } catch (exception) {
        if (exception is SocketException) {
          throw CustomException(StringConstants.noInternetConnection);
        }
        rethrow;
      }
    } else {
      throw CustomException(StringConstants.noInternetConnection);
    }
  }

  @override
  Future<Response<T>> requestMethod<T>(String url, String method,
      {body,
      String? contentType,
      Map<String, String>? headers,
      Map<String, dynamic>? query,
      decoder,
      uploadProgress}) async {
    debugPrint('url: ${httpClient.baseUrl}$url\nrequest: $body');
    if (await AppComponentBase.getInstance()
            ?.getNetworkManager()
            .isConnected() ??
        false) {
      try {
        Response<T> response = await request(url, body,
            contentType: contentType,
            headers: headers,
            decoder: decoder,
            query: query,
            uploadProgress: uploadProgress);
        debugPrint('Response: ${response.body}');
        return response;
      } catch (exception) {
        if (exception is SocketException) {
          throw CustomException(StringConstants.noInternetConnection);
        }
        rethrow;
      }
    } else {
      throw CustomException(StringConstants.noInternetConnection);
    }
  }

  @override
  Future<Response<T>> deleteMethod<T>(String url,
      {Map<String, String>? headers,
      String? contentType,
      Map<String, dynamic>? query,
      decoder}) async {
    debugPrint('url: ${httpClient.baseUrl}$url');
    if (await AppComponentBase.getInstance()
            ?.getNetworkManager()
            .isConnected() ??
        false) {
      try {
        Response<T> response = await delete(url,
            contentType: contentType,
            headers: headers,
            decoder: decoder,
            query: query);
        debugPrint('Response: ${response.body}');
        return response;
      } catch (exception) {
        if (exception is SocketException) {
          throw CustomException(StringConstants.noInternetConnection);
        }
        rethrow;
      }
    } else {
      throw CustomException(StringConstants.noInternetConnection);
    }
  }
}
