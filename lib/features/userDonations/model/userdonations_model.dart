class UserDonations {
  List<NewDataStructure>? newDataStructure;

  UserDonations({this.newDataStructure});

  UserDonations.fromJson(Map<String, dynamic> json) {
    if (json['newDataStructure'] != null) {
      newDataStructure = <NewDataStructure>[];
      json['newDataStructure'].forEach((v) {
        newDataStructure!.add(new NewDataStructure.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.newDataStructure != null) {
      data['newDataStructure'] =
          this.newDataStructure!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class NewDataStructure {
  Food? food;
  Order? order;

  NewDataStructure({this.food, this.order});

  NewDataStructure.fromJson(Map<String, dynamic> json) {
    food = json['food'] != null ? new Food.fromJson(json['food']) : null;
    order = json['order'] != null ? new Order.fromJson(json['order']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.food != null) {
      data['food'] = this.food!.toJson();
    }
    if (this.order != null) {
      data['order'] = this.order!.toJson();
    }
    return data;
  }
}

class Food {
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

  Food(
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

  Food.fromJson(Map<String, dynamic> json) {
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

class Order {
  int? id;
  int? foodId;
  int? recipeintId;
  int? senderId;
  String? status;
  String? createdAt;
  String? updatedAt;
  int? userId;

  Order(
      {this.id,
      this.foodId,
      this.recipeintId,
      this.senderId,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.userId});

  Order.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    foodId = json['foodId'];
    recipeintId = json['recipeintId'];
    senderId = json['senderId'];
    status = json['status'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    userId = json['userId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['foodId'] = this.foodId;
    data['recipeintId'] = this.recipeintId;
    data['senderId'] = this.senderId;
    data['status'] = this.status;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['userId'] = this.userId;
    return data;
  }
}

