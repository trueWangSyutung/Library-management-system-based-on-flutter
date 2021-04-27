class Borrows {
  int code;
  String msg;
  Data data;

  Borrows({this.code, this.msg, this.data});

  Borrows.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    msg = json['msg'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['msg'] = this.msg;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class Data {
  int size;
  List<DataSet> dataSet;

  Data({this.size, this.dataSet});

  Data.fromJson(Map<String, dynamic> json) {
    size = json['size'];
    if (json['dataSet'] != null) {
      dataSet = new List<DataSet>();
      json['dataSet'].forEach((v) {
        dataSet.add(new DataSet.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['size'] = this.size;
    if (this.dataSet != null) {
      data['dataSet'] = this.dataSet.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DataSet {
  String s0;
  String s1;
  String s2;
  String s3;
  String s4;
  String s5;
  String id;
  String user;
  String bookId;
  String borrowedTime;
  String returnTime;
  String statue;

  DataSet(
      {this.s0,
      this.s1,
      this.s2,
      this.s3,
      this.s4,
      this.s5,
      this.id,
      this.user,
      this.bookId,
      this.borrowedTime,
      this.returnTime,
      this.statue});

  DataSet.fromJson(Map<String, dynamic> json) {
    s0 = json['0'];
    s1 = json['1'];
    s2 = json['2'];
    s3 = json['3'];
    s4 = json['4'];
    s5 = json['5'];
    id = json['id'];
    user = json['user'];
    bookId = json['book_id'];
    borrowedTime = json['borrowed_time'];
    returnTime = json['return_time'];
    statue = json['statue'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['0'] = this.s0;
    data['1'] = this.s1;
    data['2'] = this.s2;
    data['3'] = this.s3;
    data['4'] = this.s4;
    data['5'] = this.s5;
    data['id'] = this.id;
    data['user'] = this.user;
    data['book_id'] = this.bookId;
    data['borrowed_time'] = this.borrowedTime;
    data['return_time'] = this.returnTime;
    data['statue'] = this.statue;
    return data;
  }
}
