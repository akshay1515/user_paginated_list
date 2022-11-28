import "package:flutter/material.dart";

import 'package:koohutest/presentation/common_widgets/exception_dialog.dart';
import 'package:koohutest/presentation/routes/singlecontext.dart';

class ApiException implements Exception {
  final String message;
  final String statusCode;

  const ApiException({required this.statusCode, required this.message});

  showAction() {
    ExceptionDialog.showCustomAlertDialog(
        ctx: SingleContext.navigatorKey.currentState!.context,
        statusCode: statusCode,
        message: message,
        actionTitle: "Ok",
        onpressed: () {
          Navigator.of(SingleContext.navigatorKey.currentState!.context).pop();
        });
  }
}

class FetchDataException extends ApiException {
  FetchDataException(Map message)
      : super(message: message["message"], statusCode: message["status_code"]);
}

class UnstableNetworkException extends ApiException {
  UnstableNetworkException(Map message)
      : super(message: message["message"], statusCode: message["status_code"]);
}

class BadRequestException extends ApiException {
  BadRequestException(Map message)
      : super(message: message["message"], statusCode: message["status_code"]);
}

class UnauthorisedException extends ApiException {
  UnauthorisedException(Map message)
      : super(message: message["message"], statusCode: message["status_code"]);
}

class NotFoundException extends ApiException {
  NotFoundException(Map message)
      : super(message: message["message"], statusCode: message["status_code"]);
}

class TimedOutException extends ApiException {
  TimedOutException(Map message)
      : super(message: message["message"], statusCode: message["status_code"]);
}

class InvalidInputException extends ApiException {
  InvalidInputException(Map message)
      : super(message: message["message"], statusCode: message["status_code"]);
}
