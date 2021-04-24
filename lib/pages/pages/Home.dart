import 'dart:convert';
import 'dart:math';

import 'package:demo01/GlobalNum/Numbers.dart';
import 'package:demo01/json/Book.dart';
import 'package:demo01/json/BooksBean.dart';
import 'package:demo01/pages/pages/pages/books.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomepageWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return HomepageWidgetState();
  }
}

class HomepageWidgetState extends State<HomepageWidget> {
  int count = 0;
  static String getShifoujiechu(String i) {
    var isjiechu = ["已借出", "未借出"];

    if (i == "0") {
      return isjiechu[1];
    } else {
      return isjiechu[0];
    }
  }

  static String getVerText(String string) {
    var zm = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz".split("");
    var s = string.split("");
    var q = "";
    for (int i = 0; i < s.length; i++) {
      if (zm.contains(s[i])) {
        q = q + s[i];
      } else {
        q = q + "\n${s[i]}";
      }
    }
    return q;
  }

  Future<List> getNewBook() async {
    if (GlobalNumbers.book_list.length != 0) {
    } else {
      try {
        Response response =
            await Dio().get('http://bbs.we-chat.cn/books.php?days=30');
        Map userMap = json.decode(response.toString());
        var data = new Books.fromJson(userMap);
        var a = data.data.dataSet;
        for (int i = 0; i < a.length; i++) {
          var b = a[i];
          GlobalNumbers.book_list.add(Book(
              b.bookId,
              b.isbn,
              b.bookName,
              b.bookPrice,
              b.author,
              b.bookPub,
              b.bookPubdate,
              b.shifoujiechu,
              b.counter));
        }
        return GlobalNumbers.book_list;
      } catch (e) {}
    }
  }

  ListView getListView() {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        Color colors = Color.fromARGB(255, Random().nextInt(255),
            Random().nextInt(255), Random().nextInt(255));
        return Card(
          clipBehavior: Clip.antiAlias,
          child: FlatButton(
            onPressed: () {
              Navigator.push(
                  context,
                  CupertinoPageRoute(
                      builder: (context) => BookWidget(
                            book: GlobalNumbers.book_list[index],
                            colors: colors,
                          )));
            },
            child: Container(
              child: Row(
                children: [
                  Container(
                    width: 125,
                    height: 190,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: colors,
                        borderRadius: BorderRadius.all(Radius.circular(15.0))),
                    child: Text(
                      getVerText(GlobalNumbers.book_list[index].bookName),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(15, 0, 0, 0),
                    width: 190,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(15.0))),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          GlobalNumbers.book_list[index].bookName,
                          style: TextStyle(
                            fontSize: 30,
                          ),
                          textAlign: TextAlign.left,
                          maxLines: 1,
                        ),
                        Text(
                          GlobalNumbers.book_list[index].author,
                          style: TextStyle(
                            fontSize: 30,
                          ),
                          maxLines: 1,
                          textAlign: TextAlign.left,
                        ),
                        Text(
                          "上架日期：" +
                              GlobalNumbers.book_list[index].bookPubdate +
                              "\n货架号：" +
                              GlobalNumbers.book_list[index].counter +
                              "\n当前状态：" +
                              getShifoujiechu(
                                  GlobalNumbers.book_list[index].shifoujiechu),
                          style: TextStyle(fontSize: 15),
                          textAlign: TextAlign.left,
                        ),
                      ],
                    ),
                  )
                ],
              ),
              height: 200,
              margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
              padding: EdgeInsets.all(10),
            ),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15.0)),
          ),
        );
      },
      itemCount: GlobalNumbers.book_list.length,
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return FutureBuilder<List>(
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
                      "新 书 上 架",
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
        });
  }
}
