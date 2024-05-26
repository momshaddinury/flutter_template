base class ResponseModel {
  final bool success;
  final String? message;
  final ErrorModel? error;
  final Object? data;

  ResponseModel({
    required this.success,
    this.message,
    this.error,
    this.data,
  });

  factory ResponseModel.fromJson(Map<String, dynamic> json) {
    return ResponseModel(
      success: json['success'],
      message: json['message'],
      error: json['error'],
      data: json['data'],
    );
  }
}

base class ErrorModel {
  final String message;
  final String? code;
  final String? stack;

  ErrorModel({
    required this.message,
    required this.code,
    required this.stack,
  });

  factory ErrorModel.fromJson(Map<String, dynamic> json) {
    return ErrorModel(
      message: json['message'],
      code: json['code'],
      stack: json['stack'],
    );
  }
}
