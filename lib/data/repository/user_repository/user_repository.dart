import 'dart:convert';

import 'package:koohutest/data/network/api_call/networkClient.dart';
import 'package:koohutest/domain/entities/user_entity/userModel.dart';
import 'package:koohutest/utils/constants/apiEndpoints.dart';

import '../../../presentation/common_widgets/lazy_loading_dialog.dart';
import '../../../presentation/routes/singlecontext.dart';

class UserRepository {
  final baseUrl = ApiEndpoints.baseUrl;

  Future<UserModel> getUsersList(int index) async {
    UserModel _usermodel;

    final response = await NetworkClient().getApiResponse(baseUrl +
        ApiEndpoints.userListUrl
            .replaceFirst("\$pagenumber", index.toString()));

    _usermodel = UserModel.fromJson(response);

    return _usermodel;
  }

  Future<Data> getUserDetails(int userId) async {
    Data _usermodel;

    final response = await NetworkClient().getApiResponse(baseUrl +
        ApiEndpoints.userDetailsUrl
            .replaceFirst("\$userid", userId.toString()));
    print(response['data']);
    _usermodel = Data.fromJson(response["data"]);

    return _usermodel;
  }
}
