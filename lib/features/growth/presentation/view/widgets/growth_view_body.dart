import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sehet_nono/features/growth/presentation/cubit/growth_cubit.dart';
import 'package:sehet_nono/features/growth/presentation/cubit/growth_state.dart';

class GrowthViewBody extends StatelessWidget {
  const GrowthViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GrowthCubit, GrowthState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return const Center(child: Text('Growth View Body'));
      },
    );
  }
}
