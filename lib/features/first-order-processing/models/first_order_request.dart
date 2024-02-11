class OrderReservationRequest {
  int? foodId;

  OrderReservationRequest({this.foodId});

  OrderReservationRequest.fromJson(Map<String, dynamic> json) {
    foodId = json['foodId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['foodId'] = this.foodId;
    return data;
  }
}