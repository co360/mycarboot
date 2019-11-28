import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:mycarboot/mainscreen.dart';
import 'package:mycarboot/user.dart';
import 'package:progress_dialog/progress_dialog.dart';

class TabScreenPage3 extends StatefulWidget {
  final User user;

  const TabScreenPage3({Key key,this.user});
  _TabScreenPage3State createState() => _TabScreenPage3State();
}

class _TabScreenPage3State extends State<TabScreenPage3> {
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