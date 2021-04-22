class Login {
  int code;
  String msg;
  Data data;

  Login({this.code, this.msg, this.data});

  Login.fromJson(Map<String, dynamic> json) {
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
  String user;
  String name;
  String quanxian;

  Data({this.user, this.name, this.quanxian});

  Data.fromJson(Map<String, dynamic> json) {
    user = json['user'];
    name = json['name'];
    quanxian = json['quanxian'];
    print(quanxian);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user'] = this.user;
    data['name'] = this.name;
    data['quanxian'] = this.quanxian;
    return data;
  }
}
