import 'package:demo01/pages/pages/Home.dart';
import 'package:demo01/pages/pages/borrow.dart';
import 'package:flutter/material.dart';

import 'pages/MinePage.dart';

class Welcome extends StatelessWidget {
  String name = "";
  Welcome({Key key, @required this.name}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: WelcomePage(),
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

  final bodyLists = [HomepageWidget(), BorrowpageWidget(), MinespageWidget()];
  get editingController => null;

  get editingController2 => null;
  @override
  Widget build(BuildContext context) {
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
