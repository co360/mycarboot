import 'package:mycarboot/register.dart';
import 'package:mycarboot/forgotpassword.dart';
import 'package:mycarboot/mainscreen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
import 'package:http/http.dart' as http;
import 'package:progress_dialog/progress_dialog.dart';


String urlLogin = "http://myondb.com/myCarBootAdmin/php/login.php";

void main() => runApp(Login());

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: LoginPage());
  }
}

class LoginPage extends StatefulWidget {
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  String _email = "";
  final TextEditingController _passwordController = TextEditingController();
  String _password = "";
  bool _isCheck = false;
  var _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    getRememberValue();
    print('Init: $_email');
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Form(
          key: _formKey,
          child: Container(
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
              child: Column(
                children: <Widget>[
                  //Logo
                  Padding(
                    padding: EdgeInsets.fromLTRB(50, 80, 50, 0),
                    child: Container(
                      width: 200,
                      height: 200,
                      child: Image.asset("assets/images/myCarBoot.png"),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          border:
                              Border.all(color: Colors.yellow[800], width: 10)),
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
                      child: Text("Admin",
                          style: TextStyle(
                              color: Colors.blue[900],
                              fontSize: 25,
                              fontWeight: FontWeight.bold))),

                  Container(
                      height: 320,
                      child: Column(children: <Widget>[
                        //email text field
                        Padding(
                          padding: EdgeInsets.fromLTRB(15, 15, 15, 5),
                          child: TextFormField(
                              keyboardType: TextInputType.emailAddress,
                              controller: _emailController,
                              validator: (String value) {
                                if (value.isEmpty) return "Please Enter Email";
                              },
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
                              keyboardType: TextInputType.emailAddress,
                              controller: _passwordController,
                              validator: (String value) {
                                if (value.isEmpty)
                                  return "Please Enter Password";
                              },
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

                        //Login Button
                        Padding(
                            padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
                            child: Container(
                                height: 40,
                                width: 200,
                                child: RaisedButton(
                                  onPressed: _loginOnPressed,
                                  child: Text(
                                    "Login",
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

                        //Remember Password Checkbox
                        Row(
                          children: <Widget>[
                            Padding(
                                padding: EdgeInsets.fromLTRB(110, 0, 0, 0),
                                child: Checkbox(
                                  value: _isCheck,
                                  onChanged: (bool value) {
                                    _onCheck(value);
                                  },
                                )),
                            Padding(
                                padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
                                child: Text('Remember Me',
                                    style: TextStyle(
                                        fontSize: 19,
                                        fontWeight: FontWeight.w600)))
                          ],
                        ),
                      ])),

                  //Forgot Account
                  Row(children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: GestureDetector(
                          onTap: () {
                              setState(() {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ForgotPassword()));
                                print('Navigation to forgot password page');
                              }); 
                            },
                          child: Text('Forgot Account',
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.blue[800],
                                  fontWeight: FontWeight.bold))),
                    ),

                    //Register Account
                    Padding(
                        padding: EdgeInsets.only(left: 40),
                        child: GestureDetector(
                            onTap: () {
                              setState(() {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Register()));
                                print('Navigation to register page');
                              }); 
                            },
                            child: Text("Resgister New Account",
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.blue[800],
                                    fontWeight: FontWeight.bold)))),
                  ])
                ],
              ))),
    );
  }

  void setRememberValue(bool value, String email, String password) async {
    SharedPreferences sharedPref = await SharedPreferences.getInstance();

    if (value) {
      if (_isEmailValid(email) && password.length > 4) {
        await sharedPref.setString('email', email);
        await sharedPref.setString('password', password);
        Toast.show("Preferences have been saved", context,
            duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
      } else {
        print('No Email');
        setState(() {
          _isCheck = false;
        });
        Toast.show("Check your credentials", context,
            duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
      }
    } else {
      await sharedPref.setString('email', '');
      await sharedPref.setString('pass', '');
      print('Remove Pref');
      Toast.show("Preferences have been removed", context,
          duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
    }
  }

  void getRememberValue() async {
    SharedPreferences sharedPref = await SharedPreferences.getInstance();

    String _email = sharedPref.getString('email');
    String _password = sharedPref.getString('password');
    if (_email.length > 1) {
      _emailController.text = _email;
      _passwordController.text = _password;
      setState(() {
        _isCheck = true;
      });
    } else {
      print('No Pref');
      setState(() {
        _isCheck = false;
      });
    }
  }

  void _onCheck(bool value) {
    setState(() {
      _isCheck = value;
      setRememberValue(value, _emailController.text, _passwordController.text);
    });
  }

  void _loginOnPressed() {
    _email = _emailController.text;
    _password = _passwordController.text;
    if (_isEmailValid(_email) && (_password.length > 4)) {
      ProgressDialog pr = new ProgressDialog(context,
          type: ProgressDialogType.Normal, isDismissible: false);
      pr.style(message: "Login in");
      pr.show();
      http.post(urlLogin, body: {
        "email": _email,
        "password": _password,
      }).then((res) {
        print(res.statusCode);
        Toast.show(res.body, context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
        if (res.body == "Login success") {
          pr.dismiss();
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => MainScreenPage(email: _email)));
        }else{
          pr.dismiss();
        }
        
      }).catchError((err) {
        pr.dismiss();
        print(err);
      });
    } else {}
  }


  bool _isEmailValid(String email) {
    return RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email);
  }
}
