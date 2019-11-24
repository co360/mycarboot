import 'package:flutter/material.dart';
import 'package:mycarboot/login.dart';
import 'package:toast/toast.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:progress_dialog/progress_dialog.dart';
import 'dart:convert';

String urlUpload = "http://myondb.com/myCarBootAdmin/php/register.php";
String pathAsset = 'assets/images/camera.png';
File _image;
final TextEditingController _nameController = TextEditingController();
final TextEditingController _phController = TextEditingController();
final TextEditingController _emailController = TextEditingController();
final TextEditingController _passwordController = TextEditingController();
String _name, _email, _password, _phone;

void main() => runApp(Register());

class Register extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: RegisterPage(),
    );
  }
}

class RegisterPage extends StatefulWidget {
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _backOnPress,
        child: Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: AppBar(
          backgroundColor: Colors.yellow[900],
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: Colors.deepPurple[900],),
            onPressed: _backOnPress,
          ),
          centerTitle: true,
          title: Text('New User Registration', style: TextStyle(fontSize: 28, fontWeight: FontWeight.w900, color: Colors.deepPurple[900])),
        ),
        body: SingleChildScrollView(
            child: Container(
                width: 500,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                      Colors.yellow[50],
                      Colors.yellow[300],
                      Colors.yellow[50]
                    ],
                        stops: [
                      0.3,
                      0.75,
                      0.98
                    ])),
                child: Column(children: <Widget>[
                  //Take picture
                  Padding(
                    padding: EdgeInsets.fromLTRB(50, 10, 50, 5),
                    child: GestureDetector(
                    onTap: _chooseImage,
                    child: Container(
                      width: 300,
                      height: 240,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border:
                              Border.all(color: Colors.yellow[800], width: 5),
                          image: DecorationImage(
                    image: _image == null
                        ? AssetImage(pathAsset)
                        : FileImage(_image),
                    fit: BoxFit.fill,
                  )),
                    ),
                  )),
                  Text('Click on image above to take profile picture'),

                  Container(
                      height: 280,
                      child: Column(children: <Widget>[
                        //name text field
                        Padding(
                          padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
                          child: TextFormField(
                              keyboardType: TextInputType.text,
                              controller: _nameController,
                              decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white70,
                                  labelText: 'Enter Name',
                                  labelStyle: TextStyle(
                                      fontSize: 22, color: Colors.black),
                                  errorStyle: TextStyle(
                                      color: Colors.red,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(40),
                                      borderSide: BorderSide()))),
                        ),

                        //phone number text field
                        Padding(
                          padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
                          child: TextFormField(
                              keyboardType: TextInputType.phone,
                              controller: _phController,
                              decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white70,
                                  labelText: 'Enter Phone Number',
                                  labelStyle: TextStyle(
                                      fontSize: 22, color: Colors.black),
                                  errorStyle: TextStyle(
                                      color: Colors.red,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(40),
                                      borderSide: BorderSide()))),
                        ),

                        //email text field
                        Padding(
                          padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
                          child: TextFormField(
                              keyboardType: TextInputType.emailAddress,
                              controller: _emailController,
                              decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white70,
                                  labelText: 'Enter Email',
                                  labelStyle: TextStyle(
                                      fontSize: 22, color: Colors.black),
                                  errorStyle: TextStyle(
                                      color: Colors.red,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(40),
                                      borderSide: BorderSide()))),
                        ),

                        //Password Text Field
                        Padding(
                          padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
                          child: TextFormField(
                              keyboardType: TextInputType.visiblePassword,
                              controller: _passwordController,
                              decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white70,
                                  labelText: 'Enter Password',
                                  labelStyle: TextStyle(
                                      fontSize: 22, color: Colors.black),
                                  errorStyle: TextStyle(
                                      color: Colors.red,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(40),
                                      borderSide: BorderSide()))),
                        ),
                      ])),

                        //Register Button
                        Padding(
                            padding: EdgeInsets.fromLTRB(20, 5, 20, 0),
                            child: Container(
                                height: 40,
                                width: 200,
                                child: RaisedButton(
                                  onPressed: _registerOnPressed,
                                  child: Text(
                                    "Register",
                                    style: TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.w800),
                                  ),
                                  color: Colors.orange[100],
                                  splashColor: Colors.lightGreenAccent[400],
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      side: BorderSide(
                                          width: 2.0,
                                          color: Colors.yellow[900])),
                                ))),

                ])))));
  }

  void _chooseImage() async {
    _image = await ImagePicker.pickImage(source: ImageSource.camera);
    setState(() {});
  }


  void _registerOnPressed(){
    print('Register');
    print(_image.toString());
    uploadData();
  }

  void uploadData() {
    _name = _nameController.text;
    _email = _emailController.text;
    _password = _passwordController.text;
    _phone = _phController.text;

    if ((_isEmailValid(_email)) &&
        (_password.length > 4) &&
        (_image != null) &&
        (_phone.length > 5)) {
      ProgressDialog pr = new ProgressDialog(context,
          type: ProgressDialogType.Normal, isDismissible: false);
      pr.style(message: "Submit in progress");
      pr.show();

      String base64Image = base64Encode(_image.readAsBytesSync());
      http.post(urlUpload, body: {
        "encoded_string": base64Image,
        "name": _name,
        "email": _email,
        "password": _password,
        "phone": _phone,
      }).then((res) {
        print(res.statusCode);
        Toast.show(res.body, context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
        _image = null;
        _nameController.text = '';
        _emailController.text = '';
        _phController.text = '';
        _passwordController.text = '';
        pr.dismiss();
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (BuildContext context) => LoginPage()));
      }).catchError((err) {
        print(err);
      });
    } else {
      Toast.show("Check your registration information", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    }
  }

  Future<bool> _backOnPress() async {
    _image = null;
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => Login(),
        ));
    return Future.value(false);
  }

  bool _isEmailValid(String email) {
    return RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email);
  }
}
