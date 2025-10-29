import 'package:flutter/material.dart';
import 'package:sehet_nono/features/auth/presentation/view/login_view.dart';

class OnboardingViewBody extends StatelessWidget {
  const OnboardingViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Onboarding View Body'),
        TextButton(
          onPressed: () {
            Navigator.pushNamedAndRemoveUntil(
              context,
              LoginView.routeName,
              (route) => false,
            );
          },
          child: Text('Get Sterting'),
        ),
      ],
    );
  }
}
