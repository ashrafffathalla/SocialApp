import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_flutter/models/shop_app/login_model.dart';
import 'package:udemy_flutter/models/social_app/social_user_model.dart';
import 'package:udemy_flutter/modules/shop_app/login/cubit/states.dart';
import 'package:udemy_flutter/modules/shop_app/rigister/cubit/states.dart';
import 'package:udemy_flutter/modules/social_app/social_app_rigister/cubit/states.dart';
import 'package:udemy_flutter/shared/network/end_point.dart';
import 'package:udemy_flutter/shared/network/remote/dio_helper.dart';

class SocialRegisterCubit extends Cubit<SocialRegisterStates>
{
  SocialRegisterCubit() : super(SocialRegisterInitialState());
static SocialRegisterCubit get(context) => BlocProvider.of(context);

//post data method
void userRegister({
  required String name,
  required String email,
  required String password,
  required String phone,
})
{
  emit(SocialRegisterLoadingState());
  FirebaseAuth.instance.createUserWithEmailAndPassword(
    email: email,
    password: password,
  ).then((value)
  {
    print(value.user!.email);
    print(value.user!.uid);
    userCreate(
        name: name,
        email: email,
        phone: phone,
        uId: value.user!.uid,
    );
  }).catchError((error){
    emit(SocialRegisterErrorState(error.toString()));
  });

}
//Start user create with FireStore
 void userCreate({
   required String name,
   required String email,
   required String phone,
   required String uId,

})
{
  SocialUserModel model = SocialUserModel(
    name: name,
    email: email,
    phone: phone,
    uId: uId,
    bio: 'Write your bio...',
    image: 'https://image.freepik.com/free-photo/positive-young-caucasian-male-with-pleasant-friendly-smile-shows-white-teeth-rejoices-new-stage-life-wears-casual-striped-sweater-round-spectacles-stands-alone-against-pink-wall_273609-14966.jpg',
    cover: 'https://image.freepik.com/free-photo/positive-young-caucasian-male-with-pleasant-friendly-smile-shows-white-teeth-rejoices-new-stage-life-wears-casual-striped-sweater-round-spectacles-stands-alone-against-pink-wall_273609-14966.jpg',
    isEmailVerified: false,
  );
  FirebaseFirestore.instance
      .collection('users')
      .doc(uId)
      .set(model.toMap()!)
      .then((value)
  {
        emit(SocialCreateUserSuccessState());
  }).catchError((error)
  {
    emit(SocialCreateUserErrorState(error.toString()));
  });
}
  //end user create
IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;
void changePasswordVisibility()
{
  isPassword = !isPassword;
  suffix = isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
  emit(SocialRegisterChangePasswordVisibilityState());
}
}