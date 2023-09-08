import 'package:flutter/material.dart';

class Routes {
  static String launcherScreen = 'launcherScreen';
  static String loginScreen = 'loginScreen';
  static String otpScreen = 'otpScreen';
  static String homeScreen = 'homeScreen';

  static PageRouteBuilder createRoute(Widget screen) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => screen,
      transitionDuration: const Duration(milliseconds: 500),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.0); // Bottom
        const end = Offset.zero; // Top
        const curve = Curves.easeInOut; // Animation curve

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        var offsetAnimation = animation.drive(tween);

        // Combine a SlideTransition and FadeTransition
        return SlideTransition(
          position: offsetAnimation,
          child: FadeTransition(opacity: animation, child: child),
        );
      },
    );
  }
}

// class RouteGenerator {
//   static Route<dynamic> getRoute(RouteSettings routeSettings) {
//     switch (routeSettings.name) {
//       case Routes.splashRoute:
//         return MaterialPageRoute(builder: (_) => SplashView());
//       case Routes.onBoardingRoute:
//         return MaterialPageRoute(builder: (_) => OnBoardingView());
//       case Routes.loginRoute:
//         return MaterialPageRoute(builder: (_) => LoginView());
//       case Routes.registerRoute:
//         return MaterialPageRoute(builder: (_) => RegisterView());
//       case Routes.forgotPasswordRoute:
//         return MaterialPageRoute(builder: (_) => ForgotPasswordView());
//       case Routes.mainRoute:
//         return MaterialPageRoute(builder: (_) => MainView());
//       case Routes.storeDetailsRoute:
//         return MaterialPageRoute(builder: (_) => StoreDetailsView());
//       default:
//         return UnDefinedRoute();
//     }
//   }

//   static Route<dynamic> UnDefinedRoute() {
//     return MaterialPageRoute(
//       builder: (_) => Scaffold(
//         appBar: AppBar(
//           title: const Text(AppStrings.noRouteFound),
//         ),
//         body: const Center(
//           child: Text(AppStrings.noRouteFound),
//         ),
//       ),
//     );
//   }
// }     
