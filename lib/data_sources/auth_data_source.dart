import 'package:blogapp/core/exception.dart';
import 'package:blogapp/models/user_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class AuthDataSource{
  Future<UserModel>signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
});
  Future<UserModel>loginWithEmailPassword({
    required String email,
    required String password,
  });
}

class AuthDataSourceImpl implements AuthDataSource{
  final SupabaseClient supabaseClient;
  AuthDataSourceImpl(this.supabaseClient);
  @override
  Future<UserModel> loginWithEmailPassword({required String email, required String password}) async {
    try{
      final response = await supabaseClient.auth.signInWithPassword(
          password: password,
          email: email,

      );
      if(response.user == null){
        throw ServerException('User is null');
      }
      return UserModel.fromJson(response.user!.toJson());
    }catch(e){
      throw ServerException(e.toString());
    }
  }

  @override
  Future<UserModel> signUpWithEmailPassword({required String name, required String email, required String password}) async{
    try{
      final response = await supabaseClient.auth.signUp(password: password, email: email, data: {"name": name
      });
      if(response.user == null){
        throw ServerException('User is null');
      }
      return UserModel.fromJson(response.user!.toJson());
    }catch(e){
      throw ServerException(e.toString());
    }
  }
  
}