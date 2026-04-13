import 'package:flutter/material.dart';
import '../screens/splash_screen.dart';
import '../screens/login_screen.dart';
import '../screens/home/homescreen.dart';
import '../screens/details_screen.dart';
import '../screens/cadastro_screen.dart';

class AppRoutes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => SplashScreen());

      case '/login':
        return _createFadeRoute(SignInScreen());

      case '/register':
        return _createFadeRoute(CadastroScreen());

      case '/home':
        return _createFadeRoute(HomePage());

      case '/details':
        return _createFadeRoute(DetailsScreen());

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('Rota ${settings.name} não encontrada')),
          ),
        );
    }
  }

  static Route _createFadeRoute(Widget screen) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => screen,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: CurvedAnimation(
            parent: animation,
            curve: Curves.easeIn,
          ),
          child: child,
        );
      },
      transitionDuration: const Duration(milliseconds: 500),
      reverseTransitionDuration: const Duration(milliseconds: 500),
    );
  }
}
