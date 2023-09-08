import 'package:flutter_base_framework_clean_architecture_with_mvvm/data/model/posts/postModel.dart';

class PostEntity {
  final int userId;
  final int id;
  final String title;
  final String body;

  PostEntity({
    required this.userId,
    required this.id,
    required this.title,
    required this.body,
  });

  factory PostEntity.fromModel(PostModel model) {
    return PostEntity(
      userId: model.userId,
      id: model.id,
      title: model.title,
      body: model.body,
    );
  }
}
