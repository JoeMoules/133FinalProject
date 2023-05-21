import 'package:one_thirty_three_project/main.dart';

import 'signin_register.dart';
import '../auth_page.dart';
import 'package:flutter/material.dart';

class widgetTree extends StatefulWidget {
  const widgetTree({Key? key}) : super(key: key);

  @override
  State<widgetTree> createState() => _widgetTreeState();
}

class _widgetTreeState extends State<widgetTree> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Auth().authStateChanges,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Home();
        } else {
          return SignIn();
        }
      },
    );
  }
}
