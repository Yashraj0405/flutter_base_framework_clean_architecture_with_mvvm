


import 'package:flutter_base_framework_clean_architecture_with_mvvm/domain/entities/posts/postEntity.dart';
import 'package:flutter_base_framework_clean_architecture_with_mvvm/domain/repositories/posts/postRepository.dart';

class GetPostUseCase{

  final PostRepository postRepository;
  GetPostUseCase(this.postRepository);

  Future<List<PostEntity>> getPostsUsecase(){
    return postRepository.getPosts();
  }
}