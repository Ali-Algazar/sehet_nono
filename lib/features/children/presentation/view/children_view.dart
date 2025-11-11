import 'package:flutter/material.dart';
import 'widgets/children_view_body.dart';

class ChildrenView extends StatelessWidget {
  const ChildrenView({super.key});
  static const String routeName = '/children';

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: ChildrenViewBody());
  }
}
