class DiscountModel {
  int? data;
  String? message;

  DiscountModel({this.data, this.message});

  DiscountModel.fromJson(Map<String, dynamic> json) {
    data = json['data'];
    message = json['message'];
  }
}
