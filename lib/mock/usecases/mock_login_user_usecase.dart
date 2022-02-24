
import 'package:sample_bloc/feature/main/domain/entities/login/param/login_param.dart';
import 'package:sample_bloc/feature/main/domain/repositories/pos_repository.dart';
import 'package:sample_bloc/feature/main/domain/usecases/login_user_usecase.dart';
import 'package:sample_bloc/mock/repositories/mock_pos_repository.dart';

class MockLoginUserUsecase implements LoginUserUseCase {
  @override
  Future<void> invoke(LoginParam params) {
    return repository.loginUser(params);
  }

  @override
  PosRepository get repository => MockPosRepository();

}