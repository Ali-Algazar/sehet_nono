import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sehet_nono/core/services/get_it_service.dart';
import 'package:sehet_nono/features/auth/data/repositories/auth_repository.dart';
import 'package:sehet_nono/features/auth/presentation/cubit/auth_cubit.dart';
import 'widgets/login_view_body.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  static const routeName = '/login';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(authRepository: getIt<AuthRepository>()),
      child: const Scaffold(body: LoginViewBody()),
    );
  }
}
