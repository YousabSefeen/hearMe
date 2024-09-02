import 'package:flutter/material.dart';

class AppRouters {
  static Map<String, Widget Function(BuildContext)> routes = {
    // HomeScreen.route: (context) => const HomeScreen(),
  };

  static go({
    required BuildContext context,
    required String route,
    Object? arguments,
  }) {
    Navigator.of(context).pushNamed(route, arguments: arguments);
  }

  static pop(BuildContext context) {
    Navigator.of(context).pop();
  }

  static goAndReplacement({
    required BuildContext context,
    required String route,
    Object? arguments,
  }) {
    Navigator.of(context).pushReplacementNamed(route, arguments: arguments);
  }

  static void goAndRemoveUntil({
    required BuildContext context,
    required String route,
    Object? arguments,
  }) =>
      Navigator.of(context, rootNavigator: true).pushNamedAndRemoveUntil(
        route,
        (Route<dynamic> route) => false,
      );
}
