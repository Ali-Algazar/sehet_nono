import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:sehet_nono/core/constants.dart';
import 'package:sehet_nono/core/helper/secure_storage_helper.dart';
import 'package:sehet_nono/features/auth/data/repositories/auth_repository.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit({required this.authRepository}) : super(AuthInitial());
  AuthRepository authRepository;
  Future<void> login({required String email, required String password}) async {
    emit(AuthLoading());
    final result = await authRepository.login(email: email, password: password);
    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (user) => emit(AuthSuccess()),
    );
    var tokn = await SecureStorageHelper().read(key: kAuthTokenKey);
    print(tokn);
  }

  Future<void> register({
    required String email,
    required String password,
  }) async {
    emit(AuthLoading());
    final result = await authRepository.register(
      email: email,
      password: password,
    );
    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (user) => emit(AuthSuccess()),
    );
  }

  Future<void> logout() async {
    emit(AuthLoading());
    final result = await authRepository.logout();
    result.fold(
      (failure) => emit(AuthError(failure.message)),
      (user) => emit(AuthSuccess()),
    );
  }
}
