class ProfileFetchModel {
  UserModel? userModel;

  ProfileFetchModel({this.userModel});

  ProfileFetchModel.fromJson(Map<String, dynamic> json) {
    userModel = json['userModel'] != null
        ? new UserModel.fromJson(json['userModel'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.userModel != null) {
      data['userModel'] = this.userModel!.toJson();
    }
    return data;
  }
}

class UserModel {
  int? id;
  String? firstname;
  String? profilePicture;
  String? lastname;
  String? username;
  String? email;
  String? phoneNumber;
  String? donationType;
  String? createdAt;
  String? updatedAt;

  UserModel(
      {this.id,
      this.firstname,
      this.profilePicture,
      this.lastname,
      this.username,
      this.email,
      this.phoneNumber,
      this.donationType,
      this.createdAt,
      this.updatedAt});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstname = json['firstname'];
    profilePicture = json['profilePicture'];
    lastname = json['lastname'];
    username = json['username'];
    email = json['email'];
    phoneNumber = json['phoneNumber'];
    donationType = json['donationType'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['firstname'] = this.firstname;
    data['profilePicture'] = this.profilePicture;
    data['lastname'] = this.lastname;
    data['username'] = this.username;
    data['email'] = this.email;
    data['phoneNumber'] = this.phoneNumber;
    data['donationType'] = this.donationType;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}

