import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:koohutest/presentation/common_widgets/lazy_loading_dialog.dart';
import 'package:koohutest/presentation/routes/singlecontext.dart';
import '../api_exceptions/networkExceptions.dart';
import 'baseClient.dart';

class NetworkClient extends BaseApiServices {
  @override
  Future getApiResponse(String url) async {
    var jsonResponse;

    try {
      final response = await http
          .get(Uri.parse(url))
          .timeout(const Duration(milliseconds: 10000));
      jsonResponse = returnResponse(response);
    } on SocketException {
      throw UnstableNetworkException({
        "status_code": "100",
        "message": "Please check your internet connection"
      });
    } on TimeoutException {
      throw TimedOutException(
          {"status_code": "101", "message": "Connection Timeout"});
    } catch (error) {
      rethrow;
    }
    return jsonResponse;
  }

  @override
  Future postApiResponse(String url, data) {
    // TODO: implement postApiResponse
    throw UnimplementedError();
  }

  returnResponse(http.Response response) {
    var jsonresponse;
    switch (response.statusCode) {
      case 200:
        jsonresponse = jsonDecode(response.body);
        return jsonresponse;
      case 201:
        jsonresponse = jsonDecode(response.body);
        return jsonresponse;
      case 400:
        jsonresponse = jsonDecode(response.body);
        return jsonresponse;
      case 404:
        throw NotFoundException({
          "status_code": "${response.statusCode.toString()}",
          "message": "Data not found "
        });
      case 500:
        throw UnauthorisedException({
          "status_code": "${response.statusCode.toString()}",
          "message": "Error connecting to database "
        });
      default:
        throw FetchDataException({
          "status_code": "${response.statusCode.toString()}",
          "message": "Something went wrong "
        });
    }
  }
}
