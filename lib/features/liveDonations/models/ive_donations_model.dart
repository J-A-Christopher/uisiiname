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
  String? imageUrl;
  String? name;
  String? dateOfPreparation;
  String? timeOfPreparation;
  String? timeRequiredForDelivery;
  int? quantity;
  String? address;
  String? utensilsRequired;
  String? status;
  String? createdAt;
  String? updatedAt;
  int? userId;
  Null? orderId;

  AllFoods(
      {this.id,
      this.imageUrl,
      this.name,
      this.dateOfPreparation,
      this.timeOfPreparation,
      this.timeRequiredForDelivery,
      this.quantity,
      this.address,
      this.utensilsRequired,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.userId,
      this.orderId});

  AllFoods.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    imageUrl = json['imageUrl'];
    name = json['name'];
    dateOfPreparation = json['dateOfPreparation'];
    timeOfPreparation = json['timeOfPreparation'];
    timeRequiredForDelivery = json['timeRequiredForDelivery'];
    quantity = json['quantity'];
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
    data['imageUrl'] = this.imageUrl;
    data['name'] = this.name;
    data['dateOfPreparation'] = this.dateOfPreparation;
    data['timeOfPreparation'] = this.timeOfPreparation;
    data['timeRequiredForDelivery'] = this.timeRequiredForDelivery;
    data['quantity'] = this.quantity;
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