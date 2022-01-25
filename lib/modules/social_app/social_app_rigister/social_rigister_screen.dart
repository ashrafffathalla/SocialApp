import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_flutter/layout/social_app/social_layout.dart';
import 'package:udemy_flutter/modules/social_app/social_app_rigister/cubit/cubit.dart';
import 'package:udemy_flutter/modules/social_app/social_app_rigister/cubit/states.dart';
import 'package:udemy_flutter/modules/social_app/social_login_screen/cubit/states.dart';
import 'package:udemy_flutter/modules/social_app/social_login_screen/social_login_screen.dart';
import 'package:udemy_flutter/shared/components/components.dart';


class SocialRegisterScreen extends StatelessWidget {
  SocialRegisterScreen({Key? key}) : super(key: key);
  var formKey = GlobalKey<FormState>();

  var nameController= TextEditingController();
  var emailController= TextEditingController();
  var passwordController= TextEditingController();
  var phoneController= TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialRegisterCubit, SocialRegisterStates>(
        listener: (context, state)
        {
          if(state is SocialCreateUserSuccessState)
          {
            navigateAndFinish(context,
                SocialLayout()
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: IconButton(
                onPressed: ()
                {
                  navigateAndFinish(context,
                    SocialLogin(),
                  );
                },
                icon:const Icon(
                  Icons.arrow_back_ios,
                ),
              )
            ),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'REGISTER',
                          style: Theme
                              .of(context)
                              .textTheme
                              .headline5!
                              .copyWith(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        Text(
                            'Register now to have fun with your friends',
                            style: TextStyle(
                              color: Colors.black.withOpacity(0.6),
                              fontWeight: FontWeight.bold,
                            )
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        defaultFormField(
                          controller: nameController,
                          type: TextInputType.text,
                          validate: (value) {
                            if (value!.isEmpty) {
                              return 'Pleas enter your name ';
                            }
                          },
                          label: 'User Name',
                          prefix: Icons.person,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        defaultFormField(
                          controller: emailController,
                          type: TextInputType.emailAddress,
                          validate: (value) {
                            if (value!.isEmpty) {
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
                          controller: passwordController,
                          type: TextInputType.visiblePassword,
                          validate: (value) {
                            if (value!.isEmpty) {
                              return 'password is to short';
                            }
                          },
                          label: 'Password',
                          prefix: Icons.lock_outlined,
                          suffix: SocialRegisterCubit
                              .get(context)
                              .suffix,
                          onSubmit: (value)
                          {

                          },
                          isPassword: SocialRegisterCubit
                              .get(context)
                              .isPassword,
                          suffixPressed: () {
                            SocialRegisterCubit.get(context)
                                .changePasswordVisibility();
                          },
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        defaultFormField(
                          controller: phoneController,
                          type: TextInputType.visiblePassword,
                          validate: (value) {
                            if (value!.isEmpty) {
                              return 'Pleas enter your Phone number ';
                            }
                          },
                          label: 'Phone',
                          prefix: Icons.phone,
                        ),
                        const SizedBox(
                          height: 30,
                        ),

                        ConditionalBuilder(
                          condition: state is! SocialRegisterLoadingState,
                          builder: (context) =>defaultButton(
                                function: () {
                                  if (formKey.currentState!.validate())
                                  {
                                    SocialRegisterCubit.get(context).userRegister(
                                      name: nameController.text,
                                      email: emailController.text,
                                      password: passwordController.text,
                                      phone: phoneController.text,
                                    );
                                  }
                                },
                                text: 'Register',
                              ),
                          fallback: (context) =>
                          const Center(child: CircularProgressIndicator()),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        }

    );

  }
}
