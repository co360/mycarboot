import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:mycarboot/mainscreen.dart';
import 'package:mycarboot/user.dart';
import 'package:progress_dialog/progress_dialog.dart';

class TabScreenPage2 extends StatefulWidget {
  final User user;

  const TabScreenPage2({Key key,this.user});
  _TabScreenPage2State createState() => _TabScreenPage2State();
}

class _TabScreenPage2State extends State<TabScreenPage2> {
  GlobalKey<RefreshIndicatorState> refreshKey;

  Widget build(BuildContext context) {
    return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      resizeToAvoidBottomPadding: false,
    )
  );
}
}