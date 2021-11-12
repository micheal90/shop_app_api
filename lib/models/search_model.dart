class SearchModel {
  late bool status;
  late String? message;
  late SearchData data;

  SearchModel.fromJson(Map<String, dynamic> jsonData) {
    status = jsonData['status'];
    message = jsonData['message'];
    data = SearchData.fromJson(jsonData['data']);
  }
}

class SearchData {
  late int currentPage;

  List<SearchProduct> searchProducts = [];
  SearchData.fromJson(Map<String, dynamic> jsonData) {
    currentPage = jsonData['current_page'];

    jsonData['data'].forEach((elemnet) {
      searchProducts.add(SearchProduct.fromJson(elemnet));
    });
  }
}

class SearchProduct {
  late int id;
  dynamic price;
  late String image;
  late String name;
  late String description;
  late bool isFavorite;
  late bool inCart;
  SearchProduct.fromJson(Map<String, dynamic> jsonData) {
    id = jsonData['id'];
    price = jsonData['price'];
    image = jsonData['image'];
    name = jsonData['name'];
    description = jsonData['description'];
    isFavorite = jsonData['in_favorites'];
    inCart = jsonData['in_cart'];
  }
}
