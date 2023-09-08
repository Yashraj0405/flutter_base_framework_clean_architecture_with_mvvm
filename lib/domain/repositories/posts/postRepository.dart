

import 'package:flutter_base_framework_clean_architecture_with_mvvm/domain/entities/posts/postEntity.dart';

abstract class PostRepository{
  Future<List<PostEntity>> getPosts();
}