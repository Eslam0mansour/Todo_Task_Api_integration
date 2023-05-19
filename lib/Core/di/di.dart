
import 'package:get_it/get_it.dart';
import 'package:todo_task/Core/router/app_router.dart';
import 'package:todo_task/Core/services/local/my_shared_preferences.dart';
import 'package:todo_task/Core/services/network/main_dio.dart';
import 'package:todo_task/features/authentication/data/repos/auth-repo-impl.dart';
import 'package:todo_task/features/authentication/data/sources/remote-data-sourcce/auth-remote-data-source.dart';
import 'package:todo_task/features/authentication/domain/repository/auth_repo.dart';
import 'package:todo_task/features/authentication/domain/usecases/login_usecase.dart';
import 'package:todo_task/features/authentication/domain/usecases/register_usecase.dart';
import 'package:todo_task/features/authentication/presentation/cubit/auth_cubit.dart';


final sl = GetIt.instance;

Future<void> init() async {
  sl.registerLazySingleton<MyDio>(
        () => MyDio(),
  );
  sl.registerLazySingleton<MySharedPref>(
        () => MySharedPref(),
  );
  sl.registerLazySingleton<AppRouter>(
        () => AppRouter(),
  );
  sl.registerLazySingleton<AuthRepoImpl>(
        () => AuthRepoImpl(
          AuthRemoteDataSourceImpl(
           myDio: sl<MyDio>(),
          ),
    ),
  );

  sl.registerLazySingleton<LoginUseCase>(
        () => LoginUseCase(
          sl<AuthRepoImpl>(),
    ),
  );

  sl.registerLazySingleton<RegisterUseCase>(
        () => RegisterUseCase(
          sl<AuthRepoImpl>(),
    ),
  );
}