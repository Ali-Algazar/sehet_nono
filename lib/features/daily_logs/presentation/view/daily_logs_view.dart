import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sehet_nono/features/daily_logs/presentation/cubit/daily_logs_cubit.dart';
import 'widgets/daily_logs_view_body.dart';

class DailyLogsView extends StatelessWidget {
  const DailyLogsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DailyLogsCubit(),
      child: const Scaffold(body: DailyLogsViewBody()),
    );
  }
}
