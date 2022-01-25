import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_flutter/models/shop_app/login_model.dart';
import 'package:udemy_flutter/modules/shop_app/login/cubit/states.dart';
import 'package:udemy_flutter/modules/social_app/social_login_screen/cubit/states.dart';
import 'package:udemy_flutter/shared/network/end_point.dart';
import 'package:udemy_flutter/shared/network/remote/dio_helper.dart';

class SocialLoginCubit extends Cubit<SocialLoginStates>
{
  SocialLoginCubit() : super(SocialLoginInitialState());
static SocialLoginCubit get(context) => BlocProvider.of(context);


//Start get data method LOGIN
void userLogin({
  required String email,
  required String password,
})
{
  emit(SocialLoginLoadingState());
  FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
    password: password,
  ).then((value){
    print(value.user!.email);
    print(value.user!.uid);
   emit(SocialLoginSuccessState(value.user!.uid));
  }).catchError((error){

    emit(SocialLoginErrorState(error.toString()));
  });
}
//end get data method LOGIN

IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;
void changePasswordVisibility()
{
  isPassword = !isPassword;
  suffix = isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
  emit(SocialChangePasswordVisibilityState());
}
}