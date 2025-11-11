import 'package:flutter/material.dart';
import 'package:sehet_nono/core/constants.dart';
import 'package:sehet_nono/core/helper/secure_storage_helper.dart';
import 'package:sehet_nono/core/services/shared_preferences_service.dart';
import 'package:sehet_nono/features/auth/presentation/view/login_view.dart';
import 'package:sehet_nono/features/onboarding/presentation/view/onboarding_view.dart';

class SplahViewBody extends StatefulWidget {
  const SplahViewBody({super.key});

  @override
  State<SplahViewBody> createState() => _SplahViewBodyState();
}

class _SplahViewBodyState extends State<SplahViewBody> {
  @override
  void initState() {
    super.initState();
    goToNextView();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: const [Text('Splash View Body')]);
  }

  Future<void> goToNextView() async {
    await Future.delayed(const Duration(seconds: 3));

    var token = await SecureStorageHelper().read(key: kAuthTokenKey);

    if (token != null) {
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      var isonboardingShow =
          await SharedPreferencesService.getData(key: kIsOnboardingShowKey) ??
          false;

      isonboardingShow
          ? Navigator.pushReplacementNamed(context, LoginView.routeName)
          : Navigator.pushReplacementNamed(context, OnboardingView.routeName);
    }
  }
}
