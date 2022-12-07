class HomeResponse {
  HomeResponseData? data;
  String? message;

  HomeResponse({this.data, this.message});

  HomeResponse.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? HomeResponseData.fromJson(json['data']) : null;
    message = json['message'];
  }
}

class HomeResponseData {
  List<Banners>? banners;
  List<Stories>? stories;

  HomeResponseData({this.banners, this.stories});

  HomeResponseData.fromJson(Map<String, dynamic> json) {
    if (json['banners'] != null) {
      banners = <Banners>[];
      json['banners'].forEach((v) {
        banners!.add(Banners.fromJson(v));
      });
    }
    if (json['stories'] != null) {
      stories = <Stories>[];
      json['stories'].forEach((v) {
        stories!.add(Stories.fromJson(v));
      });
    }
  }
}

class Banners {
  String? image;
  String? actionType;

  Banners({this.image, this.actionType});

  Banners.fromJson(Map<String, dynamic> json) {
    image = json['image'];
    actionType = json['action_type'];
  }
}

class Stories {
  String? assets1;
  String? assets2;
  String? assets3;
  int? ownerId;

  Stories({this.assets1, this.assets2, this.assets3, this.ownerId});

  Stories.fromJson(Map<String, dynamic> json) {
    assets1 = json['assets1'];
    assets2 = json['assets2'];
    assets3 = json['assets3'];
    ownerId = json['owner_id'];
  }
}
