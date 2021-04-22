import 'dart:convert';
import 'dart:io';

import 'package:demo01/GlobalNum/Numbers.dart';
import 'package:demo01/json/Book.dart';
import 'package:demo01/json/BooksBean.dart';
import 'package:demo01/json/LoginBean.dart';
import 'package:demo01/pages/welcome.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class TwoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar:
            PreferredSize(child: AppBar(), preferredSize: Size.fromHeight(0)),
        body: RegistPage(),
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

class RegistPage extends StatefulWidget {
  RegistPage({Key key}) : super(key: key);
  @override
  _RegistPageState createState() => _RegistPageState();
}

class _RegistPageState extends State<RegistPage> {
  int countNum = 1;
  String username = "";
  String password = "";
  String name = "";

  AnimationController _loginButtonController;
  get editingController => null;
  double _length = 300;
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
              "登   录",
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
                  password = text;
                  //  / print("内容提交时回调");
                },
                decoration: InputDecoration(
                    filled: true,
                    prefixIcon: Icon(Icons.https),
                    suffixText: "密码"),
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
                "登    录",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 30),
              ),
              onPressed: () {
                if (username != "" && password != "") {
                  GlobalNumbers.username = username;
                  GlobalNumbers.password = password;
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => Welcome(
                                name: name,
                              )));
                }
              },
            ),
            width: _length,
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
