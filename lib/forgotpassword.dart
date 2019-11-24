import 'package:flutter/material.dart';
import 'package:mycarboot/login.dart';
import 'package:http/http.dart' as http;
import 'package:progress_dialog/progress_dialog.dart';
import 'package:toast/toast.dart';

String urlUpload = "http://myondb.com/myCarBootAdmin/php/resetpassword.php";
final TextEditingController _emailController = TextEditingController();
final TextEditingController _passwordController1 = TextEditingController();
final TextEditingController _passwordController2 = TextEditingController();
String _email, _password1, _password2;

void main() => runApp(ForgotPassword());

class ForgotPassword extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ForgotPasswordPage(),
    );
  }
}

class ForgotPasswordPage extends StatefulWidget {
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPasswordPage> {
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
              title: Text('Reset Password',
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.w900, color: Colors.deepPurple[900])),
            ),
            body: SingleChildScrollView(
                child: Container(
                    width: 500,
                    height: 600,
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
                      //email text field
                      Padding(
                        padding: EdgeInsets.fromLTRB(15, 150, 15, 5),
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
                      //enter new password text field
                      Padding(
                        padding: EdgeInsets.fromLTRB(15, 10, 15, 5),
                        child: TextFormField(
                            keyboardType: TextInputType.visiblePassword,
                            controller: _passwordController2,
                            decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white70,
                                labelText: 'Enter New Password',
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
                      //reenter new password text field
                      Padding(
                        padding: EdgeInsets.fromLTRB(15, 10, 15, 5),
                        child: TextFormField(
                            keyboardType: TextInputType.visiblePassword,
                            controller: _passwordController1,
                            decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white70,
                                labelText: 'Re-Enter New Password',
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

                      Padding(
                            padding: EdgeInsets.fromLTRB(20, 5, 20, 0),
                            child: Container(
                                height: 40,
                                width: 200,
                                child: RaisedButton(
                                  onPressed: _submitOnPressed,
                                  child: Text(
                                    "Submit",
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
                      Padding(
                        padding: EdgeInsets.fromLTRB(20, 10, 15, 20),
                      child: Text("A verification email for resetting your password will be sent to your email address.", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),),
                      ),

                    ])))));
  }

  Future<bool> _backOnPress() async {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => Login(),
        ));
    return Future.value(false);
  }

  void _submitOnPressed(){
    print('Submit');
    _email = _emailController.text;
    _password1 = _passwordController1.text;
    _password2 = _passwordController2.text;

    if (_password1 == _password2)
      uploadData();
    else 
      Toast.show("Password not match", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
  }

  void uploadData() {
    if ((_isEmailValid(_email)) &&
        (_password1.length > 4)) {
      ProgressDialog pr = new ProgressDialog(context,
          type: ProgressDialogType.Normal, isDismissible: false);
      pr.style(message: "Submit in progress");
      pr.show();

      http.post(urlUpload, body: {
        "email": _email,
        "password": _password1,
      }).then((res) {
        print(res.statusCode);
        Toast.show(res.body, context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
        _emailController.text = '';
        _passwordController1.text = '';
        _passwordController2.text = '';
        pr.dismiss();
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (BuildContext context) => LoginPage()));
      }).catchError((err) {
        print(err);
      });
    } else {
      Toast.show("Check your information", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    }
  }

  bool _isEmailValid(String email) {
    return RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email);
  }

}
