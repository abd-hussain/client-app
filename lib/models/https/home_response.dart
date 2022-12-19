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
  List<MainBanner>? mainBanner;
  List<MainStory>? mainStory;
  List<MainTips>? mainTips;

  HomeResponseData({this.mainBanner, this.mainStory, this.mainTips});

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
    if (json['main_tips'] != null) {
      mainTips = <MainTips>[];
      json['main_tips'].forEach((v) {
        mainTips!.add(MainTips.fromJson(v));
      });
    }
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
}

class MainTips {
  int? id;
  int? catId;
  String? title;
  String? desc;
  String? note;
  String? referance;
  String? image;
  int? steps;

  MainTips({this.id, this.catId, this.title, this.desc, this.note, this.referance, this.image, this.steps});

  MainTips.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    catId = json['category_id'];
    title = json['title'];
    desc = json['desc'];
    note = json['note'];
    referance = json['referance'];
    image = json['image'];
    steps = json['steps'];
  }
}
