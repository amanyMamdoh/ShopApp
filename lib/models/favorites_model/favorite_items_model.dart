class FavoriteItemsModel {
  bool? status;
  FavoriteItemData? data;
  FavoriteItemsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? new FavoriteItemData.fromJson(json['data']) : null;
  }
}

class FavoriteItemData {
  int? currentPage;
  List<Data>? data;
  FavoriteItemData.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      Iterable favdata = json['data'];
      data = favdata.map((e) =>Data.fromJson((e))).toList();
    }

  }
}
class Data {
  int? id;
  Product? product;

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    product = json['product'] != null ? new Product.fromJson(json['product']) : null;
  }


}

class Product {
  int? id;
  dynamic? price;
  dynamic? oldPrice;
  dynamic? discount;
  String? image;
  String? name;
  String? description;

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
  }


}
