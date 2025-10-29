import 'package:flutter/material.dart';
import 'package:sehet_nono/core/constants.dart';
import 'package:sehet_nono/core/helper/secure_storage_helper.dart';
import 'package:sehet_nono/features/auth/presentation/view/login_view.dart';
import 'package:sehet_nono/features/onboarding/presentation/view/onboarding_view.dart';
import 'package:sehet_nono/features/onboarding/presentation/view/widgets/onboarding_view_body.dart';

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
    return Column(children: const [Text('Splash View Body')]);
  }

  Future<void> goToNextView() async {
    await Future.delayed(const Duration(seconds: 3));

    if (SecureStorageHelper().read(key: kAuthTokenKey) != null) {
      // Navigate to HomeView if token exists
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      // Navigate to LoginView if no token exists
      Navigator.pushReplacementNamed(context, OnboardingView.routeName);
    }
  }
}
