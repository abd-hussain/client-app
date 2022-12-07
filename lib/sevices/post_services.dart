import 'package:client_app/models/https/posts_response.dart';
import 'package:client_app/utils/mixins.dart';
import 'package:client_app/utils/repository/http_repository.dart';
import 'package:client_app/utils/repository/method_name_constractor.dart';

enum VoteType { up, down }

class PostService with Service {
  Future<PostsResponse> posts({required String search, required int limit, required int skip}) async {
    final response = await repository.callRequest(
      requestType: RequestType.get,
      methodName: MethodNameConstant.posts,
      queryParam: {"search": search, "limit": limit, "skip": skip},
    );
    return PostsResponse.fromJson(response);
  }

  Future<void> handleVote({required int postId, required VoteType voteType}) async {
    await repository.callRequest(
      requestType: RequestType.post,
      methodName: MethodNameConstant.vote,
      queryParam: {
        "postId": postId,
        "isItUp": voteType == VoteType.up ? true : false,
      },
    );
  }

  Future<PostsResponse> addPost({required String content}) async {
    final response = await repository.callRequest(
      requestType: RequestType.post,
      methodName: MethodNameConstant.posts,
      queryParam: {"content": content},
    );
    return PostsResponse.fromJson(response);
  }

  Future<PostsResponse> editPost({required String content, required int postId}) async {
    final response = await repository.callRequest(
      requestType: RequestType.put,
      methodName: MethodNameConstant.posts,
      queryParam: {"content": content, "postId": postId},
    );
    return PostsResponse.fromJson(response);
  }

  Future<PostsResponse> deletePost({required int postId}) async {
    final response = await repository.callRequest(
      requestType: RequestType.delete,
      methodName: MethodNameConstant.posts,
      queryParam: {"postId": postId},
    );
    print("response");
    print(response);
    return PostsResponse.fromJson(response);
  }
}
