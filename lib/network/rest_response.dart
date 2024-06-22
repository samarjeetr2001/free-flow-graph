import 'package:graphview_plotter/core/app_exception.dart';

class RestResponse<T> {
  final T? response;
  final AppException? exception;

  RestResponse({this.response, this.exception});

  bool get hasError => exception != null;
}
