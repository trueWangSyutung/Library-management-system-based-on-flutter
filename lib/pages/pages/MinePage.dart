import 'dart:convert';

import 'package:demo01/GlobalNum/Numbers.dart';
import 'package:demo01/json/LoginBean.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class MinespageWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return MinespageWidgetState();
  }
}

class MinespageWidgetState extends State<MinespageWidget> {
  int count = 2;
  var quanxian1 = ["", "管理员", "老师", "学生", "注册用户", "普通访客"];
  var setInformation = ["设置中心", "您的权限"];
  var information = ["官方网站", "开源地址", "关于我们", "隐私协议"];
  var admin = ["图书上架处理", "图书表单审核", "用户控制中心"];

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

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List>(
        future: _login(GlobalNumbers.username, GlobalNumbers.password),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            var b = snapshot.data;

            if (b != null) {
              GlobalNumbers.name = b[0];
              GlobalNumbers.quanxian = b[1];
              GlobalNumbers.user = b[2];
              GlobalNumbers.code = b[3];
              if (GlobalNumbers.quanxian == "1") {
                return SingleChildScrollView(
                    child: Container(
                  alignment: Alignment.center,
                  child: Column(
                    children: <Widget>[
                      Container(
                        width: 300,
                        height: 300,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              width: 90,
                              height: 90,
                              child: Text(GlobalNumbers.name.split('')[0],
                                  style: TextStyle(fontSize: 60)),
                              alignment: Alignment.center,
                              decoration: new BoxDecoration(
                                  color: Colors.lightBlue,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(45.0))),
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
                        margin: EdgeInsets.fromLTRB(18, 0, 18, 0),
                        padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                        decoration: new BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(15.0))),
                      ),
                      Container(
                        child: ListView.separated(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            separatorBuilder: (BuildContext context,
                                    int index) =>
                                Container(
                                  padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                                  child:
                                      Divider(height: 2.0, color: Colors.black),
                                ),
                            itemCount: setInformation.length,
                            itemBuilder: (BuildContext context, int index) {
                              return FlatButton(
                                onPressed: () {},
                                child: Text(setInformation[index],
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 20)),
                              );
                            }),
                        margin: EdgeInsets.fromLTRB(18, 0, 18, 0),
                        padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                        decoration: new BoxDecoration(
                            color: Colors.lightBlue[200],
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0))),
                      ),
                      Container(
                        child: ListView.separated(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            separatorBuilder: (BuildContext context,
                                    int index) =>
                                Container(
                                  padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                                  child:
                                      Divider(height: 2.0, color: Colors.black),
                                ),
                            itemCount: information.length,
                            itemBuilder: (BuildContext context, int index) {
                              return FlatButton(
                                onPressed: () {},
                                child: Text(information[index],
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 20)),
                              );
                            }),
                        margin: EdgeInsets.fromLTRB(18, 10, 18, 0),
                        padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                        decoration: new BoxDecoration(
                            color: Colors.lightBlue[200],
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0))),
                      ),
                      Container(
                        child: ListView.separated(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            separatorBuilder: (BuildContext context,
                                    int index) =>
                                Container(
                                  padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                                  child:
                                      Divider(height: 2.0, color: Colors.black),
                                ),
                            itemCount: admin.length,
                            itemBuilder: (BuildContext context, int index) {
                              return FlatButton(
                                onPressed: () {},
                                child: Text(admin[index],
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 20)),
                              );
                            }),
                        margin: EdgeInsets.fromLTRB(18, 10, 18, 0),
                        padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                        decoration: new BoxDecoration(
                            color: Colors.lightBlue[200],
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0))),
                      ),
                    ],
                  ),
                ));
              } else {
                return SingleChildScrollView(
                    child: Container(
                  alignment: Alignment.center,
                  child: Column(
                    children: <Widget>[
                      Container(
                        width: 300,
                        height: 300,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              width: 90,
                              height: 90,
                              child: Text(GlobalNumbers.name.split('')[0],
                                  style: TextStyle(fontSize: 60)),
                              alignment: Alignment.center,
                              decoration: new BoxDecoration(
                                  color: Colors.lightBlue,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(45.0))),
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
                        margin: EdgeInsets.fromLTRB(18, 0, 18, 0),
                        padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                        decoration: new BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(15.0))),
                      ),
                      Container(
                        child: ListView.separated(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            separatorBuilder: (BuildContext context,
                                    int index) =>
                                Container(
                                  padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                                  child:
                                      Divider(height: 2.0, color: Colors.black),
                                ),
                            itemCount: setInformation.length,
                            itemBuilder: (BuildContext context, int index) {
                              return FlatButton(
                                onPressed: () {},
                                child: Text(setInformation[index],
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 20)),
                              );
                            }),
                        margin: EdgeInsets.fromLTRB(18, 0, 18, 0),
                        padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                        decoration: new BoxDecoration(
                            color: Colors.lightBlue[200],
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0))),
                      ),
                      Container(
                        child: ListView.separated(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            separatorBuilder: (BuildContext context,
                                    int index) =>
                                Container(
                                  padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                                  child:
                                      Divider(height: 2.0, color: Colors.black),
                                ),
                            itemCount: information.length,
                            itemBuilder: (BuildContext context, int index) {
                              return FlatButton(
                                onPressed: () {},
                                child: Text(information[index],
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 20)),
                              );
                            }),
                        margin: EdgeInsets.fromLTRB(18, 10, 18, 0),
                        padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                        decoration: new BoxDecoration(
                            color: Colors.lightBlue[200],
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0))),
                      ),
                    ],
                  ),
                ));
              }
            } else {
              return SingleChildScrollView(
                  child: Container(
                alignment: Alignment.center,
                child: Column(
                  children: <Widget>[
                    Container(
                      width: 300,
                      height: 300,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            width: 90,
                            height: 90,
                            child: Text(GlobalNumbers.name.split('')[0],
                                style: TextStyle(fontSize: 60)),
                            alignment: Alignment.center,
                            decoration: new BoxDecoration(
                                color: Colors.lightBlue,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(45.0))),
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
                      margin: EdgeInsets.fromLTRB(18, 0, 18, 0),
                      padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                      decoration: new BoxDecoration(
                          borderRadius:
                              BorderRadius.all(Radius.circular(15.0))),
                    ),
                    Container(
                      child: ListView.separated(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          separatorBuilder: (BuildContext context, int index) =>
                              Container(
                                padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                                child:
                                    Divider(height: 2.0, color: Colors.black),
                              ),
                          itemCount: setInformation.length,
                          itemBuilder: (BuildContext context, int index) {
                            return FlatButton(
                              onPressed: () {},
                              child: Text(setInformation[index],
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 20)),
                            );
                          }),
                      margin: EdgeInsets.fromLTRB(18, 0, 18, 0),
                      padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                      decoration: new BoxDecoration(
                          color: Colors.lightBlue[200],
                          borderRadius:
                              BorderRadius.all(Radius.circular(10.0))),
                    ),
                    Container(
                      child: ListView.separated(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          separatorBuilder: (BuildContext context, int index) =>
                              Container(
                                padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                                child:
                                    Divider(height: 2.0, color: Colors.black),
                              ),
                          itemCount: information.length,
                          itemBuilder: (BuildContext context, int index) {
                            return FlatButton(
                              onPressed: () {},
                              child: Text(information[index],
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 20)),
                            );
                          }),
                      margin: EdgeInsets.fromLTRB(18, 10, 18, 0),
                      padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                      decoration: new BoxDecoration(
                          color: Colors.lightBlue[200],
                          borderRadius:
                              BorderRadius.all(Radius.circular(10.0))),
                    ),
                  ],
                ),
              ));
            }
          } else {
            return Center(
              child: Container(
                  width: 200,
                  height: 200,
                  padding: EdgeInsets.all(20),
                  alignment: Alignment.center,
                  decoration: new BoxDecoration(
                      color: Colors.lightBlue[300],
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
