class ChangeFavoriteModel {
  late bool status;
  late String message;
  ChangeFavoriteModel.fromJson(Map<String, dynamic> jsonData) {
    status = jsonData['status'];
    message = jsonData['message'];
  }
}
