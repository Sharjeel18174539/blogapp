import 'package:blogapp/error/failure.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../usecase/user_login.dart';
import '../usecase/user_sign_up.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState>{
  final UserLogin _userLogin;
  final UserSignUp _userSignUp;
   AuthBloc({
    required UserSignUp userSignUp,
     required UserLogin userLogin,
}) : _userSignUp = userSignUp,
   _userLogin=userLogin,
         super(AuthInitial()){
     on<AuthSignUp>(_onAuthSignUp);
     on<AuthLogin>(_onAuthLogin);
   }

   void _onAuthSignUp(AuthSignUp event, Emitter<AuthState> emit){
     (event , emit) async{
       final res = await _userSignUp(
           UserSignUpParams(
               email: event.email,
               password: event.password,
               name: event.name
           ));
       res.fold(
               (failure)=> emit(AuthFailure(failure.message)),
               (user) => emit(AuthSuccess(user as User))
       );
     };
   }

   void _onAuthLogin(AuthLogin event, Emitter<AuthState> emit) async{
     emit(AuthLoading());

    final res = await _userLogin(UserLoginParam(
        email: event.email,
        password: event.password
    ),
    );
    res.fold((l) => emit(AuthFailure(l.message)), (r) => AuthSuccess(r as User));
   }
}