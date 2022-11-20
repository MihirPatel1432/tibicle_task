class MobileItemResponse {
  dynamic price;
  double? rating;
  String? description;
  int? id;
  String? name;
  String? thumbImageURL;
  String? brand;
  bool? isLiked;

  MobileItemResponse(
      {this.price,
        this.rating,
        this.description,
        this.id,
        this.name,
        this.thumbImageURL,
        this.brand,
      this.isLiked});

  MobileItemResponse.fromJson(Map<String, dynamic> json) {
    price = json['price'];
    rating = json['rating'];
    description = json['description'];
    id = json['id'];
    name = json['name'];
    thumbImageURL = json['thumbImageURL'];
    brand = json['brand'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['price'] = price;
    data['rating'] = rating;
    data['description'] = description;
    data['id'] = id;
    data['name'] = name;
    data['thumbImageURL'] = thumbImageURL;
    data['brand'] = brand;
    return data;
  }
}
