import 'package:blogapp/bloc/auth_bloc.dart';
import 'package:blogapp/common/loader.dart';
import 'package:blogapp/pages/sign_up.dart';
import 'package:blogapp/utils/show_snackbar.dart';
import 'package:blogapp/widget/auth_button.dart';
import 'package:blogapp/widget/auth_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
class SignIn extends StatefulWidget {
  static route() => MaterialPageRoute(
      builder: (context) => SignUp(),);
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final emailController= TextEditingController();
  final passwordController= TextEditingController();
  final formKey= GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if(state is AuthFailure){
              showSnackBar(context, state.message);
            }
          },
          builder: (BuildContext context, state) {
            if(state is AuthLoading){
              return const Loader();
            }
            return Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: GradientText(
                      'Sign In',
                      colors: [Colors.purpleAccent, Colors.pinkAccent],
                      style: TextStyle(
                          fontSize: 45, fontWeight: FontWeight.w900),
                    ),
                  ),
                  SizedBox(height: 25,),
                  AuthField(text: 'email', controller: emailController),
                  SizedBox(height: 20,),
                  AuthField(text: 'password',
                    controller: passwordController,
                    isObscureText: true,),
                  SizedBox(height: 25,),
                  AuthButton(text: 'Sign In', onPressed: () {
                    if (formKey.currentState!.validate()) {
                      context.read<AuthBloc>().add(
                          AuthLogin(email: emailController.text.trim(),
                              password: passwordController.text.trim())
                      );
                    }
                  },),
                  SizedBox(height: 20,),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) => SignUp(),));
                    },
                    child: RichText(
                      text: TextSpan(
                          text: "Don't have an account? ", style: Theme
                          .of(context)
                          .textTheme
                          .titleMedium,
                          children: [
                            TextSpan(
                                text: 'Sign Up',
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
