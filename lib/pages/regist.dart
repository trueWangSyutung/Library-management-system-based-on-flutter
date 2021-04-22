import 'package:demo01/internet/Toast.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class Regist2Page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar:
            PreferredSize(child: AppBar(), preferredSize: Size.fromHeight(0)),
        body: LoginPage(),
      ),
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.blue,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
      ),
    );
  }
}

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  int countNum = 1;
  String username = "";
  String password = "";
  String repassword = "";
  String name = "";
  String _errorText = "密码不能为空";
  String _errorText2 = "";
  get editingController => null;

  _regist(
      String usernames, String passwords, String repwd, String names) async {
    try {
      if (passwords == repwd) {
        Response response = await Dio().get(
            'http://bbs.we-chat.cn/regist.php?username=' +
                usernames +
                "&password=" +
                passwords +
                "&names=" +
                names);
        String userMap = response.toString();
        print(userMap);
        if (userMap == "1") {
          setState(() {
            _errorText = "用户名已存在！";
          });
        } else if (userMap == "2") {
          Toast.toast(context, msg: "注册成功 ", position: ToastPostion.center);
        }
      }
    } catch (e) {
      return e;
    }
  }

  get editingController2 => null;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Container(
      alignment: Alignment.center,
      child: Column(
        children: <Widget>[
          Container(
            width: 300,
            height: 300,
            margin: EdgeInsets.all(15),
            child: Text(
              "注   册",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 60),
            ),
            alignment: Alignment.centerLeft,
            decoration: new BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(15.0))),
          ),
          Container(
              child: TextField(
                controller: editingController,
                maxLength: 15,
                maxLines: 1,
                autocorrect: true,
                obscureText: false,
                textAlign: TextAlign.center, //对齐方式
                style: TextStyle(fontSize: 26.0, color: Colors.green),
                onChanged: (text) {
                  username = text;

                  //长度变化
                  //print(text.length);
                },
                onSubmitted: (text) {
                  username = text;
                  //  / print("内容提交时回调");
                },
                decoration: InputDecoration(
                    filled: true,
                    prefixIcon: Icon(Icons.person),
                    errorText: _errorText2,
                    suffixText: "用户名"),
              ),
              width: 320,
              margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
              height: 80,
              alignment: Alignment.centerLeft,
              decoration: new BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(25.0)))),
          Container(
              child: TextField(
                controller: editingController2,
                maxLength: 18,
                maxLines: 1,
                autocorrect: true,
                obscureText: true,
                textAlign: TextAlign.center, //对齐方式
                style: TextStyle(fontSize: 26.0, color: Colors.green),
                onChanged: (text) {
                  password = text;

                  //长度变化
                  //print(text.length);
                },
                onSubmitted: (text) {
                  setState(() {
                    if (repassword != password) {
                      _errorText = '两次密码不相同';
                    } else {
                      _errorText = null;
                    }
                  });
                  password = text;
                  //  / print("内容提交时回调");
                },
                decoration: InputDecoration(
                    filled: true,
                    prefixIcon: Icon(Icons.https),
                    helperText: "密码请包含字母和数字",
                    errorText: _errorText,
                    suffixText: "密码"),
              ),
              width: 320,
              margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
              height: 80,
              alignment: Alignment.centerLeft,
              decoration: new BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(25.0)))),
          Container(
              child: TextField(
                controller: editingController2,
                maxLength: 18,
                maxLines: 1,
                autocorrect: true,
                obscureText: true,
                textAlign: TextAlign.center, //对齐方式
                style: TextStyle(fontSize: 26.0, color: Colors.green),
                onChanged: (text) {
                  repassword = text;

                  //长度变化
                  //print(text.length);
                },
                onSubmitted: (text) {
                  setState(() {
                    if (repassword != password) {
                      _errorText = '两次密码不相同';
                    } else {
                      _errorText = null;
                    }
                  });
                  repassword = text;

                  //  / print("内容提交时回调");
                },
                decoration: InputDecoration(
                    filled: true,
                    prefixIcon: Icon(Icons.https),
                    helperText: "密码请包含字母和数字",
                    errorText: _errorText,
                    suffixText: "再重复一次密码"),
              ),
              width: 320,
              margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
              height: 80,
              alignment: Alignment.centerLeft,
              decoration: new BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(25.0)))),
          Container(
              child: TextField(
                controller: editingController,
                maxLength: 15,
                maxLines: 1,
                autocorrect: true,
                obscureText: false,
                textAlign: TextAlign.center, //对齐方式
                style: TextStyle(fontSize: 26.0, color: Colors.green),
                onChanged: (text) {
                  name = text;

                  //长度变化
                  //print(text.length);
                },
                onSubmitted: (text) {
                  name = text;
                  //  / print("内容提交时回调");
                },
                decoration: InputDecoration(
                    filled: true,
                    prefixIcon: Icon(Icons.person),
                    suffixText: "昵称"),
              ),
              width: 320,
              margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
              height: 80,
              alignment: Alignment.centerLeft,
              decoration: new BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(25.0)))),
          Container(
            child: FlatButton(
                child: Text(
                  "注   册",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 30),
                ),
                onPressed: () {
                  _regist(username, password, repassword, name);
                }),
            width: 300,
            height: 60,
            margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
            decoration: new BoxDecoration(
                color: Colors.lightBlue,
                borderRadius: BorderRadius.all(Radius.circular(30.0))),
          ),
        ],
      ),
    ));
  }
}
