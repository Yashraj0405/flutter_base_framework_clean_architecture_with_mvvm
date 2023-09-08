import 'package:flutter/material.dart';

import 'package:flutter_base_framework_clean_architecture_with_mvvm/app/preference_manager.dart';
import 'package:flutter_base_framework_clean_architecture_with_mvvm/data/repositories/posts/postRepositoryImpl.dart';
import 'package:flutter_base_framework_clean_architecture_with_mvvm/domain/repositories/posts/postRepository.dart';
import 'package:flutter_base_framework_clean_architecture_with_mvvm/domain/usecases/posts/postUsecase.dart';
import 'package:flutter_base_framework_clean_architecture_with_mvvm/presentation/bloc/post/post_bloc.dart';
import 'package:flutter_base_framework_clean_architecture_with_mvvm/presentation/bloc/post/post_event.dart';
import 'package:flutter_base_framework_clean_architecture_with_mvvm/presentation/bloc/post/post_state.dart';
import 'package:flutter_base_framework_clean_architecture_with_mvvm/presentation/manager/resources/color_manager.dart';
import 'package:flutter_base_framework_clean_architecture_with_mvvm/presentation/manager/resources/font_manager.dart';
import 'package:flutter_base_framework_clean_architecture_with_mvvm/presentation/manager/resources/value_manager.dart';
import 'package:flutter_base_framework_clean_architecture_with_mvvm/presentation/manager/style/style.dart';
import 'package:flutter_base_framework_clean_architecture_with_mvvm/presentation/widgets/customAppBar.dart';
import 'package:flutter_base_framework_clean_architecture_with_mvvm/presentation/widgets/navigation_drawer.dart'
    as nav_drawer;
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../widgets/postItemWidget.dart';

class HomeScreen extends StatefulWidget {
  // Route name for navigation purposes.
  static const routeName = "/HomeScreen";
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  GlobalKey drawerKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colormanager.white,
      appBar: const CustomAppBar(
        "Home Screen",
        elevation: 2,
        backgroundColor: Colors.white,
      ),
      drawer: nav_drawer.NavigationDrawer(
        key: drawerKey,
      ),
      body: BlocProvider(
        create: (context) => PostCubit(GetPostUseCase(PostRepositoryImpl())),
        child: BlocBuilder<PostCubit, PostState>(
          builder: (context, state) {
            if (state is PostLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is PostLoadedState) {
              return ListView.builder(
                itemCount: state.posts.length,
                itemBuilder: (context, index) {
                  return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 1, vertical: 1),
                      child: Style.getCardViewWithBorder(
                        5,
                        Colormanager.indigoAccent.withOpacity(0.5),
                        1,
                        ListTile(
                          // leading: Text(state.posts[index].id.toString()),
                          title: Text(
                            state.posts[index].title.toString(),
                          ),
                          subtitle: Text(state.posts[index].body.toString()),
                        ),
                      ));
                },
              );
            }
            return const Center(
              child: Text("An Error Occured!"),
            );
          },
        ),
      ),
    );
  }
}


//  Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               // Display the title "Token :"
//               Center(
//                 child: Style.getBoldText(
//                   "Token :",
//                   FontSize.textSize20,
//                   Colormanager.black,
//                 ),
//               ),
//               // Display the user's access token retrieved from shared preferences.
//               Center(
//                 child: Style.getBoldText(
//                   PreferenceManager.getAccessToken()!,
//                   FontSize.textSize20,
//                   Colormanager.black,
//                 ),
//               ),
//             ],
//           ),