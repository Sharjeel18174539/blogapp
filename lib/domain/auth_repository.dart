
import 'package:blogapp/entity/user.dart';
import 'package:blogapp/error/failure.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class AuthRepository{
  Future<Either<Failure, User>>signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
});
  Future<Either<Failure, User>>loginWithEmailPassword({
    required String email,
    required String password,
});
}