import 'package:blogapp/bloc/auth_bloc.dart';
import 'package:blogapp/common/loader.dart';
import 'package:blogapp/pages/sign_in.dart';
import 'package:blogapp/utils/show_snackbar.dart';
import 'package:blogapp/widget/auth_button.dart';
import 'package:blogapp/widget/auth_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  final emailController=TextEditingController();
  final nameController=TextEditingController();
  final passwordController=TextEditingController();
  final formKey=GlobalKey<FormState>();

  @override
  void dispose() {
    // TODO: implement dispose
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if(state is AuthFailure){
              showSnackBar(context, state.message);
            }
          },
          builder: (context, state) {
            if(state is AuthLoading){
              return const Loader();
            }
            return
              Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Center(
                        child: GradientText('Sign Up',
                          colors: [Colors.purpleAccent, Colors.pinkAccent],
                          style: TextStyle(
                              fontSize: 35, fontWeight: FontWeight.w900),
                        )
                    ),
                    SizedBox(height: 18,),
                    AuthField(text: 'name', controller: nameController,),
                    SizedBox(height: 10,),
                    AuthField(text: 'email', controller: emailController,),
                    SizedBox(height: 10,),
                    AuthField(text: 'password',
                      controller: passwordController,
                      isObscureText: true,),
                    SizedBox(height: 18,),
                    AuthButton(text: 'Sign Up', onPressed: () {
                      if (formKey.currentState!.validate()) {
                        context.read<AuthBloc>().add(AuthSignUp(
                            email: emailController.text.trim(),
                            password: passwordController.text.trim(),
                            name: nameController.text.trim()));
                      }
                    },),
                    SizedBox(height: 18,),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) => SignIn(),));
                      },
                      child: RichText(
                        text: TextSpan(
                            text: 'Already have an account? ', style: Theme
                            .of(context)
                            .textTheme
                            .titleMedium,
                            children: [
                              TextSpan(
                                  text: 'Sign In',
                                  style: Theme
                                      .of(context)
                                      .textTheme
                                      .titleMedium
                                      ?.copyWith(
                                      color: Colors.pinkAccent,
                                      fontWeight: FontWeight.bold
                                  )
                              ),
                            ]
                        ),
                      ),
                    )
                  ],
                ),
              );
          }
        ),
      ),
    );
  }
}
