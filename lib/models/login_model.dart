class LoginModel {
  bool status;
  String message;
  UserData? data;
  LoginModel({
    required this.status,
    required this.message,
    required this.data,
  });

  Map<String, dynamic> toMap() {
    return {
      'status': status,
      'message': message,
      'data': data!.toMap(),
    };
  }

  factory LoginModel.fromMap(Map<String, dynamic> jsonData) {
    return LoginModel(
      status: jsonData['status'],
      message: jsonData['message'],
      data:
          jsonData['data'] != null ? UserData.fromMap(jsonData['data']) : null,
    );
  }
}

class UserData {
  int id;
  String name;
  String email;
  String phone;
  String image;
  String token;
  UserData({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.image,
    required this.token,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'image': image,
      'token': token,
    };
  }

  factory UserData.fromMap(Map<String, dynamic> jasonData) {
    return UserData(
      id: jasonData['id'],
      name: jasonData['name'],
      email: jasonData['email'],
      phone: jasonData['phone'],
      image: jasonData['image'],
      token: jasonData['token'],
    );
  }
}
