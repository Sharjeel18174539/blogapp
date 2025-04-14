import 'package:blogapp/auth_repository/auth_repository_ipml.dart';
import 'package:blogapp/bloc/auth_bloc.dart';
import 'package:blogapp/data_sources/auth_data_source.dart';
import 'package:blogapp/domain/auth_repository.dart';
import 'package:blogapp/usecase/user_sign_up.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../secrets/app_secret.dart';
import '../usecase/user_login.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies () async {
  _initAuth();
  final supabase = await Supabase.initialize(
      url: AppSecrets.supabaseUrl,
      anonKey: AppSecrets.supabaseAnonKey
  );
  serviceLocator.registerLazySingleton( () => supabase.client);
}

void _initAuth(){
  serviceLocator.registerFactory<AuthDataSource>(
          () => AuthDataSourceImpl(
              serviceLocator(),
          ));
  
  serviceLocator.registerFactory<AuthRepository>(
          () => AuthRepositoryImpl(
              serviceLocator(),
          ));
  serviceLocator.registerFactory(
          () => UserSignUp(
              serviceLocator(),
          ));
  serviceLocator.registerFactory(
          () => UserLogin(
        serviceLocator(),
      ));
  
  serviceLocator.registerLazySingleton(
          () =>AuthBloc(
              userSignUp: serviceLocator(),
              userLogin: serviceLocator(),
          ));
}