
import 'package:bloc_test/bloc_test.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sample_bloc/feature/main/domain/entities/login/state/login_state.dart';
import 'package:sample_bloc/feature/main/presentation/modules/login/login_cubit.dart';
import 'package:sample_bloc/mock/usecases/mock_login_user_usecase.dart';

void main() {
  group('Login Cubit', () {
    late LoginCubit loginCubit;
    MockLoginUserUsecase mockLoginUserUseCase;

    setUp(() {
      EquatableConfig.stringify = true;
      mockLoginUserUseCase = MockLoginUserUsecase();
      loginCubit = LoginCubit(loginUserUseCase: mockLoginUserUseCase);
    });

    blocTest<LoginCubit, LoginState>(
      'emits [LoginLoading, LoginSuccess] states for successful login',
      build: () => loginCubit,
      act: (cubit) => cubit.loginUser('fuad@gmail.com', '1234'),
      expect: () => [
        LoginLoading(),
        LoginSuccess(),
      ],
    );

    blocTest<LoginCubit, LoginState>(
      'emits [LoginLoading, LoginFailed] states for failed login',
      build: () => loginCubit,
      act: (cubit) => cubit.loginUser('fuad@gmail.com', ''),
      expect: () => [
        LoginLoading(),
        const LoginFailed(message: 'Error'),
      ],
    );

    tearDown(() {
      loginCubit.close();
    });
  });
}