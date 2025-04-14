import 'package:blogapp/domain/auth_repository.dart';
import 'package:blogapp/entity/user.dart';
import 'package:blogapp/error/failure.dart';
import 'package:blogapp/usecase/usecase.dart';
import 'package:fpdart/src/either.dart';

class UserSignUp implements UserCase< User, UserSignUpParams>{
  final AuthRepository authRepository;
  const UserSignUp(this.authRepository);
  @override
  Future<Either<Failure, User>> call(UserSignUpParams params) async {


    // TODO: implement call
    return await authRepository.signUpWithEmailPassword(
        name: params.name,
        email: params.email,
        password: params.password
    );
  }

}

class UserSignUpParams{
  final String email;
  final String password;
  final String name;
  UserSignUpParams({
    required this.email,
    required this.password,
    required this.name
  });
}