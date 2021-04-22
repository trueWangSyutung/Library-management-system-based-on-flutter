class Books {
  int code;
  String msg;
  Data data;

  Books({this.code, this.msg, this.data});

  Books.fromJson(Map<String, dynamic> json) {
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
  String s6;
  String s7;
  String s8;
  String s9;
  String s10;
  String s11;
  String bookId;
  String isbn;
  String bookName;
  String bookPrice;
  String author;
  String bookPub;
  String bookPubdate;
  String shifoujiechu;
  String counter;
  String returntime;
  String borrow;
  String borrowedBy;

  DataSet(
      {this.s0,
      this.s1,
      this.s2,
      this.s3,
      this.s4,
      this.s5,
      this.s6,
      this.s7,
      this.s8,
      this.s9,
      this.s10,
      this.s11,
      this.bookId,
      this.isbn,
      this.bookName,
      this.bookPrice,
      this.author,
      this.bookPub,
      this.bookPubdate,
      this.shifoujiechu,
      this.counter,
      this.returntime,
      this.borrow,
      this.borrowedBy});

  DataSet.fromJson(Map<String, dynamic> json) {
    s0 = json['0'];
    s1 = json['1'];
    s2 = json['2'];
    s3 = json['3'];
    s4 = json['4'];
    s5 = json['5'];
    s6 = json['6'];
    s7 = json['7'];
    s8 = json['8'];
    s9 = json['9'];
    s10 = json['10'];
    s11 = json['11'];
    bookId = json['book_id'];
    isbn = json['isbn'];
    bookName = json['book_name'];
    bookPrice = json['book_price'];
    author = json['author'];
    bookPub = json['book_pub'];
    bookPubdate = json['book_pubdate'];
    shifoujiechu = json['shifoujiechu'];
    counter = json['counter'];
    returntime = json['returntime'];
    borrow = json['borrow'];
    borrowedBy = json['borrowed_by'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['0'] = this.s0;
    data['1'] = this.s1;
    data['2'] = this.s2;
    data['3'] = this.s3;
    data['4'] = this.s4;
    data['5'] = this.s5;
    data['6'] = this.s6;
    data['7'] = this.s7;
    data['8'] = this.s8;
    data['9'] = this.s9;
    data['10'] = this.s10;
    data['11'] = this.s11;
    data['book_id'] = this.bookId;
    data['isbn'] = this.isbn;
    data['book_name'] = this.bookName;
    data['book_price'] = this.bookPrice;
    data['author'] = this.author;
    data['book_pub'] = this.bookPub;
    data['book_pubdate'] = this.bookPubdate;
    data['shifoujiechu'] = this.shifoujiechu;
    data['counter'] = this.counter;
    data['returntime'] = this.returntime;
    data['borrow'] = this.borrow;
    data['borrowed_by'] = this.borrowedBy;
    return data;
  }
}
