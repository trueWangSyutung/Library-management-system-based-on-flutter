import 'dart:convert';
import 'dart:io';

import 'package:demo01/GlobalNum/Numbers.dart';
import 'package:demo01/json/LoginBean.dart';
import 'package:demo01/pages/login.dart';
import 'package:demo01/pages/regist.dart';
import 'package:demo01/pages/welcome.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class MinespageWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return MinespageWidgetState();
  }
}

enum Action { Ok, Cancel }

class MinespageWidgetState extends State<MinespageWidget> {
  int count = 2;
  var quanxian1 = ["", "管理员", "老师", "学生", "注册用户", "普通访客"];
  var setInformation = ["设置中心", "您的权限"];
  var information = ["官方网站", "开源地址", "关于我们", "隐私协议"];
  var admin = ["图书上架处理", "图书表单审核", "用户控制中心"];
  var zhuxiao = ["注销登录"];

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

  String getQuanxian(String quanxian) {
    if (quanxian == "1") {
      return quanxian1[1];
    } else if (quanxian == "2") {
      return quanxian1[2];
    } else if (quanxian == "3") {
      return quanxian1[3];
    } else if (quanxian == "4") {
      return quanxian1[4];
    } else if (quanxian == "5") {
      return quanxian1[5];
    } else {
      return quanxian1[0];
    }
  }

  Widget getBase() {
    return Column(
      children: [
        Card(
          clipBehavior: Clip.antiAlias,
          child: Container(
            child: ListView.separated(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                separatorBuilder: (BuildContext context, int index) =>
                    Container(
                      padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                      child: Divider(height: 2.0, color: Colors.grey),
                    ),
                itemCount: setInformation.length,
                itemBuilder: (BuildContext context, int index) {
                  return FlatButton(
                    onPressed: () {},
                    child: Text(setInformation[index],
                        style: TextStyle(fontSize: 20)),
                  );
                }),
            margin: EdgeInsets.fromLTRB(18, 0, 18, 0),
            padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
            decoration: new BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10.0))),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15.0)),
          ),
        ),
        Card(
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15.0)),
          ),
          child: Container(
            child: ListView.separated(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                separatorBuilder: (BuildContext context, int index) =>
                    Container(
                      padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                      child: Divider(height: 2.0, color: Colors.grey),
                    ),
                itemCount: information.length,
                itemBuilder: (BuildContext context, int index) {
                  return FlatButton(
                    onPressed: () {},
                    child: Text(information[index],
                        style: TextStyle(fontSize: 20)),
                  );
                }),
            margin: EdgeInsets.fromLTRB(18, 10, 18, 0),
            padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
            decoration: new BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10.0))),
          ),
        ),
      ],
    );
  }

  Widget getUnusersetting() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: 150,
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
            onLongPress: () {},
            onHighlightChanged: (value) {},
          ),
          height: 40,
          margin: EdgeInsets.fromLTRB(40, 10, 5, 10),
          alignment: Alignment.center,
          decoration: new BoxDecoration(
              color: Colors.lightBlue,
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
        ),
        Container(
          width: 150,
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
            onLongPress: () {},
            onHighlightChanged: (value) {},
          ),
          height: 40,
          margin: EdgeInsets.fromLTRB(5, 10, 40, 10),
          alignment: Alignment.center,
          decoration: new BoxDecoration(
              color: Colors.lightBlue,
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    if (GlobalNumbers.username != "" && GlobalNumbers.password != "") {
      return SingleChildScrollView(
          child: Container(
        alignment: Alignment.center,
        child: Column(
          children: <Widget>[
            Container(
              height: 300,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FutureBuilder(
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        var b = snapshot.data;
                        GlobalNumbers.name = b[0];
                        GlobalNumbers.quanxian = b[1];
                        GlobalNumbers.user = b[2];
                        GlobalNumbers.code = b[3];
                        return Container(
                          width: 90,
                          height: 90,
                          child: Text(GlobalNumbers.name.split('')[0],
                              style: TextStyle(fontSize: 60)),
                          alignment: Alignment.center,
                          decoration: new BoxDecoration(
                              color: Colors.lightBlue,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(45.0))),
                        );
                      } else {
                        return Container(
                          child: Text(""),
                        );
                      }
                    },
                    future:
                        _login(GlobalNumbers.username, GlobalNumbers.password),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        GlobalNumbers.name,
                        textAlign: TextAlign.left,
                        style: TextStyle(fontSize: 30),
                      ),
                      Text(
                        getQuanxian(GlobalNumbers.quanxian),
                        textAlign: TextAlign.left,
                        style: TextStyle(fontSize: 20),
                      ),
                      Text(
                        "账号：" + GlobalNumbers.user,
                        textAlign: TextAlign.left,
                        style: TextStyle(fontSize: 20),
                      )
                    ],
                  ),
                ],
              ),
              alignment: Alignment.center,
              margin: EdgeInsets.fromLTRB(5, 0, 5, 0),
              padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
              decoration: new BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(15.0))),
            ),
            getBase(),
            Card(
              clipBehavior: Clip.antiAlias,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(15.0)),
              ),
              child: Container(
                width: 400,
                child: FlatButton(
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) {
                        return new Container(
                            height: 200.0,
                            margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                            decoration: new BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30.0))),
                            child: Container(
                              alignment: Alignment.center,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Container(
                                    child: FlatButton(
                                      child: Text(
                                        "取   消",
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
                                        color: Colors.grey,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(30.0))),
                                  ),
                                  Container(
                                    child: FlatButton(
                                      child: Text(
                                        "确   定",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(fontSize: 25),
                                      ),
                                      onPressed: () {
                                        GlobalNumbers.username = "";
                                        GlobalNumbers.password = "";

                                        var fire3 = File(
                                            "/storage/emulated/0/Android/data/com.example.demo01/files/username.conf");
                                        print(fire3.path);
                                        fire3.exists().then((value) {
                                          if (value) {
                                            fire3.delete();
                                          } else {}
                                        });

                                        var fire2 = File(
                                            "/storage/emulated/0/Android/data/com.example.demo01/files/password.conf");
                                        print(fire2.path);
                                        fire2.exists().then((value) {
                                          if (value) {
                                            fire2.delete();
                                          } else {}
                                        });
                                        GlobalNumbers.name = "游客";
                                        Navigator.pop(context, '确定');
                                      },
                                      onLongPress: () {},
                                      onHighlightChanged: (value) {},
                                    ),
                                    height: 60,
                                    margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
                                    alignment: Alignment.center,
                                    decoration: new BoxDecoration(
                                        color: Colors.lightBlue,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(30.0))),
                                  ),
                                ],
                              ),
                            ));
                      },
                    ).then((val) {
                      // 打印 点击返回的数据
                      print(val);
                    });
                  },
                  child: Text("注销账号", style: TextStyle(fontSize: 20)),
                ),
                margin: EdgeInsets.fromLTRB(18, 10, 18, 0),
                padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                decoration: new BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
              ),
            )
          ],
        ),
      ));
    } else {
      GlobalNumbers.name = "游客";
      return SingleChildScrollView(
          child: Container(
        alignment: Alignment.center,
        child: Column(
          children: <Widget>[
            Container(
              height: 300,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 90,
                    height: 90,
                    child: Text(GlobalNumbers.name.split('')[0],
                        style: TextStyle(fontSize: 60)),
                    alignment: Alignment.center,
                    decoration: new BoxDecoration(
                        color: Colors.lightBlue,
                        borderRadius: BorderRadius.all(Radius.circular(45.0))),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        GlobalNumbers.name,
                        textAlign: TextAlign.left,
                        style: TextStyle(fontSize: 30),
                      ),
                      Text(
                        getQuanxian(GlobalNumbers.quanxian),
                        textAlign: TextAlign.left,
                        style: TextStyle(fontSize: 20),
                      ),
                      Text(
                        "账号：" + GlobalNumbers.user,
                        textAlign: TextAlign.left,
                        style: TextStyle(fontSize: 20),
                      )
                    ],
                  ),
                ],
              ),
              alignment: Alignment.center,
              margin: EdgeInsets.fromLTRB(5, 0, 5, 0),
              padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
              decoration: new BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(15.0))),
            ),
            getUnusersetting(),
            getBase()
          ],
        ),
      ));
    }
  }
}
