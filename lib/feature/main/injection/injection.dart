
import 'package:get_it/get_it.dart';
import 'package:sample_bloc/core/network/base_api_client.dart';
import 'package:sample_bloc/feature/main/data/repositories/pos_repository_impl.dart';
import 'package:sample_bloc/feature/main/data/services/api/pos_api_service.dart';
import 'package:sample_bloc/feature/main/data/sources/remote/pos_remote_data_source.dart';
import 'package:sample_bloc/feature/main/domain/repositories/pos_repository.dart';
import 'package:sample_bloc/feature/main/domain/usecases/login_user_usecase.dart';
import 'package:sample_bloc/feature/main/presentation/modules/login/login_cubit.dart';

final GetIt di = GetIt.instance;

Future<void> init() async {

  //region BLoCs

  di.registerFactory(
    () => LoginCubit(
      loginUserUseCase: di(),
    ),
  );

  //endregion


  //region USE CASES

  di.registerLazySingleton(
    () => LoginUserUseCase(
      repository: di(),
    ),
  );

  //endregion


  //region REPOSITORIES

  di.registerLazySingleton<PosRepository>(
    () => PosRepositoryImpl(
      remoteDataSource: di()
    ),
  );

  //endregion


  //region DATA SOURCES

  di.registerLazySingleton<PosRemoteDataSource>(
    () => PosRemoteDataSource(
      service: di(),
    ),
  );

  //endregion


  //region SERVICES

  di.registerLazySingleton<PosApiService>(
    () => PosApiService(
      apiClient: di(),
    ),
  );

  //endregion


  //region CORES

  di.registerLazySingleton<BaseApiClient>(
    () => BaseApiClient(),
  );

  //endregion

}