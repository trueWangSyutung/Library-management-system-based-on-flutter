import 'dart:convert';
import 'dart:io';

import 'package:demo01/GlobalNum/Numbers.dart';
import 'package:demo01/json/LoginBean.dart';
import 'package:demo01/pages/pages/Home.dart';
import 'package:demo01/pages/pages/borrow.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'pages/MinePage.dart';

class Welcome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: WelcomePage(),
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

class WelcomePage extends StatefulWidget {
  WelcomePage({Key key}) : super(key: key);
  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  int currentIndex = 0;
  final items = [
    BottomNavigationBarItem(
      icon: Icon(Icons.home),
      title: Text('首页'),
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.library_books),
      title: Text("借阅"),
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.people),
      title: Text("我的"),
    ),
  ];
  Future<List> _login(String username, String password) async {
    try {
      Response response = await Dio().get(
          'http://bbs.we-chat.cn/login.php?username=' +
              username +
              "&password=" +
              password);
      Map userMap = json.decode(response.toString());
      var data = new Login.fromJson(userMap);
      var list = [];
      list.add(data.data.name);
      list.add(data.data.quanxian);
      list.add(data.data.user);
      list.add(data.code);

      return list;
    } catch (e) {}
  }

  final bodyLists = [HomepageWidget(), BorrowpageWidget(), MinespageWidget()];
  get editingController => null;

  get editingController2 => null;
  @override
  Widget build(BuildContext context) {
    var fire3 = File(
        "/storage/emulated/0/Android/data/com.example.demo01/files/username.conf");
    print(fire3.path);
    fire3.exists().then((value) {
      if (value) {
        fire3.readAsString().then((value2) {
          print(value2);
          GlobalNumbers.username = value2;
        });
      } else {}
    });

    var fire2 = File(
        "/storage/emulated/0/Android/data/com.example.demo01/files/password.conf");
    print(fire2.path);
    fire2.exists().then((value) {
      if (value) {
        fire2.readAsString().then((value2) {
          GlobalNumbers.password = value2;
        });
      } else {}
    });

    _login(GlobalNumbers.username, GlobalNumbers.password).then((value) {
      var b = value;
      GlobalNumbers.name = b[0];
      GlobalNumbers.quanxian = b[1];
      GlobalNumbers.user = b[2];
      GlobalNumbers.code = b[3];
    });
    return Scaffold(
      appBar: PreferredSize(child: AppBar(), preferredSize: Size.fromHeight(0)),
      bottomNavigationBar: BottomNavigationBar(
        items: items,
        currentIndex: currentIndex,
        onTap: onTap,
        unselectedItemColor: Colors.blueGrey,
        selectedItemColor: Colors.lightBlue,
        type: BottomNavigationBarType.fixed,
      ),
      body: bodyLists[currentIndex],
    );
  }

  void onTap(int index) {
    setState(() {
      currentIndex = index;
    });
  }
}
