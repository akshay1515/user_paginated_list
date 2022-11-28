import 'package:flutter/material.dart';
import 'package:koohutest/domain/entities/user_entity/userModel.dart';
import 'package:koohutest/presentation/screens/user_list_screen/pages/userDetailPage.dart';
import 'package:provider/provider.dart';

import '../controller/usercontroller.dart';

class ListViewWidget extends StatelessWidget {
  final List<Data> _data;
  bool _isLoading;

  ListViewWidget(this._data, this._isLoading);

  late DataState _dataState;
  late BuildContext _buildContext;

  @override
  Widget build(BuildContext context) {
    _dataState = Provider.of<UserController>(context, listen: false).dataState;
    _buildContext = context;
    return SafeArea(child: _scrollNotificationWidget());
  }

  Widget _scrollNotificationWidget() {
    return Column(
      children: [
        Expanded(
            child: NotificationListener<ScrollNotification>(
                onNotification: _scrollNotification,
                child: RefreshIndicator(
                  onRefresh: () async {
                    await _onRefresh();
                  },
                  child: ListView.builder(
                    itemCount: _data.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: (){
                          Navigator.of(context).push(MaterialPageRoute(builder: (_)=>UserDetailPage(userID: _data[index].id!)));
                        },
                        child: Card(
                            elevation: 2,
                            child: Row(
                              children: [
                                Image.network(_data[index].avatar.toString(),
                                    height: 75),
                                Container(
                                  width: 200,
                                  child: ListTile(
                                    title: Text(
                                        "${_data[index].firstName.toString()} ${_data[index].lastName.toString()}",
                                        style: TextStyle(fontSize: 15)),
                                  ),
                                )
                              ],
                            )),
                      );
                    },
                  ),
                ))),
        if (_dataState == DataState.More_Fetching)
          const Center(child: CircularProgressIndicator()),
        if (_dataState == DataState.No_More_Data)
          Container(
            width: double.infinity,
            alignment: Alignment.center,
            color: Colors.deepPurple,
            height: 30,
            child: Text(
              "No more Data to Load",
              style: Theme.of(_buildContext)
                  .textTheme
                  .headline6!
                  .copyWith(color: Colors.white,fontWeight: FontWeight.w600),
            ),
          )
      ],
    );
  }

  bool _scrollNotification(ScrollNotification scrollInfo) {
    if (!_isLoading &&
        scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
      _isLoading = true;
      Provider.of<UserController>(_buildContext, listen: false).fetchUserList();
    }
    return true;
  }

  _onRefresh() async {
    if (!_isLoading) {
      _isLoading = true;
      Provider.of<UserController>(_buildContext, listen: false)
          .fetchUserList(isRefresh: true);
    }
  }
}
