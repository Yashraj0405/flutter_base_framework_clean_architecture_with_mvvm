import 'package:flutter_base_framework_clean_architecture_with_mvvm/data/data_sources/remote_data_sources/posts/post_remoteDataSource.dart';
import 'package:flutter_base_framework_clean_architecture_with_mvvm/domain/entities/posts/postEntity.dart';
import 'package:flutter_base_framework_clean_architecture_with_mvvm/domain/repositories/posts/postRepository.dart';

class PostRepositoryImpl implements PostRepository {
  final remoteDataSource = PostRemoteDataSource();
  @override
  Future<List<PostEntity>> getPosts() async {
    final postModels = await remoteDataSource.getPosts();
    return postModels.map((model) => PostEntity.fromModel(model)).toList();
  }
}
