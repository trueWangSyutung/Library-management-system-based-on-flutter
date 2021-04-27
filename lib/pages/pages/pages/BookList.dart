import 'dart:convert';
import 'dart:math';

import 'package:demo01/GlobalNum/Numbers.dart';
import 'package:demo01/json/Book.dart';
import 'package:demo01/json/BooksBean.dart';
import 'package:demo01/pages/pages/pages/books.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BookListWidget extends StatefulWidget {
  BookListWidget({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return BookListWidgetState();
  }
}

class BookListWidgetState extends State<BookListWidget> {
  BookListWidgetState() : super();
  var thislists = new List();

  int count = 0;
  static String getShifoujiechu(String i) {
    var isjiechu = ["仍有库存", "已全部借出"];

    if (int.parse(i) > 0) {
      return isjiechu[0] + i + "本";
    } else {
      return isjiechu[1];
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
    if (thislists.length != 0) {
    } else {
      try {
        Response response =
            await Dio().get('http://bbs.we-chat.cn/books.php?days=99999');
        Map userMap = json.decode(response.toString());
        var data = new Books.fromJson(userMap);
        var a = data.data.dataSet;
        for (int i = 0; i < a.length; i++) {
          var b = a[i];
          thislists.add(Book(b.bookId, b.isbn, b.bookName, b.bookPrice,
              b.author, b.bookPub, b.bookPubdate, b.shifoujiechu, b.counter));
        }
        return thislists;
      } catch (e) {}
    }
  }

  ListView getListView() {
    getNewBook().then((value) => thislists);
    return ListView.separated(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      separatorBuilder: (BuildContext context, int index) => Container(
        padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
        child: Divider(height: 2.0, color: Colors.grey),
      ),
      itemBuilder: (BuildContext context, int index) {
        if (thislists[index] != null) {
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
                              book: thislists[index],
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
                          borderRadius:
                              BorderRadius.all(Radius.circular(15.0))),
                      child: Text(
                        getVerText(thislists[index].bookName),
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
                          borderRadius:
                              BorderRadius.all(Radius.circular(15.0))),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            thislists[index].bookName,
                            style: TextStyle(
                              fontSize: 30,
                            ),
                            textAlign: TextAlign.left,
                            maxLines: 1,
                          ),
                          Text(
                            thislists[index].author,
                            style: TextStyle(
                              fontSize: 30,
                            ),
                            maxLines: 1,
                            textAlign: TextAlign.left,
                          ),
                          Text(
                            "上架日期：" +
                                thislists[index].bookPubdate +
                                "\n货架号：" +
                                thislists[index].counter +
                                "\n当前状态：" +
                                getShifoujiechu(thislists[index].shifoujiechu),
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
        } else {
          return null;
        }
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
                        "图 书 一 览 无 余",
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
