import 'package:blogapp/core/exception.dart';
import 'package:blogapp/data_sources/auth_data_source.dart';
import 'package:blogapp/domain/auth_repository.dart';
import 'package:blogapp/entity/user.dart';
import 'package:blogapp/error/failure.dart';
import 'package:fpdart/fpdart.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as sb;

class AuthRepositoryImpl implements AuthRepository{
  final AuthDataSource authDataSource;
  const AuthRepositoryImpl(this.authDataSource);
  @override
  Future<Either<Failure, User>> loginWithEmailPassword({
    required String email,
    required String password}) async {
    return _getUser(
        () async => await authDataSource.loginWithEmailPassword(
            email: email,
            password: password)
    );
  }

  @override
  Future<Either<Failure, User>> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password}) async{
    return _getUser(
        () async =>  await authDataSource.signUpWithEmailPassword(
            name: name,
            email: email,
            password: password
        )
    );

  }

  Future<Either<Failure, User>>_getUser(
      Future<User>Function()fn,
      ) async{
    try{
      final user= await fn();
      return right(user);
    } on sb.AuthException catch(e){
      return left(Failure(e.message));
    } on ServerException catch(e){
      return left(Failure(e.message));
    }
  }
  
}

