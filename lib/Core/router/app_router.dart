

import 'package:flutter/material.dart';
import 'package:todo_task/Core/const/screens_Names.dart';
import 'package:todo_task/Core/router/custom_page_route.dart';
import 'package:todo_task/features/authentication/presentation/screens/login.dart';
import 'package:todo_task/features/authentication/presentation/screens/register.dart';
import 'package:todo_task/features/authentication/presentation/screens/onbording/second_intro.dart';
import 'package:todo_task/features/home/presentation/screens/home.dart';
import 'package:todo_task/features/home/presentation/screens/todos_screen.dart';
import 'package:todo_task/main.dart';

import '../../features/authentication/presentation/screens/onbording/intro_screen.dart';


class AppRouter {
  late Widget startScreen;

  Route? onGenerateRoute(RouteSettings settings) {
    startScreen = const Splash();
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => startScreen);
      case ScreensNames.home:
        return CustomPageRoute(
            direction: AxisDirection.left, child:   Home());
      case ScreensNames.login:
        return CustomPageRoute(
            direction: AxisDirection.right, child:   Login());
      case ScreensNames.register:
        return CustomPageRoute(
            direction: AxisDirection.right, child:   Register());
        case ScreensNames.onBoardingIntro:
        return CustomPageRoute(
            direction: AxisDirection.right, child:  const OnBoardingIntro());
        case ScreensNames.onBoarding:
        return CustomPageRoute(
            direction: AxisDirection.right, child:  const OnBoarding());
        case ScreensNames.todos:
        return CustomPageRoute(
            direction: AxisDirection.right, child:   TodosScreen(
              listId: settings.arguments as int,
        ));

      default:
        return null;
    }
  }
}
