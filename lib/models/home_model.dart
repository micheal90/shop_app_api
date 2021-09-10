class HomeModel {
  late bool status;
  late DataHomeModel data;

  HomeModel.fromJson(Map<String, dynamic> jsonData) {
    status = jsonData['status'];
    data = DataHomeModel.fromJson(jsonData['data']);
  }
}

class DataHomeModel {
  List<BannerModel> banners = [];
  List<ProductModel> products = [];
  DataHomeModel.fromJson(Map<String, dynamic> jsonData) {
    jsonData['banners']
        .forEach((element) => banners.add(BannerModel.fromJson(element)));
    jsonData['products']
        .forEach((element) => products.add(ProductModel.fromJason(element)));
  }
}

class BannerModel {
  late int id;
  late String image;
  BannerModel.fromJson(Map<String, dynamic> jsonData) {
    id = jsonData['id'];
    image = jsonData['image'];
  }
}

class ProductModel {
  late int id;
  late dynamic price;
  late dynamic oldPrice;
  late dynamic discount;
  late String image;
  late String name;
  late bool inFavorite;
  late bool inCart;

  ProductModel.fromJason(Map<String, dynamic> jsonData) {
    id = jsonData['id'];
    price = jsonData['price'];
    oldPrice = jsonData['old_price'];
    discount = jsonData['discount'];
    image = jsonData['image'];
    name = jsonData['name'];
    inFavorite = jsonData['in_favorites'];
    inCart = jsonData['in_cart'];
  }
}
