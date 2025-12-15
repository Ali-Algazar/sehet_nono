import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sehet_nono/features/daily_logs/presentation/cubit/daily_logs_cubit.dart';
import 'package:sehet_nono/features/daily_logs/presentation/cubit/daily_logs_state.dart';

class DailyLogsViewBody extends StatelessWidget {
  const DailyLogsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DailyLogsCubit, DailyLogsState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return const Center(child: Text('DailyLogs View Body'));
      },
    );
  }
}
