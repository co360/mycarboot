import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:mycarboot/mainscreen.dart';
import 'package:mycarboot/user.dart';
import 'package:progress_dialog/progress_dialog.dart';

class TabScreenPage4 extends StatefulWidget {
  final User user;

  const TabScreenPage4({Key key,this.user});
  _TabScreenPage4State createState() => _TabScreenPage4State();
}

class _TabScreenPage4State extends State<TabScreenPage4> {
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