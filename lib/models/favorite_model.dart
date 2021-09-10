class FavoriteModel {
  late bool status;
  late String message;
  FavoriteModel.fromJson(Map<String, dynamic> jsonData) {
    status = jsonData['status'];
    message = jsonData['message'];
  }
}
