import 'package:flutter_bloc/flutter_bloc.dart';
import 'daily_logs_state.dart';

class DailyLogsCubit extends Cubit<DailyLogsState> {
  DailyLogsCubit() : super(DailyLogsInitial());
}
