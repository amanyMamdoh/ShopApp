/*class HomeModel {
  bool? status;
  Data? data;

  HomeModel({this.status, this.data});

  HomeModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  /*Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }*/
}

class Data {
  // List<Banners>? banners=[];
  List<Products>? products = [];


  Data({this.products});

  Data.fromJson(Map<String, dynamic> json) {
    /*if (json['banners'] != null) {

      json['banners'].forEach((v) {
        banners!.add(v);
      });
    }*/
    if (json['products'] != null) {
      json['products'].forEach((v) {
        products!.add(v);
      });
    }
  }

/* Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.banners != null) {
      data['banners'] = this.banners!.map((v) => v.toJson()).toList();
    }
    if (this.products != null) {
      data['products'] = this.products!.map((v) => v.toJson()).toList();
    }

    return data;
  }*/

}
class Banners {
  int? id;
  String? image;

  Banners({this.id, this.image});

  Banners.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
  }

  /*Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['image'] = this.image;

    return data;
  }*/
}

class Products {
  int? id;
  dynamic? price;
  dynamic? oldPrice;
  dynamic? discount;
  String? image;
  String? name;
  bool? inFavorites;
  bool? inCart;

  Products(
      {this.id,
        this.price,
        this.oldPrice,
        this.discount,
        this.image,
        this.name,
        this.inFavorites,
        this.inCart});

  Products.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    inFavorites = json['in_favorites'];
    inCart = json['in_cart'];
  }

  /*Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['price'] = this.price;
    data['old_price'] = this.oldPrice;
    data['discount'] = this.discount;
    data['image'] = this.image;
    data['name'] = this.name;
    data['in_favorites'] = this.inFavorites;
    data['in_cart'] = this.inCart;
    return data;
  }*/
*/
class HomeModel {
  bool? status;
  DataModel? data;
  HomeModel.fromjson(Map<String, dynamic> json) {
    status = json['status'];
    data = DataModel.fromjson(json['data']);
  }
}

class DataModel {
  List<Banners> bannerList = [];
  List<Products> productList = [];
  DataModel.fromjson(Map<String, dynamic> json) {
    Iterable banners = json['banners'];
    bannerList = banners.map((e) => Banners.fromjson((e))).toList();
    Iterable products = json['products'];
    productList = products.map((e) => Products.fromjson((e))).toList();
  }
}

class Banners {
  int? id;
  String? image;

  Banners.fromjson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
  }
}

class Products {
  int? id;
  dynamic price;
  dynamic old_price;
  dynamic discount;
  String? image;
  String? name;
  bool? inFavorites;
  bool? inCart;

  Products.fromjson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    old_price = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    inFavorites = json['in_favorites'];
    inCart = json['in_cart'];
  }


}

