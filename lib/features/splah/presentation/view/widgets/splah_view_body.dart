import 'package:flutter/material.dart';
import 'package:sehet_nono/features/auth/presentation/view/login_view.dart';

class SplahViewBody extends StatefulWidget {
  const SplahViewBody({super.key});

  @override
  State<SplahViewBody> createState() => _SplahViewBodyState();
}

class _SplahViewBodyState extends State<SplahViewBody> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    goToNextView();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: const []);
  }

  Future<void> goToNextView() async {
    await Future.delayed(const Duration(seconds: 3));

    Navigator.pushReplacementNamed(context, LoginView.routeName);
  }
}
