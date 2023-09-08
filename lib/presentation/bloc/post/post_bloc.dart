// import 'package:flutter_base_framework_clean_architecture_with_mvvm/presentation/bloc/post/post_event.dart';
// import 'package:flutter_base_framework_clean_architecture_with_mvvm/presentation/bloc/post/post_state.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// import '../../../domain/usecases/postUsecase.dart';

// class PostBloc extends Bloc<PostEvent, PostState> {
//   final GetPostUseCase getPostUseCase;

//   PostBloc(this.getPostUseCase) : super(PostInitial()) {
//     on<FetchPosts>(_onFetchPosts); // Register the event handler
//   }

//   Stream<void> _onFetchPosts(FetchPosts event, Emitter<PostState> emit) async* {
//     yield PostLoading();
//     try {
//       final posts = await getPostUseCase.getPostsUsecase();
//       yield PostLoaded(posts);
//     } catch (e) {
//       yield PostError('Failed to fetch posts');
//     }
//   }

//   @override
//   Stream<PostState> mapEventToState(PostEvent event) async* {
//     // Handle other events here if needed
//   }
// }

import 'package:flutter_base_framework_clean_architecture_with_mvvm/presentation/bloc/post/post_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/posts/postUsecase.dart';

class PostCubit extends Cubit<PostState> {
  final GetPostUseCase getPostUseCase;
  PostCubit(this.getPostUseCase) : super(PostLoadingState()) {
    fetchPosts();
  }

  void fetchPosts() async {
    try {
      final posts = await getPostUseCase.getPostsUsecase();
      emit(PostLoadedState(posts));
    } catch (e) {
      emit(PostError(e.toString()));
    }
  }
}
