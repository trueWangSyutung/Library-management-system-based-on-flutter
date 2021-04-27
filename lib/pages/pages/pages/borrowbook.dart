//
import 'package:demo01/GlobalNum/Numbers.dart';
import 'package:demo01/json/Book.dart';
import 'package:demo01/pages/pages/Home.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class BorrowbookWidget extends StatefulWidget {
  Book book;

  BorrowbookWidget({Key key, @required this.book}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return BorrowbookWidgetState(book_id: book.bookId);
  }
}

class BorrowbookWidgetState extends State<BorrowbookWidget> {
  String book_id;
  BorrowbookWidgetState({@required this.book_id}) : super();

  var _book_id = new TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _book_id.text = book_id;
  }

  _borrow(String book_id) async {
    try {
      Response response = await Dio().get(
          'http://bbs.we-chat.cn/apis/borrow.php?bookid=' +
              book_id +
              "&user=" +
              GlobalNumbers.user);
      String userMap = response.toString();
      print(userMap);
      if (userMap == "2") {
        print(userMap);
        showModalBottomSheet(
          context: context,
          builder: (BuildContext context) {
            return new Container(
                height: 200.0,
                margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                decoration: new BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(30.0))),
                child: Container(
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Container(
                        child: Text(
                          "您申请借阅成功。",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 25),
                        ),
                        height: 60,
                        margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
                        alignment: Alignment.center,
                        decoration: new BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(30.0))),
                      ),
                      Container(
                        child: FlatButton(
                          child: Text(
                            "确   定",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 25),
                          ),
                          onPressed: () {
                            Navigator.pop(context, '取消');
                            Navigator.pop(context, '取消');
                          },
                          onLongPress: () {},
                          onHighlightChanged: (value) {},
                        ),
                        height: 60,
                        margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
                        alignment: Alignment.center,
                        decoration: new BoxDecoration(
                            color: Colors.lightBlue,
                            borderRadius:
                                BorderRadius.all(Radius.circular(30.0))),
                      ),
                    ],
                  ),
                ));
          },
        ).then((val) {
          // 打印 点击返回的数据
          print(val);
        });
      } else {
        showModalBottomSheet(
          context: context,
          builder: (BuildContext context) {
            return new Container(
                height: 200.0,
                margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                decoration: new BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(30.0))),
                child: Container(
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Container(
                        child: Text(
                          "您申请借阅成功。",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 25),
                        ),
                        height: 60,
                        margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
                        alignment: Alignment.center,
                        decoration: new BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(30.0))),
                      ),
                      Container(
                        child: FlatButton(
                          child: Text(
                            "确   定",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 25),
                          ),
                          onPressed: () {
                            Navigator.pop(context, '取消');
                            ;
                          },
                          onLongPress: () {},
                          onHighlightChanged: (value) {},
                        ),
                        height: 60,
                        margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
                        alignment: Alignment.center,
                        decoration: new BoxDecoration(
                            color: Colors.lightBlue,
                            borderRadius:
                                BorderRadius.all(Radius.circular(30.0))),
                      ),
                    ],
                  ),
                ));
          },
        ).then((val) {
          // 打印 点击返回的数据
          print(val);
        });
      }
    } catch (e) {
      return e;
    }
  }

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
                          "图书借阅申请",
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
                                child: TextField(
                                  controller: _book_id,
                                  maxLength: 15,
                                  maxLines: 1,
                                  autocorrect: true,
                                  obscureText: false,

                                  textAlign: TextAlign.center, //对齐方式
                                  style: TextStyle(
                                      fontSize: 26.0, color: Colors.green),
                                  onChanged: (text) {
                                    book_id = text;
                                  },
                                  onSubmitted: (text) {
                                    book_id = text;
                                  },
                                  decoration: InputDecoration(
                                      filled: true,
                                      prefixIcon: Icon(Icons.book),
                                      suffixText: "图书编号"),
                                ),
                                width: 320,
                                margin: EdgeInsets.fromLTRB(30, 10, 10, 10),
                                height: 80,
                                alignment: Alignment.centerLeft,
                                decoration: new BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(25.0)))),
                          ],
                        ),
                      ),
                    ),
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(40.0)),
                      ),
                      child: Container(
                        height: 60,
                        alignment: Alignment.topLeft,
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(40.0))),
                        child: Container(
                          child: FlatButton(
                            child: Text(
                              "借   阅",
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 25),
                            ),
                            onPressed: () {
                              _borrow(book_id);
                            },
                            onLongPress: () {},
                            onHighlightChanged: (value) {},
                          ),
                          height: 60,
                          margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
                          alignment: Alignment.center,
                          decoration: new BoxDecoration(
                              color: Colors.lightBlue,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(40.0))),
                        ),
                      ),
                    )
                  ],
                ))));
  }
}
