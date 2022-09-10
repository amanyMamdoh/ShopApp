import 'dart:convert';

class CategoriesModel{
  bool? status;
  CategoryDataModel? dataModel;
  CategoriesModel({this.status,this.dataModel});
  CategoriesModel.fromJson(Map<String,dynamic>json){
  status=json['status'];
  dataModel=CategoryDataModel.fromJson(json['data']);
  }
}

class CategoryDataModel {
  int? currentPage;
 List <Data> dataList=[];
  CategoryDataModel.fromJson(Map<String,dynamic>json){
    currentPage=json['current_page'];
    Iterable data = json['data'];
    dataList = data.map((e) => Data.fromJson(e)).toList();

    }

  }

class Data {
  int? id;
  String? name;
  String? image;
  Data.fromJson(Map<String,dynamic>json){
    id=json['id'];
    name=json['name'];
    image=json['image'];
  }
}

