import 'package:flutter/material.dart';
import 'package:news/utils/routes/routes_names.dart';
import 'package:news/view/discover_more_view.dart';
import 'package:news/view/explain_more_view.dart';
import 'package:news/view/home_view.dart';

import '../../model/get_api_model.dart';

class NavigationService {
  static Widget _buildTransition(
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child) {
    const begin = Offset(1.0, 0.0);
    const end = Offset.zero;
    const curve = Curves.easeInOut;
    var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
    var offsetAnimation = animation.drive(tween);
    return SlideTransition(
      position: offsetAnimation,
      child: child,
    );
  }

  static Widget _getScreen(String routeName, {Articles? article}) {
    switch (routeName) {
      case RoutesNames.discoverScreenView:
        return const DiscoverMoreViewScreen();
      case RoutesNames.homeScreenView:
        return const HomeScreenView();
      case RoutesNames.explainMoreScreenView:
        if (article != null) {
          print("Navigating with article: ${article.title}");
          return ExplainMoreScreen(article: article);
        }
        else {
          return const Scaffold(
            body: Center(
              child: Text(
                "No article provided",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Poppins",
                ),
              ),
            ),
          );
        }
      default:
        return const Scaffold(
          body: Center(
            child: Text(
              "Route Not Found",
              style: TextStyle(
                color: Colors.black,
                fontSize: 30,
                fontWeight: FontWeight.bold,
                fontFamily: "Poppins",
              ),
            ),
          ),
        );
    }
  }


  static void navigateWithTransition(BuildContext context, String routeName, {Articles? article}) {
    Navigator.push(
      context,
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 500),
        pageBuilder: (context, animation, secondaryAnimation) =>
            _getScreen(routeName, article: article),
        transitionsBuilder: _buildTransition,
      ),
    );
  }


  static Route<dynamic> generateRoutes(RouteSettings settings) {
    final args = settings.arguments as Articles?;
    return MaterialPageRoute(
      builder: (_) => _getScreen(settings.name ?? '', article: args),
    );
  }

}
