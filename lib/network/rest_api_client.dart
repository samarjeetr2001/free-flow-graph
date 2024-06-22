import 'package:dio/dio.dart';
import 'package:graphview_plotter/core/app_exception.dart';

class RestClient {
  RestClient._();

  static RestClient? _instance;
  factory RestClient() {
    return _instance ??= RestClient._();
  }

  final _client = Dio();

  Future<dynamic> request({
    required url,
    required RestMethodType requestType,
    dynamic payload,
    Map<String, dynamic>? headers,
    bool completeResponse = false,
  }) async {
    try {
      final response = await _client.request(
        url,
        data: requestType != RestMethodType.get ? payload : null,
        queryParameters: requestType == RestMethodType.get ? payload : null,
        options:
            Options(method: _getRequestType(requestType), headers: headers),
      );
      if (completeResponse == true) {
        return response;
      }
      return response.data;
    } on DioException catch (e, st) {
      return RestException(
        statusCode: e.response?.statusCode,
        errorResponse: e.response?.data,
        message: e.message ?? e.type.name,
        stackTrace: st,
      );
    } catch (e, st) {
      return FatalException(
        stackTrace: st,
        message: "Something went wrong!",
        exception: e,
      );
    }
  }

  String _getRequestType(RestMethodType methodType) {
    switch (methodType) {
      case RestMethodType.get:
        return "GET";
      case RestMethodType.post:
        return "POST";
      case RestMethodType.put:
        return "PUT";
      case RestMethodType.patch:
        return "PATCH";
      case RestMethodType.delete:
        return "DELETE";
    }
  }
}

// class RestRequest {
//   final String baseUrl;
//   final String path;
//   final RestMethodType requestType;
//   final dynamic payload;
//   final Map<String, dynamic>? headers;

//   RestRequest({
//     required this.baseUrl,
//     required this.path,
//     required this.requestType,
//     required this.payload,
//     required this.headers,
//   });
// }

enum RestMethodType { get, post, put, patch, delete }
