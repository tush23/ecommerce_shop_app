import 'package:flutter/foundation.dart';

class ApiResponse<T> {
  final T? data;
  final bool isLoading;
  final String? error;

  ApiResponse({
    this.data,
    this.isLoading = false,
    this.error,
  });

  factory ApiResponse.loading() => ApiResponse(isLoading: true);

  factory ApiResponse.success(T data) => ApiResponse(data: data);

  factory ApiResponse.error(String error) => ApiResponse(error: error);

  bool get hasData => data != null;
  bool get hasError => error != null;
}
