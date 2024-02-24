class OrderStatusBody {
  String? status;
  int? orderId;

  OrderStatusBody({this.status, this.orderId});

  OrderStatusBody.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    orderId = json['orderId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['orderId'] = orderId;
    //data['orderId'] = data['orderId'] != null ? int.tryParse(data['orderId']) : null;
    return data;
  }
}
