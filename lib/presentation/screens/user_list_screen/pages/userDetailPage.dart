import 'package:flutter/material.dart';
import 'package:koohutest/presentation/screens/user_list_screen/controller/usercontroller.dart';
import 'package:provider/provider.dart';

class UserDetailPage extends StatefulWidget {
  final int userID;

  const UserDetailPage({Key? key, required this.userID}) : super(key: key);

  @override
  State<UserDetailPage> createState() => _UserDetailPageState();
}

class _UserDetailPageState extends State<UserDetailPage> {
  @override
  void initState() {
    super.initState();
    Provider.of<UserController>(context, listen: false)
        .fetchUserData(userID: widget.userID);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
        body: Consumer(builder: (context, UserController userData, child) {
      return userData.dataState == DataState.Fetched
          ? Center(
              child: Column(
                children: [
                  Image.network(
                    userData.userData.avatar.toString(),
                    width: 150,
                  ),
                  Text(
                    "${userData.userData.firstName} ${userData.userData.lastName}",
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text.rich(TextSpan(children: [
                    TextSpan(
                        text: "Email Id: ",
                        style: Theme.of(context).textTheme.headline6!.copyWith(
                            fontSize: 17, fontWeight: FontWeight.w800)),
                    TextSpan(
                        text: userData.userData.email.toString(),
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            fontWeight: FontWeight.w400,
                            color: Colors.blue.shade300))
                  ]))
                ],
              ),
            )
          : Center(child: CircularProgressIndicator());
    })));
  }
}
