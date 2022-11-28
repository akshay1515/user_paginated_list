import 'package:flutter/material.dart';
import 'package:koohutest/presentation/screens/user_list_screen/controller/usercontroller.dart';
import 'package:koohutest/presentation/screens/user_list_screen/widgets/userList_view.dart';
import 'package:provider/provider.dart';

class UserListpage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("All User List")),
        body: SafeArea(
            bottom: true,
            child: Consumer<UserController>(builder:
                (BuildContext context, UserController controller, Widget? _) {
              switch (controller.dataState) {
                case DataState.Uninitialized:
                  Future(() {
                    controller.fetchUserList();
                  });
                  return ListViewWidget(controller.dataList, true);
                case DataState.Initial_Fetching:
                  return Container();
                case DataState.More_Fetching:
                case DataState.Refreshing:
                  return ListViewWidget(controller.dataList, true);
                case DataState.Fetched:
                case DataState.Error:
                case DataState.No_More_Data:
                  return ListViewWidget(controller.dataList, false);
              }
            })));
  }
}
