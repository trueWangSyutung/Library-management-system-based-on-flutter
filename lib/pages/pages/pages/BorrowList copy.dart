import 'dart:convert';
import 'dart:math';

import 'package:demo01/GlobalNum/Numbers.dart';
import 'package:demo01/json/Book.dart';
import 'package:demo01/json/BooksBean.dart';
import 'package:demo01/json/Boorrow.dart';
import 'package:demo01/json/BorrowListBean.dart';
import 'package:demo01/pages/pages/pages/books.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BorrowListWidget extends StatefulWidget {
  BorrowListWidget({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return BorrowListWidgetState();
  }
}

class BorrowListWidgetState extends State<BorrowListWidget> {
  BorrowListWidgetState() : super();
  List<Borrow> thislists = new List();

  int count = 0;

  Future<List> getNewBook() async {
    if (thislists.length != 0) {
    } else {
      try {
        Response response = await Dio().get(
            "http://bbs.we-chat.cn/apis/getborrow.php?code=wxdqwe123&user=" +
                GlobalNumbers.user);
        Map userMap = json.decode(response.toString());
        var data = new Borrows.fromJson(userMap);
        var a = data.data.dataSet;
        for (int i = 0; i < a.length; i++) {
          var b = a[i];
          var name = "";
          Response response2 = await Dio()
              .get("http://bbs.we-chat.cn/apis/search.php?bookid=" + b.bookId);
          String userMap2 = response2.toString();
          name = userMap2;
          thislists.add(Borrow(b.user, b.bookId, b.borrowedTime, b.returnTime,
              b.statue, b.id, name));
        }
        return thislists;
      } catch (e) {}
    }
  }

  ListView getListView() {
    getNewBook().then((value) => thislists);
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        String user = thislists[index].user;
        String bookId = thislists[index].bookId;
        String borrowedTime = thislists[index].borrowedTime;
        String returnTime = thislists[index].returnTime;

        String statue = thislists[index].statue;
        String statusString = thislists[index].statusString;
        String id = thislists[index].id;
        String bookname = thislists[index].name;

        return Card(
          child: FlatButton(
            onPressed: () {},
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        id,
                        style: TextStyle(fontSize: 20),
                      ),
                      Text(
                        "状态：" + statusString,
                        style: TextStyle(fontSize: 20),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        bookname,
                        style: TextStyle(fontSize: 30),
                      ),
                      Text(
                        "",
                        style: TextStyle(fontSize: 20),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "借阅日期：" + borrowedTime,
                        style: TextStyle(fontSize: 10),
                      ),
                      Text(
                        "理应归还日期：" + returnTime,
                        style: TextStyle(fontSize: 10),
                      )
                    ],
                  ),
                ],
              ),
              height: 100,
              margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
              padding: EdgeInsets.all(10),
            ),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15.0)),
          ),
        );
      },
      itemCount: thislists.length,
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: FutureBuilder<List>(
          future: getNewBook(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return SingleChildScrollView(
                  child: Container(
                alignment: Alignment.center,
                child: Column(
                  children: <Widget>[
                    Container(
                      alignment: Alignment.centerLeft,
                      height: 300,
                      child: Text(
                        "我的借阅",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 60),
                      ),
                    ),
                    Container(
                      child: getListView(),
                    )
                  ],
                ),
              ));
            } else {
              return Center(
                child: Container(
                    width: 200,
                    height: 200,
                    padding: EdgeInsets.all(20),
                    alignment: Alignment.center,
                    decoration: new BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.all(Radius.circular(15.0))),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 80,
                          height: 80,
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 25),
                          child: CircularProgressIndicator(
                            strokeWidth: 10,
                            backgroundColor: Colors.greenAccent[200],
                          ),
                        ),
                        Text(
                          "加载中",
                          style: TextStyle(fontSize: 15, color: Colors.black),
                        )
                      ],
                    )),
              );
            }
          }),
    );
  }
}
