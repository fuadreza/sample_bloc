
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sample_bloc/core/network/exceptions/server_exception.dart';
import 'package:sample_bloc/feature/main/domain/entities/login/param/login_param.dart';
import 'package:sample_bloc/feature/main/domain/entities/login/state/login_state.dart';
import 'package:sample_bloc/feature/main/domain/usecases/login_user_usecase.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginUserUseCase loginUserUseCase;

  LoginCubit({required this.loginUserUseCase}): super(LoginInit());

  loginUser(String email, String password) async {
    emit(LoginLoading());
    try {
      await loginUserUseCase.invoke(LoginParam(email, password));
      emit(LoginSuccess());
    } on ServerException catch (error) {
      emit(LoginFailed(message: '${error.message}'));
    }
  }
}