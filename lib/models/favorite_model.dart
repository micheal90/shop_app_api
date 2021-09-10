
class FavoriteModel {
  late bool status;
  String? message;
  late FavoriteModelData data;
  FavoriteModel.fromJson(Map<String, dynamic> jsonData) {
    status = jsonData['status'];
    message = jsonData['message'];
    data = FavoriteModelData.fromJson(jsonData['data']);
  }
}

class FavoriteModelData {
  late int currentPage;
   List<DataFavModel> favData=[];
  FavoriteModelData.fromJson(Map<String, dynamic> jsonData) {
    currentPage = jsonData['current_page'];
    jsonData['data'].forEach((element) {
      favData.add(DataFavModel.fromJson(element));
    });
  }
}

class DataFavModel {
  late int favoritId;
  late FavoriteProductModel productModel;
  DataFavModel.fromJson(Map<String, dynamic> jsonData) {
    favoritId = jsonData['id'];
    productModel = FavoriteProductModel.fromJson(jsonData['product']);
  }
}

class FavoriteProductModel {
  late int id;
   dynamic price;
   dynamic oldPrice;
   dynamic discount;
  late String image;
  late String name;
  late String description;
  FavoriteProductModel.fromJson(Map<String, dynamic> jsonData) {
    id = jsonData['id'];
    price = jsonData['price'];
    oldPrice = jsonData['old_price'];
    discount = jsonData['discount'];
    image = jsonData['image'];
    name = jsonData['name'];
    description = jsonData['description'];
  }
}

