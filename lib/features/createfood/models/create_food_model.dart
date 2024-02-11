class FoodResponse {
  String? imageUrl;
  String? name;
  String? dateOfPreparation;
  String? timeOfPreparation;
  String? timeRequiredForDelivery;
  String? quantity;
  String? address;
  String? utensilsRequired;
  String? donationType;

  FoodResponse(
      {this.imageUrl,
      this.name,
      this.dateOfPreparation,
      this.timeOfPreparation,
      this.timeRequiredForDelivery,
      this.quantity,
      this.address,
      this.utensilsRequired,
      this.donationType});

  FoodResponse.fromJson(Map<String, dynamic> json) {
    imageUrl = json['imageUrl'];
    name = json['name'];
    dateOfPreparation = json['dateOfPreparation'];
    timeOfPreparation = json['timeOfPreparation'];
    timeRequiredForDelivery = json['timeRequiredForDelivery'];
    quantity = json['quantity'];
    address = json['address'];
    utensilsRequired = json['utensilsRequired'];
    donationType = json['donationType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['imageUrl'] = this.imageUrl;
    data['name'] = this.name;
    data['dateOfPreparation'] = this.dateOfPreparation;
    data['timeOfPreparation'] = this.timeOfPreparation;
    data['timeRequiredForDelivery'] = this.timeRequiredForDelivery;
    data['quantity'] = this.quantity;
    data['address'] = this.address;
    data['utensilsRequired'] = this.utensilsRequired;
    data['donationType'] = this.donationType;
    return data;
  }
}