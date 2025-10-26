import 'package:flutter/material.dart';

Route<dynamic> onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {

    default:
      return MaterialPageRoute(
        builder: (_) => const Scaffold(
          body: Center(child: Text('No route defined')),
        ),
      );
  }
}