import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:sehet_nono/core/helper/secure_storage_helper.dart';
import 'package:sehet_nono/core/services/api_helper.dart';
import 'package:sehet_nono/features/auth/data/datasources/auth_local_data_source.dart';
import 'package:sehet_nono/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:sehet_nono/features/auth/data/repositories/auth_repository.dart';
import 'package:sehet_nono/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:sehet_nono/features/children/data/datasources/children_local_data_source.dart';
import 'package:sehet_nono/features/children/data/datasources/children_remote_data_source.dart';
import 'package:sehet_nono/features/children/data/repositories/children_repository.dart';
import 'package:sehet_nono/features/children/data/repositories/children_repository_impl.dart';
import 'package:sehet_nono/features/schedule/data/datasources/schedule_local_data_source.dart';
import 'package:sehet_nono/features/schedule/data/datasources/schedule_remote_data_source.dart';
import 'package:sehet_nono/features/schedule/data/repositories/schedule_repository.dart';
import 'package:sehet_nono/features/schedule/data/repositories/schedule_repository_impl.dart';

GetIt getIt = GetIt.instance;

void setupGetIt() {
  getIt.registerLazySingleton<SecureStorageHelper>(() => SecureStorageHelper());
  getIt.registerLazySingleton<ApiHelper>(
    () => ApiHelper(dio: Dio(), storageHelper: getIt<SecureStorageHelper>()),
  );
  getIt.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(apiHelper: getIt<ApiHelper>()),
  );
  getIt.registerLazySingleton<AuthLocalDataSource>(
    () => AuthLocalDataSourceImpl(storageHelper: getIt<SecureStorageHelper>()),
  );
  getIt.registerSingleton<AuthRepository>(
    AuthRepositoryImpl(
      localDataSource: getIt<AuthLocalDataSource>(),
      remoteDataSource: getIt<AuthRemoteDataSource>(),
    ),
  );
  getIt.registerLazySingleton<ChildrenRemoteDataSource>(
    () => ChildrenRemoteDataSourceImpl(apiHelper: getIt<ApiHelper>()),
  );
  getIt.registerLazySingleton<ChildrenLocalDataSource>(
    () => ChildrenLocalDataSourceImpl(),
  );
  getIt.registerSingleton<ChildrenRepository>(
    ChildrenRepositoryImpl(
      Connectivity(),
      remoteDataSource: getIt<ChildrenRemoteDataSource>(),
      localDataSource: getIt<ChildrenLocalDataSource>(),
    ),
  );
  getIt.registerSingleton<ScheduleLocalDataSource>(
    ScheduleLocalDataSourceImpl(),
  );
  getIt.registerSingleton<ScheduleRemoteDataSource>(
    ScheduleRemoteDataSourceImpl(apiHelper: getIt<ApiHelper>()),
  );
  getIt.registerSingleton<ScheduleRepository>(
    ScheduleRepositoryImpl(
      localDataSource: getIt<ScheduleLocalDataSource>(),
      remoteDataSource: getIt<ScheduleRemoteDataSource>(),
    ),
  );
}
