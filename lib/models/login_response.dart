class LoginResponse {
  String? status;
  String? message;
  String? token;

  LoginResponse({this.status, this.message, this.token});

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      status: json['status'],
      message: json['message'],
      token: json['token'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'status': status, 'message': message, 'token': token};
  }
}
