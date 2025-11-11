import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sehet_nono/core/services/get_it_service.dart';
import 'package:sehet_nono/features/growth/data/repositories/growth_repository.dart';
import 'package:sehet_nono/features/growth/presentation/cubit/growth_cubit.dart';

import 'widgets/growth_view_body.dart';

class GrowthView extends StatelessWidget {
  const GrowthView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GrowthCubit(getIt<GrowthRepository>()),
      child: const Scaffold(body: GrowthViewBody()),
    );
  }
}
