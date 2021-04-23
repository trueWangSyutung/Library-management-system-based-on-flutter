import 'dart:convert';
import 'dart:io';

import 'package:demo01/json/Book.dart';
import 'package:demo01/json/BooksBean.dart';
import 'package:demo01/pages/login.dart';
import 'package:demo01/pages/regist.dart';
import 'package:demo01/pages/welcome.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'GlobalNum/Numbers.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
  if (Platform.isAndroid) {
    // 以下两行 设置android状态栏为透明的沉浸。写在组件渲染之后，是为了在渲染后进行set赋值，覆盖状态栏，写在渲染之前MaterialApp组件会覆盖掉这个值。
    SystemUiOverlayStyle systemUiOverlayStyle =
        SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
          body: SingleChildScrollView(
            child: HomePage(),
          ),
        ),
        theme: ThemeData(
            brightness: Brightness.light,
            primaryColor: Colors.blue,
            textTheme: TextTheme(
              headline: TextStyle(color: Colors.black),
              title: TextStyle(color: Colors.black),
              body1: TextStyle(color: Colors.black),
            )),
        darkTheme: ThemeData(
          brightness: Brightness.dark,
          cardColor: Colors.grey[900],
          textTheme: TextTheme(
            headline: TextStyle(color: Colors.white),
            title: TextStyle(color: Colors.white),
            body1: TextStyle(color: Colors.white),
          ),
          scaffoldBackgroundColor: Colors.black,
        ));
  }
}

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int countNum = 1;
  Color color1 = Colors.lightBlue;
  Color color2 = Colors.grey;

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        child: Stack(children: <Widget>[
          Container(
            child: Image.asset("images/m.png"),
            alignment: Alignment.topCenter,
          ),
          Container(
            margin: EdgeInsets.fromLTRB(0, 30, 0, 0),
            child: Text(
              "iFlutter 图书借阅系统",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 30, color: Colors.black),
            ),
            alignment: Alignment.topCenter,
          ),
          //
          Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.fromLTRB(0, 100, 0, 150),
                child: Image.asset("images/flutter-hero-laptop2.png"),
                width: 300,
                alignment: Alignment.center,
                height: 300,
                decoration: new BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(250.0))),
              ),
              Container(
                child: FlatButton(
                  child: Text(
                    "登    录",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 30),
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => TwoPage()));
                  },
                  onLongPress: () {
                    color1 = Colors.lightBlue;
                    color2 = Colors.grey;
                  },
                  onHighlightChanged: (value) {},
                ),
                width: 300,
                height: 60,
                decoration: new BoxDecoration(
                    color: color1,
                    borderRadius: BorderRadius.all(Radius.circular(30.0))),
              ),
              Container(
                child: FlatButton(
                  child: Text(
                    "注    册",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 25),
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => Regist2Page()));
                  },
                  onLongPress: () {
                    color2 = Colors.lightBlue;
                    color1 = Colors.grey;
                  },
                  onHighlightChanged: (value) {},
                ),
                width: 300,
                height: 60,
                margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
                alignment: Alignment.center,
                decoration: new BoxDecoration(
                    color: color2,
                    borderRadius: BorderRadius.all(Radius.circular(30.0))),
              ),
              Container(
                child: FlatButton(
                  child: Text(
                    "不想注册？先到处看看吧。",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 15),
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => Welcome(
                                  name: "访客用户",
                                )));
                  },
                  onLongPress: () {},
                  onHighlightChanged: (value) {},
                ),
                alignment: Alignment.center,
              ),
            ],
          ),
        ]));
  }
}
