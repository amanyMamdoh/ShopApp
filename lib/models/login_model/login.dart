/*class ShopLoginModel{
late bool status;
late String message;
 UserData? data;
ShopLoginModel.fromJson(Map <String,dynamic> json){
  status=json['status'];
  message=json['message'];
  data!=(json['data'] !=null ? UserData.fromJson(json['data']):null)!;
}

ShopLoginModel();
}
class UserData{
  int? id;
  String? name;
  String? phone;
  String? email ;
  String? image;
  int? points;
  int? credit;
  String? token;

  UserData.fromJson(Map <String,dynamic> json){
    id!=json['id'];
    name!=json['name'];
    phone!=json['phone'];
    email!=json['email'];
    image!=json['image'];
    credit!=json['credit'];
    token=json['token'];
    points=json['points'];

  }
}*/
class ShopLoginModel {
  bool? status;
  String? message;
  Data? data;

  ShopLoginModel({this.status, this.message, this.data});

  ShopLoginModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? image;
  int? points;
  int? credit;
  String? token;

  Data(
      {this.id,
        this.name,
        this.email,
        this.phone,
        this.image,
        this.points,
        this.credit,
        this.token});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    image = json['image'];
    points = json['points'];
    credit = json['credit'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['image'] = this.image;
    data['points'] = this.points;
    data['credit'] = this.credit;
    data['token'] = this.token;
    return data;
  }
}