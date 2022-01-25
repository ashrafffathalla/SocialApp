import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_flutter/layout/social_app/social_layout.dart';
import 'package:udemy_flutter/modules/social_app/social_app_rigister/social_rigister_screen.dart';
import 'package:udemy_flutter/modules/social_app/social_login_screen/cubit/cubit.dart';
import 'package:udemy_flutter/modules/social_app/social_login_screen/cubit/states.dart';
import 'package:udemy_flutter/shared/components/components.dart';
import 'package:udemy_flutter/shared/network/local/cach_helper.dart';

class SocialLogin extends StatelessWidget {
  SocialLogin({Key? key}) : super(key: key);
  var formKey = GlobalKey<FormState>();
  
  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    return BlocProvider(
      create: (context) => SocialLoginCubit(),
      child: BlocConsumer<SocialLoginCubit, SocialLoginStates>(
        listener: (context, state) {
          if(state is SocialLoginErrorState){
            showToast(
                text: state.error,
                state: ToastStates.ERROR,
            );
          }
          if(state is SocialLoginSuccessState){
            CacheHelper.saveData(
                key: 'uId',
                value: state.uId,
            ).then((value){
              navigateAndFinish(
                  context,
                  SocialLayout(),
              );
            });
          }
        },
        builder: (context, state)
        {
         return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key:formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'LOGIN',
                          style: Theme.of(context).textTheme.headline4!.copyWith(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Login now to have fun with your friends',
                          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        defaultFormField(
                          controller:emailController,
                          type:TextInputType.emailAddress ,
                          validate: (value)
                          {
                            if(value!.isEmpty){
                              return 'Pleas enter your email address';
                            }
                          },
                          label: 'Email Address',
                          prefix: Icons.email_outlined,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        defaultFormField(
                          controller:passwordController,
                          type:TextInputType.visiblePassword ,
                          validate: (value)
                          {
                            if(value!.isEmpty){
                              return 'password is to short';
                            }
                          },
                          label: 'Password',
                          prefix: Icons.lock_outlined,
                          suffix: SocialLoginCubit.get(context).suffix,
                          onSubmit: (value)
                          {
                            if(formKey.currentState!.validate())
                            {
                              SocialLoginCubit.get(context).userLogin(
                                  email: emailController.text,
                                  password: passwordController.text
                              );
                            }
                          },

                          isPassword: SocialLoginCubit.get(context).isPassword,
                          suffixPressed: ()
                          {
                            SocialLoginCubit.get(context).changePasswordVisibility();
                          },
                        ),
                        const SizedBox(
                          height: 30,
                        ),

                        ConditionalBuilder(
                          condition: state is! SocialLoginLoadingState ,
                          builder: (context)=>defaultButton(
                            function: () {
                              if (formKey.currentState!.validate()) {
                                SocialLoginCubit.get(context).userLogin(
                                    email: emailController.text,
                                    password: passwordController.text,
                                );
                              }
                            },
                           text: 'LOGIN',
                            ),
                          fallback: (context)=> const Center(child:  CircularProgressIndicator()),
                        ),

                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const  Text('Don\'t have an account?',),
                            TextButton(
                              onPressed: ()
                              {
                                navigateAndFinish(
                                  context,
                                  SocialRegisterScreen(),
                                );
                              },
                              child: const Text(
                                'Register',
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
