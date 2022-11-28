import 'package:flutter/material.dart';
import 'package:koohutest/presentation/routes/singlecontext.dart';
import 'package:koohutest/presentation/screens/user_list_screen/controller/usercontroller.dart';
import 'package:koohutest/presentation/screens/user_list_screen/pages/userListPage.dart';
import 'package:provider/provider.dart';

void main(){
  runApp(const MyHome());
}

class MyHome extends StatelessWidget {
  const MyHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => UserController(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        navigatorKey: SingleContext.navigatorKey,
        home: UserListpage(),
      ),
    );
  }
}
