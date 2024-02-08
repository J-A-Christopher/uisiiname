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
  Order? order;
  Food? food;

  NewDataStructure({this.order, this.food});

  NewDataStructure.fromJson(Map<String, dynamic> json) {
    order = json['order'] != null ? new Order.fromJson(json['order']) : null;
    food = json['food'] != null ? new Food.fromJson(json['food']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.order != null) {
      data['order'] = this.order!.toJson();
    }
    if (this.food != null) {
      data['food'] = this.food!.toJson();
    }
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

class Food {
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

  Food(
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

  Food.fromJson(Map<String, dynamic> json) {
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
