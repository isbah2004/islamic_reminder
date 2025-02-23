import 'package:azan_reminder/core/common/cubit/app_user/app_user_cubit.dart';
import 'package:azan_reminder/core/common/network/network_checker.dart';
import 'package:azan_reminder/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:azan_reminder/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:azan_reminder/features/auth/domain/repository/auth_repository.dart';
import 'package:azan_reminder/features/auth/domain/usecases/current_user.dart';
import 'package:azan_reminder/features/auth/domain/usecases/user_login.dart';
import 'package:azan_reminder/features/auth/domain/usecases/user_signup.dart';
import 'package:azan_reminder/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:azan_reminder/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  _initAuth();
  serviceLocator.registerFactory(() => InternetConnection());

  // core
  serviceLocator.registerLazySingleton(() => AppUserCubit());
  serviceLocator.registerFactory<ConnectionChecker>(
    () => ConnectionCheckerImpl(serviceLocator()),
  );
}

void _initAuth() {
  serviceLocator.registerLazySingleton(() => FirebaseFirestore.instance);
  serviceLocator.registerLazySingleton(() => FirebaseAuth.instance);

  serviceLocator
    ..registerFactory<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(serviceLocator(), serviceLocator()),
    )
    ..registerFactory<AuthRepository>(
      () => AuthRepositoryImpl(serviceLocator(), serviceLocator()),
    )
    ..registerFactory(() => UserSignUp(serviceLocator()))
    ..registerFactory(() => UserLogin(serviceLocator()))
    ..registerFactory(() => CurrentUser(serviceLocator()))
    ..registerLazySingleton(
      () => AuthBloc(
        userSignUp: serviceLocator(),
        userLogin: serviceLocator(),
        currentUser: serviceLocator(),
        appUserCubit: serviceLocator(),
      ),
    );
}
