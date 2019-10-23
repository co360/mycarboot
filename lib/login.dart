import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

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
                      colors: [Colors.yellow[50], Colors.yellow[300], Colors.yellow[100]],
                      stops: [0.3, 0.75, 1])),
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
                                      color: Colors.red, fontSize: 15, fontWeight: FontWeight.w600),
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
                                      color: Colors.red, fontSize: 15, fontWeight: FontWeight.w600),
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
                                  onPressed:
                                      _loginOnPressed, //getRememberValue,
                                  child: Text(
                                    "Login",
                                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.w800),
                                  ),
                                  color: Colors.orange[100],
                                  splashColor: Colors.lightGreenAccent[400], // change button color when pressed
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10), side: BorderSide(width: 2.0, color: Colors.yellow[900])
                                      ),
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
                                    style: TextStyle(fontSize: 19, fontWeight: FontWeight.w600)))
                          ],
                        ),
                      ])),

                  //Forgot Account
                  Row(children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: GestureDetector(
                          onTap: _onForget,
                          child: Text('Forgot Account',
                              style: TextStyle(
                                  fontSize: 20, color: Colors.black, fontWeight: FontWeight.w600))),
                    ),

                    //Register Account
                    Padding(
                        padding: EdgeInsets.only(left: 50),
                        child: GestureDetector(
                            onTap: () {
                              print("Register Account");
                            },
                            child: Text("Resgister New Account",
                                style: TextStyle(
                                    fontSize: 20, color: Colors.black, fontWeight: FontWeight.w600)))),
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

  void _onForget() {
    print("Forget Account");
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
    setState(() {
      if (_formKey.currentState.validate() &&
          _isEmailValid(_email) &&
          _password.length > 4) {
        print("successful login");
      } else {
        print("fail login");
        Toast.show("Check your credentials", context,
            duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
      }
    });
  }

  bool _isEmailValid(String email) {
    return RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email);
  }
}
