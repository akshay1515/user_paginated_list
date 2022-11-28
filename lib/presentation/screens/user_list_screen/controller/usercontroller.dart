import 'package:flutter/material.dart';
import 'package:koohutest/data/repository/user_repository/user_repository.dart';

import '../../../../domain/entities/user_entity/userModel.dart';

enum DataState {
  Uninitialized,
  Refreshing,
  Initial_Fetching,
  More_Fetching,
  Fetched,
  No_More_Data,
  Error
}

class UserController extends ChangeNotifier {
  int _currentPageNumber = 1;
  int _totalPages = 5;
  DataState _dataState = DataState.Uninitialized;

  bool get _didLastLoad => _currentPageNumber > _totalPages;

  DataState get dataState => _dataState;
  List<Data> _dataList = [];

  List<Data> get dataList => _dataList;

  late Data _userData;

  Data get userData => _userData;

  fetchUserList({bool isRefresh = false}) async {
    if (!isRefresh) {
      _dataState = (_dataState == DataState.Uninitialized)
          ? DataState.Initial_Fetching
          : DataState.More_Fetching;
    } else {
      _currentPageNumber = 1;
      _dataState = DataState.Refreshing;
    }
    notifyListeners();
    try {
      if (_didLastLoad) {
        _dataState = DataState.No_More_Data;
      } else {
        UserModel list =
            await UserRepository().getUsersList(_currentPageNumber);
        _totalPages = list.totalPages!;
        if (_dataState == DataState.Refreshing) {
          _dataList.clear();
        }
        _dataList += list.data!;
        _dataState = DataState.Fetched;
        _currentPageNumber += 1;
      }
      notifyListeners();
    } catch (e) {
      _dataState = DataState.Error;
      notifyListeners();
    }
  }

  fetchUserData({required int userID}) async {
    _dataState = DataState.Uninitialized;
    try {
      _userData = await UserRepository().getUserDetails(userID);

      _dataState = DataState.Fetched;

      notifyListeners();
    } catch (e) {
      _dataState = DataState.Error;
      notifyListeners();
    }
  }
}
