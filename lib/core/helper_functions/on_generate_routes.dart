import 'package:flutter/material.dart';
import 'package:sehet_nono/features/auth/presentation/view/login_view.dart';
import 'package:sehet_nono/features/splah/presentation/view/splah_view.dart';

Route<dynamic> onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case SplahView.routeName:
      return MaterialPageRoute(builder: (_) => const SplahView());
    case LoginView.routeName:
      return MaterialPageRoute(builder: (_) => const LoginView());

    default:
      return MaterialPageRoute(
        builder: (_) =>
            const Scaffold(body: Center(child: Text('No route defined'))),
      );
  }
}
