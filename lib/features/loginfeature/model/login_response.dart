class LoginResponse {
  int? id;
  String? username;
  String? email;
  String? accessToken;

  LoginResponse({this.id, this.username, this.email, this.accessToken});

  LoginResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    email = json['email'];
    accessToken = json['accessToken'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['username'] = this.username;
    data['email'] = this.email;
    data['accessToken'] = this.accessToken;
    return data;
  }
}