class MobileImageResponse {
  int? id;
  String? url;
  int? mobileId;

  MobileImageResponse({this.id, this.url, this.mobileId});

  MobileImageResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    url = json['url'];
    mobileId = json['mobile_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['url'] = url;
    data['mobile_id'] = mobileId;
    return data;
  }
}
