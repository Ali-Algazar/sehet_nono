import 'package:flutter/material.dart';
import 'widgets/schedule_view_body.dart';

class ScheduleView extends StatelessWidget {
  const ScheduleView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: ScheduleViewBody());
  }
}
