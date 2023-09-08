import 'package:flutter/material.dart';
import 'package:flutter_base_framework_clean_architecture_with_mvvm/domain/entities/posts/postEntity.dart';

import '../../app/preference_manager.dart';
import '../manager/resources/color_manager.dart';
import '../manager/resources/font_manager.dart';
import '../manager/style/style.dart';

class PostWidget extends StatelessWidget {
  final PostEntity post;

  const PostWidget({required this.post});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              post.title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              post.body,
              style: TextStyle(fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}
