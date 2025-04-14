import 'package:blogapp/domain/auth_repository.dart';
import 'package:blogapp/error/failure.dart';
import 'package:blogapp/usecase/usecase.dart';
import 'package:fpdart/fpdart.dart';
import '../entity/user.dart';

class UserLogin implements UserCase<User,UserLoginParam >{
  final AuthRepository authRepository;
  UserLogin(this.authRepository);

  @override
  Future<Either<Failure, User>> call(UserLoginParam params) async {
    return await authRepository.loginWithEmailPassword(
        email: params.email,
        password: params.password
    );
  }

}
class UserLoginParam {
  final String email;
  final String password;

  UserLoginParam({required this.email, required this.password});
}