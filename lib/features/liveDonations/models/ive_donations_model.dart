class LiveDonations {
  List<AllFoods>? allFoods;

  LiveDonations({this.allFoods});

  LiveDonations.fromJson(Map<String, dynamic> json) {
    if (json['allFoods'] != null) {
      allFoods = <AllFoods>[];
      json['allFoods'].forEach((v) {
        allFoods!.add(AllFoods.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (allFoods != null) {
      data['allFoods'] = allFoods!.map((v) => v.toJson()).toList();
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
  int? orderId;

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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['imageUrl'] = imageUrl;
    data['name'] = name;
    data['dateOfPreparation'] = dateOfPreparation;
    data['timeOfPreparation'] = timeOfPreparation;
    data['timeRequiredForDelivery'] = timeRequiredForDelivery;
    data['quantity'] = quantity;
    data['address'] = address;
    data['utensilsRequired'] = utensilsRequired;
    data['status'] = status;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['userId'] = userId;
    data['orderId'] = orderId;
    return data;
  }
}
