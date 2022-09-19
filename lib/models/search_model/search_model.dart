
class SearchModel {
  bool? status;
  SearchData? data;
  SearchModel.fromjson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? SearchData.fromjson(json['data']) : null;
   // json['data'] != null ? new Data.fromJson(json['data']) : null;
  }
}

class SearchData {
  List<ProductSearch>? productl;
  SearchData.fromjson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      Iterable data = json['data'];
      productl = data.map((e) => ProductSearch.fromjson((e))).toList();
    }
  }
}

class ProductSearch {
  int? id;
  dynamic? price;
  String? name;
  String? image;
  ProductSearch.fromjson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    name = json['name'];
    image = json['image'];
  }
}

/*class SearchModel {
  bool? status;
  SearchDataModel? data;
  SearchModel.fromjson(Map<String, dynamic> json) {
    status = json['status'];
    data = SearchDataModel.fromjson(json['data']);
  }
}

class SearchDataModel {
  List<ProductSearchModel>? productlist;
  SearchDataModel.fromjson(Map<String, dynamic> json) {
    Iterable data = json['data'];
    productlist = data.map((e) => ProductSearchModel.fromjson((e))).toList();
  }
}

class ProductSearchModel {
  int? id;
  dynamic? price;
  dynamic? old_price;
  dynamic? discount;
  String? name;
  String? image;
  ProductSearchModel.fromjson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    discount = json['discount'];
    name = json['name'];
    image = json['image'];
  }
}
*/