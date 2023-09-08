import 'dart:convert';

import 'package:flutter_base_framework_clean_architecture_with_mvvm/data/model/posts/postModel.dart';
import 'package:http/http.dart' as http;

class PostRemoteDataSource {
  final httpClient = http.Client();

  final baseUrl = 'https://jsonplaceholder.typicode.com/posts';

  Future<List<PostModel>> getPosts() async {
    final response = await httpClient.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      final body = response.body;
      final posts = jsonDecode(body) as List;
      return posts.map((post) => PostModel.fromJson(post)).toList();
    } else {
      throw Exception("Failed to get posts");
    }
  }
}
