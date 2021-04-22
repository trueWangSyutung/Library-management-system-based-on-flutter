import 'dart:convert';

import 'package:demo01/json/Book.dart';
import 'package:demo01/json/BooksBean.dart';
import 'package:demo01/json/LoginBean.dart';
import 'package:dio/dio.dart';

class GlobalNumbers {
  static String quanxian = '5';
  static String user = "ghost";
  static String name = "访客用户";
  static int code = 0;
  static List<Book> book_list = List();
  static String username = "0";
  static String password = "0";
  static var quanxian1 = ["", "管理员", "老师", "学生", "注册用户", "普通访客"];

  static getNewBook() async {
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
      } catch (e) {
        return print(e);
      }
    }
  }

  static Future<List> _login(String username, String password) async {
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
}
