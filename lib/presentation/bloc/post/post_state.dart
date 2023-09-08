// import 'package:equatable/equatable.dart';
// import 'package:flutter_base_framework_clean_architecture_with_mvvm/domain/entities/postEntity.dart';

// abstract class PostState extends Equatable {
//   @override
//   List<Object?> get props => [];
// }

// class PostInitial extends PostState {}

// class PostLoading extends PostState {}

// class PostLoaded extends PostState {
//   final List<PostEntity> posts;

//   PostLoaded(this.posts);

//   @override
//   List<Object?> get props => [posts];
// }

// class PostError extends PostState {
//   final String message;

//   PostError(this.message);

//   @override
//   List<Object?> get props => [message];
// }

import 'package:flutter_base_framework_clean_architecture_with_mvvm/domain/entities/posts/postEntity.dart';

abstract class PostState {}

class PostLoadingState extends PostState {}

class PostLoadedState extends PostState {
  final List<PostEntity> posts;
  PostLoadedState(this.posts);
}

class PostError extends PostState {
  final String error;
  PostError(this.error);
}
