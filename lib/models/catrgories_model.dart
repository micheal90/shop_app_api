class CategoriesModel {
  late bool status;
  late CategoriesDataModel data;
  CategoriesModel.fronJson(Map<String, dynamic> jsonData) {
    status = jsonData['status'];
    data = CategoriesDataModel.fromJson(jsonData['data']);
  }
}

class CategoriesDataModel {
  late int currentPage;
  List<DataModel> data = [];
  CategoriesDataModel.fromJson(Map<String, dynamic> jsonData) {
    currentPage = jsonData['current_page'];
    jsonData['data'].forEach((element) {
      data.add(DataModel.fromJson(element));
    });
  }
}

class DataModel {
  late int id;
  late String name;
  late String image;
  DataModel.fromJson(Map<String, dynamic> jsonData) {
    id = jsonData['id'];
    name = jsonData['name'];
    image = jsonData['image'];
  }
}
