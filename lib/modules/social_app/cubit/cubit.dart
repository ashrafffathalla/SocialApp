import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:udemy_flutter/models/social_app/message_model.dart';
import 'package:udemy_flutter/models/social_app/post_model.dart';
import 'package:udemy_flutter/models/social_app/social_user_model.dart';
import 'package:udemy_flutter/modules/shop_app/settings/settings_screen.dart';
import 'package:udemy_flutter/modules/social_app/chats/chatss_screen.dart';
import 'package:udemy_flutter/modules/social_app/cubit/states.dart';
import 'package:udemy_flutter/modules/social_app/feeds/feeds_screen.dart';
import 'package:udemy_flutter/modules/social_app/new_post/new_post_screen.dart';
import 'package:udemy_flutter/modules/social_app/settings/settings_screen.dart';
import 'package:udemy_flutter/modules/social_app/users/users_screen.dart';
import 'package:udemy_flutter/shared/components/constance.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class SocialCubit extends Cubit<SocialStates>
{
  SocialCubit(): super(SocialInitialState());
  static SocialCubit get(context) => BlocProvider.of(context);

  SocialUserModel? userModel ;

  void getUserData()
  {
    emit(SocialGetUserLoadingState());
    FirebaseFirestore.instance.collection('users')
        .doc(uId)
        .get()
        .then((value){
          //print(value.data());
          userModel = SocialUserModel.fromJson(value.data()!);
          emit(SocialGetUserSuccessState());
    })
        .catchError((error)
    {
      print(error.toString());
      emit(SocialGetUserErrorState(error));
    });
  }

  // List of screens to Bottom nav
int currentIndex = 0;
List<Widget> screens =
[
  const FeedsScreen(),
  const ChatsScreen(),
   NewPostScreen(),
  const UsersScreen(),
  const SocialSettingsScreen(),
];
 // list of Titles
  List<String> titles =
  [
    'Home',
    'Chats',
    'Post',
    'Users',
    'Settings',
  ];
  void changeBottomNav(int index)
  {
    if(index == 1)
      {
    getUsers();
      }
    if(index == 2)
    {
      emit(SocialNewPostState());
    }else
      {
        currentIndex = index;
      emit(SocialChangeBottomNavState());
    }
  }

  //// End BotttomNav

  //Start use image picker for change profile
  File? profileImage;
  var picker = ImagePicker();
  Future<void> getProfileImage() async
  {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      emit(SocialProfileImagePikedSuccessState());
    } else
    {
      print('No image selected.');
      emit(SocialProfileImagePikedErrorState());
    }
  }
//End use image picker

//Start use image picker for change cover
  File? coverImage;
  Future<void> getCoverImage() async
  {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      coverImage = File(pickedFile.path);
      emit(SocialCoverImagePikedSuccessState());
    } else
    {
      print('No image selected.');
      emit(SocialCoverImagePikedErrorState());
    }
  }
//End use image picker for change cover

// Start upload profile & cover  image

  //String profileImageUrl = '';
  void uploadProfileImage({
    required String name,
    required String phone,
    required String bio,
})
{
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!) //mean upload
        .then((value)
    {
      value.ref.getDownloadURL().then((value)
      {
        emit(SocialUploadProfileImageSuccessState());
        print(value);
       // profileImageUrl = value;
        updateUser(
            name: name,
            phone: phone,
            bio: bio,
          image: value,
        );
      }).catchError((error)
      {
        emit(SocialUploadProfileImageErrorState());
      });
    })
        .catchError((error)
    {
      emit(SocialUploadProfileImageErrorState());
    });
}
//end profile
  //String coverImageUrl = '';
  void uploadCoverImage({
    required String name,
    required String phone,
    required String bio,
  })
  {
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(coverImage!.path).pathSegments.last}')
        .putFile(coverImage!) //mean upload
        .then((value)
    {
      value.ref.getDownloadURL().then((value)
      {
        emit(SocialUploadCoverImageSuccessState());
        print(value);
        //coverImageUrl = value;
        updateUser(
            name: name,
            phone: phone,
            bio: bio,
          cover: value,
        );
      }).catchError((error)
      {
        emit(SocialUploadCoverImageErrorState());
      });
    })
        .catchError((error)
    {
      emit(SocialUploadCoverImageErrorState());
    });
  }
// end upload profile & cover image

//start update user
void updateUser({
  required String name,
  required String phone,
  required String bio,
  String? cover,
  String? image,
})
{
  emit(SocialUserUpdateLoadingState());
  SocialUserModel model = SocialUserModel(
    name: name,
    phone: phone,
    email: userModel!.email,
    cover:cover??userModel!.cover,
    image: image??userModel!.image,
    uId: userModel!.uId,
    bio: bio,
    isEmailVerified: false,
  );
  FirebaseFirestore.instance.collection('users')
      .doc(uId)
      .update(model.toMap()!)
      .then((value)
  {
    getUserData();
  })
      .catchError((error){
        emit(SocialUserUpdateErrorState());
  });
}
//end update user

// Start upload Post image
  File? postImage;
  Future<void> getPostImage() async
  {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      postImage = File(pickedFile.path);
      emit(SocialPostImagePikedSuccessState());
    } else
    {
      print('No image selected.');
      emit(SocialPostImagePikedErrorState());
    }
  }
//End upload Post image picker

// Start remove Post image

  void removePostImage()
  {
    postImage = null;
    emit(SocialRemovePostImageState());
  }
//End remove Post image

//start createNewPost
void uploadPostImage({
  required String dateTime,
  required String text,
})
{
  emit(SocialCreatePostLoadingState());
  firebase_storage.FirebaseStorage.instance
  .ref()
  .child('posts/${Uri.file(postImage!.path).pathSegments.last}')
  .putFile(postImage!)
  .then((value){
    value.ref.getDownloadURL().then((value){
      print(value);
      createPost(
        dateTime: dateTime,
        text: text,
        postImage:value,
      );
    });
  }).catchError((error){
    emit(SocialCreatePostImageErrorState());
  }).catchError((error){
    emit(SocialCreatePostImageErrorState());
  });
}
//end start createNewPost

  //start createPost
  void createPost({
    required String dateTime,
    required String text,
    String? postImage,
  })
  {
    emit(SocialUserUpdateLoadingState());
    PostModel model = PostModel(
      name: userModel!.name,
      image: userModel!.image,
      uId: userModel!.uId,
      dateTime: dateTime,
      text: text,
      postImage: postImage??'',
    );
    FirebaseFirestore.instance
        .collection('posts')
        .add(model.toMap()!)
        .then((value){
      emit(SocialCreatePostSuccessState());
    })
        .catchError((error){
      emit(SocialCreatePostErrorState());
    });
  }
//end createPost

//start get posts from firebase
List<PostModel> posts = [];
List<String> postId = [];
List<int> likes =[];
List<int> comments =[];
  void getPosts()
  {
    FirebaseFirestore.instance
    .collection('posts')
    .get()
    .then((value)
    {
      value.docs.forEach((element)
      {
        element.reference
        .collection('likes')
        .get()
        .then((value){
          comments.add(value.docs.length);
          likes.add(value.docs.length);
          postId.add(element.id);
          posts.add(PostModel.fromJson(element.data()));
        })
        .catchError((error){});

      });
      emit(SocialGetPostsSuccessState());
    }).catchError((error){
      emit(SocialGetPostsErrorState(error.toString()));
    });
  }
//end get posts from firebase

//Start LikePost
void likePost(String postId)
{
  FirebaseFirestore.instance
  .collection('posts')
  .doc(postId)
  .collection('likes')
  .doc(userModel!.uId)
  .set({
    'like': true,
  }).then((value){
    emit(SocialLikePostSuccessState());
  }).catchError((error){
    emit(SocialLikePostErrorState(error.toString()));
  });
}
//end LikePost

//Start CommentPost
void commentPost(String postId)
{
  FirebaseFirestore.instance
      .collection('posts')
      .doc(postId)
      .collection('comments')
      .doc(userModel!.uId)
      .set({
    'comment': true,
  }).then((value)
  {
    emit(SocialCommentPostSuccessState());
  }).catchError((error)
  {
    emit(SocialCommentPostErrorState(error.toString()));
  });
}
//end CommentPost

//Start Get All Users
List<SocialUserModel> allUsers = [];
  void getUsers ()
  {
    if(allUsers.isEmpty)
    {
      FirebaseFirestore.instance
        .collection('users')
        .get()
        .then((value)
    {
      value.docs.forEach((element) {
        if(element.data()['uId'] != userModel!.uId) {
          allUsers.add(SocialUserModel.fromJson(element.data()));
        }
      });
      emit(SocialGetAllUserSuccessState());
    }
        ).catchError((error)
    {
          SocialGetAllUserErrorState(error.toString());
    });
    }
  }
//End Get All Users

//Start Send Message Method
void sendMessage({
  required String receiverId,
  required String dateTime,
  required String text,
})
{
  //send data to model

  MessageModel model = MessageModel(
    text: text,
    senderId: userModel!.uId,
    dateTime: dateTime,
    receiverId: receiverId,

  );
  //set my chats
  FirebaseFirestore.instance
  .collection('users')
  .doc(userModel!.uId)
  .collection('chats')
  .doc(receiverId)
  .collection('messages')
  .add(model.toMap()!)
  .then((value){
    emit(SocialSendMessagesSuccessState());
  })
  .catchError((error){
    emit(SocialSendMessagesErrorState());
  });
  //end set my chats

  //set receiver chats
  FirebaseFirestore.instance
      .collection('users')
      .doc(receiverId)
      .collection('chats')
      .doc(userModel!.uId)
      .collection('messages')
      .add(model.toMap()!)
      .then((value){
    emit(SocialSendMessagesSuccessState());
  })
      .catchError((error){
    emit(SocialSendMessagesErrorState());
  });
  //end set receiver chats
}

// Start Get Messages
List<MessageModel> messages = [];
  void getMessage({
  required receiverId
})
  {
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .orderBy('dateTime')
        .snapshots()
        .listen((event)
    {
       messages =[];
      event.docs.forEach((element) {
        messages.add(MessageModel.fromJson(element.data()));
      });
      emit(SocialGetMessagesSuccessState());

    });
  }
// Start Get Messages
}