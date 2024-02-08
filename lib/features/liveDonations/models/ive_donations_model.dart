class LiveDonations {
  List<AllFoods>? allFoods;

  LiveDonations({this.allFoods});

  LiveDonations.fromJson(Map<String, dynamic> json) {
    if (json['allFoods'] != null) {
      allFoods = <AllFoods>[];
      json['allFoods'].forEach((v) {
        allFoods!.add(new AllFoods.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.allFoods != null) {
      data['allFoods'] = this.allFoods!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AllFoods {
  int? id;
  String? name;
  int? quantity;
  String? timeCooked;
  String? address;
  String? utensilsRequired;
  String? status;
  String? createdAt;
  String? updatedAt;
  int? userId;
  int? orderId;

  AllFoods(
      {this.id,
      this.name,
      this.quantity,
      this.timeCooked,
      this.address,
      this.utensilsRequired,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.userId,
      this.orderId});

  AllFoods.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    quantity = json['quantity'];
    timeCooked = json['timeCooked'];
    address = json['address'];
    utensilsRequired = json['utensilsRequired'];
    status = json['status'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    userId = json['userId'];
    orderId = json['orderId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['quantity'] = this.quantity;
    data['timeCooked'] = this.timeCooked;
    data['address'] = this.address;
    data['utensilsRequired'] = this.utensilsRequired;
    data['status'] = this.status;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['userId'] = this.userId;
    data['orderId'] = this.orderId;
    return data;
  }
}
