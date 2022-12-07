class HomeResponse {
  HomeResponseData? data;
  String? message;

  HomeResponse({this.data, this.message});

  HomeResponse.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? HomeResponseData.fromJson(json['data']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = message;
    return data;
  }
}

class HomeResponseData {
  List<MainBanner>? mainBanner;
  List<MainStory>? mainStory;

  HomeResponseData({this.mainBanner, this.mainStory});

  HomeResponseData.fromJson(Map<String, dynamic> json) {
    if (json['main_banner'] != null) {
      mainBanner = <MainBanner>[];
      json['main_banner'].forEach((v) {
        mainBanner!.add(MainBanner.fromJson(v));
      });
    }
    if (json['main_story'] != null) {
      mainStory = <MainStory>[];
      json['main_story'].forEach((v) {
        mainStory!.add(MainStory.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (mainBanner != null) {
      data['main_banner'] = mainBanner!.map((v) => v.toJson()).toList();
    }
    if (mainStory != null) {
      data['main_story'] = mainStory!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MainBanner {
  String? image;
  String? actionType;

  MainBanner({this.image, this.actionType});

  MainBanner.fromJson(Map<String, dynamic> json) {
    image = json['image'];
    actionType = json['action_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['image'] = image;
    data['action_type'] = actionType;
    return data;
  }
}

class MainStory {
  int? id;
  String? assets;
  Owner? owner;

  MainStory({this.id, this.assets, this.owner});

  MainStory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    assets = json['assets'];
    owner = json['owner'] != null ? Owner.fromJson(json['owner']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['assets'] = assets;
    if (owner != null) {
      data['owner'] = owner!.toJson();
    }
    return data;
  }
}

class Owner {
  int? id;
  String? firstName;
  String? lastName;
  int? gender;
  bool? blocked;
  String? profileImg;
  int? countryId;

  Owner({this.id, this.firstName, this.lastName, this.gender, this.blocked, this.profileImg, this.countryId});

  Owner.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    gender = json['gender'];
    blocked = json['blocked'];
    profileImg = json['profile_img'];
    countryId = json['country_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['gender'] = gender;
    data['blocked'] = blocked;
    data['profile_img'] = profileImg;
    data['country_id'] = countryId;
    return data;
  }
}
