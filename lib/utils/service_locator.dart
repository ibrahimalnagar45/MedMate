import 'package:get_it/get_it.dart';
import 'package:midmate/core/managers/language_cubit/language_cubit.dart';
import 'package:midmate/core/managers/user_cubit/user_cubit.dart';
import 'package:midmate/features/chart/data/repos/logs_repo_impl.dart';
import 'package:midmate/features/chart/doman/repository/logs_repo.dart';
import 'package:midmate/features/chart/presentaion/manager/cubit/logs_cubit.dart';
import 'package:midmate/features/home/data/Repository/user_repo_impl.dart';
import 'package:midmate/features/home/doman/repository/meds_repo.dart';
import 'package:midmate/features/home/doman/repository/user_repo.dart';
import 'package:midmate/features/home/presentation/manager/cubit/meds_cubit.dart';
import 'package:midmate/features/today_meds/data/repos/today_meds_repo_impl.dart';
import 'package:midmate/features/today_meds/doman/today_meds_repo.dart';
import 'package:midmate/features/today_meds/presentation/manager/cubit/today_meds_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../features/home/data/Repository/meds_repo_impl.dart';
import '../features/home/data/local_data_base/crud.dart';
import 'services/shared_prefrence_service.dart';

final getIt = GetIt.instance;

Future<void> serviceLocatorSetup() async {
  final prefsService = SharedPrefrenceService.instance;
  await prefsService.init();

  getIt.registerSingleton<Crud>(Crud.instance);
  getIt.registerSingleton<SharedPreferences>(prefsService.prefs);

  // repositories
  getIt.registerSingleton<UserRepository>(UserRepoImpl(crud: Crud.instance));
  getIt.registerSingleton<MedsRepository>(MedsRepoImpl(crud: Crud.instance));
  getIt.registerSingleton<TodayMedRepo>(TodayMedsRepoImpl(crud: Crud.instance));
  getIt.registerSingleton<LogsRepo>(LogsRepoImpl(crud: Crud.instance));

  // cubits
  getIt.registerLazySingleton<UserCubit>(
    () => UserCubit(userRepo: getIt<UserRepository>()),
  );
  getIt.registerLazySingleton<LanguageCubit>(
    () => LanguageCubit(prefs: getIt<SharedPreferences>()),
  );
  getIt.registerFactory<MedsCubit>(
    () => MedsCubit(
      medsRepo: getIt<MedsRepository>(),
      userRepo: getIt<UserRepository>(),
    ),
  );
  getIt.registerFactory<TodayMedsCubit>(
    () => TodayMedsCubit(
      logRepo: getIt<LogsRepo>(),
      todayMedsRepo: getIt<TodayMedRepo>(),
      userRepo: getIt<UserRepository>(),
    ),
  );
  getIt.registerFactory<LogsCubit>(
    () => LogsCubit(
      userRepo: getIt<UserRepository>(),
      logsRepo: getIt<LogsRepo>(),
    ),
  );
}
