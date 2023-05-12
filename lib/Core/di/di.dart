
import 'package:get_it/get_it.dart';
import 'package:todo_task/Core/router/app_router.dart';
import 'package:todo_task/Core/services/local/my_shared_preferences.dart';
import 'package:todo_task/Core/services/network/main_dio.dart';


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
}