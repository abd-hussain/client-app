class PostsResponse {
  List<PostsResponseData>? data;
  String? message;

  PostsResponse({this.data, this.message});

  PostsResponse.fromJson(Map<String, dynamic> json) {
    print(" PostsResponse.fromJson");

    if (json['data'] != null) {
      data = <PostsResponseData>[];
      json['data'].forEach((v) {
        data!.add(PostsResponseData.fromJson(v));
      });
    }
    message = json['message'];
  }
}

class PostsResponseData {
  int? id;
  String? content;
  int? ownerId;
  int? votes;

  PostsResponseData({this.id, this.content, this.ownerId, this.votes});

  PostsResponseData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    content = json['content'];
    ownerId = json['owner_id'];
    votes = json['votes'];
  }
}
