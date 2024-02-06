class SignUpModelResponse {
  String? message;
  UserData? userData;

  SignUpModelResponse({this.message, this.userData});

  SignUpModelResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    userData = json['userData'] != null
        ? new UserData.fromJson(json['userData'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.userData != null) {
      data['userData'] = this.userData!.toJson();
    }
    return data;
  }
}

class UserData {
  int? id;
  String? firstname;
  String? lastname;
  String? username;
  String? email;
  String? password;
  String? pushToken;
  String? phoneNumber;
  String? donationType;
  String? updatedAt;
  String? createdAt;

  UserData(
      {this.id,
      this.firstname,
      this.lastname,
      this.username,
      this.email,
      this.password,
      this.pushToken,
      this.phoneNumber,
      this.donationType,
      this.updatedAt,
      this.createdAt});

  UserData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstname = json['firstname'];
    lastname = json['lastname'];
    username = json['username'];
    email = json['email'];
    password = json['password'];
    pushToken = json['pushToken'];
    phoneNumber = json['phoneNumber'];
    donationType = json['donationType'];
    updatedAt = json['updatedAt'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['firstname'] = this.firstname;
    data['lastname'] = this.lastname;
    data['username'] = this.username;
    data['email'] = this.email;
    data['password'] = this.password;
    data['pushToken'] = this.pushToken;
    data['phoneNumber'] = this.phoneNumber;
    data['donationType'] = this.donationType;
    data['updatedAt'] = this.updatedAt;
    data['createdAt'] = this.createdAt;
    return data;
  }
}