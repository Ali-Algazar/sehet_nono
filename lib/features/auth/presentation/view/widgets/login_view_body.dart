import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sehet_nono/core/constants.dart';
import 'package:sehet_nono/core/helper/secure_storage_helper.dart';
import 'package:sehet_nono/features/auth/presentation/cubit/auth_cubit.dart';

class LoginViewBody extends StatelessWidget {
  const LoginViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        if (state is AuthInitial) {
          return Column(
            children: [
              IconButton(
                onPressed: () {
                  context.read<AuthCubit>().login(
                    email: 'test@example.com',
                    password: 'password123',
                  );
                },
                icon: const Icon(Icons.login),
              ),
            ],
          );
        }
        return Column(
          children: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.login)),
            if (state is AuthLoading)
              const CircularProgressIndicator()
            else if (state is AuthError)
              Text(state.message)
            else if (state is AuthSuccess)
              const Text('Login Successful'),
          ],
        );
      },
    );
  }
}
