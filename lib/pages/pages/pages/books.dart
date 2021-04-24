import 'dart:convert';
import 'dart:math';

import 'package:demo01/GlobalNum/Numbers.dart';
import 'package:demo01/json/Book.dart';
import 'package:demo01/json/BooksBean.dart';
import 'package:demo01/pages/pages/Home.dart';
import 'package:demo01/pages/welcome.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BookWidget extends StatefulWidget {
  Book book;
  Color colors;

  BookWidget({Key key, @required this.book, @required this.colors})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return BookWidgetState(book: book);
  }
}

class BookWidgetState extends State<BookWidget> {
  Book book;
  Color colors;
  BookWidgetState({@required this.book, @required this.colors}) : super();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: null,
        body: SingleChildScrollView(
            child: Container(
                margin: EdgeInsets.fromLTRB(0, 40, 0, 0),
                alignment: Alignment.center,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(40.0)),
                      ),
                      child: Container(
                        alignment: Alignment.centerLeft,
                        height: 300,
                        margin: EdgeInsets.fromLTRB(30, 0, 0, 0),
                        child: Text(
                          "图 书 详 情",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 60),
                        ),
                      ),
                    ),
                    Card(
                      margin: EdgeInsets.fromLTRB(0, 14, 0, 0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(40.0)),
                      ),
                      child: Container(
                        height: 300,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              margin: EdgeInsets.fromLTRB(30, 0, 0, 0),
                              alignment: Alignment.centerLeft,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "图书名：\n" +
                                        book.bookName +
                                        "\n作者:" +
                                        book.author,
                                    style: TextStyle(
                                      fontSize: 30,
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: 130,
                              height: 200,
                              margin: EdgeInsets.fromLTRB(0, 0, 30, 0),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: Color.fromARGB(
                                      255,
                                      Random().nextInt(255),
                                      Random().nextInt(255),
                                      Random().nextInt(255)),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15.0))),
                              child: Text(
                                HomepageWidgetState.getVerText(book.bookName),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Card(
                      margin: EdgeInsets.fromLTRB(0, 14, 0, 0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(40.0)),
                      ),
                      child: Container(
                        height: 400,
                        margin: EdgeInsets.fromLTRB(15, 0, 0, 0),
                        padding: EdgeInsets.all(15),
                        alignment: Alignment.topLeft,
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(40.0))),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "图书编号：" +
                                  book.bookId +
                                  "\n图书ISBN：" +
                                  book.isbn +
                                  "\n图书价格：" +
                                  book.bookPrice +
                                  "\n出版社：" +
                                  book.bookPub +
                                  "\n上架日期：" +
                                  book.bookPubdate +
                                  "\n货架号：" +
                                  book.counter +
                                  "\n当前状态：" +
                                  HomepageWidgetState.getShifoujiechu(
                                      book.shifoujiechu),
                              style: TextStyle(fontSize: 25),
                              textAlign: TextAlign.left,
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ))));
  }
}
