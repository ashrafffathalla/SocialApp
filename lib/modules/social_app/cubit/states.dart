abstract class SocialStates{}

class SocialInitialState extends SocialStates{}

//get users states
class SocialGetUserLoadingState extends SocialStates{}

class SocialGetUserSuccessState extends SocialStates{}

class SocialGetUserErrorState extends SocialStates{
  final String error;
  SocialGetUserErrorState(this.error);
}
//end get users states
class SocialChangeBottomNavState extends SocialStates {}

class SocialNewPostState extends SocialStates {}

class SocialProfileImagePikedSuccessState extends SocialStates {}

class SocialProfileImagePikedErrorState extends SocialStates {}

class SocialCoverImagePikedSuccessState extends SocialStates {}

class SocialCoverImagePikedErrorState extends SocialStates {}

class SocialUploadProfileImageSuccessState extends SocialStates {}

class SocialUploadProfileImageErrorState extends SocialStates {}

class SocialUploadCoverImageSuccessState extends SocialStates {}

class SocialUploadCoverImageErrorState extends SocialStates {}

//update user
class SocialUserUpdateLoadingState extends SocialStates {}

class SocialUserUpdateSuccessState extends SocialStates {}

class SocialUserUpdateErrorState extends SocialStates {}
//createNewPost
class SocialCreatePostLoadingState extends SocialStates {}

class SocialCreatePostSuccessState extends SocialStates {}

class SocialCreatePostErrorState extends SocialStates {}
//upload create Post image
class SocialPostImagePikedSuccessState extends SocialStates {}

class SocialPostImagePikedErrorState extends SocialStates {}

class SocialCreatePostImageSuccessState extends SocialStates {}

class SocialCreatePostImageErrorState extends SocialStates {}
//removePostImage
class SocialRemovePostImageState extends SocialStates {}
//start get Posts states
class SocialGetPostsLoadingState extends SocialStates{}

class SocialGetPostsSuccessState extends SocialStates{}

class SocialGetPostsErrorState extends SocialStates{
  final String error;
  SocialGetPostsErrorState(this.error);
}
//end get Posts states

//start LikePost states
class SocialLikePostSuccessState extends SocialStates{}

class SocialLikePostErrorState extends SocialStates{
  final String error;
  SocialLikePostErrorState(this.error);
}
//end LikePost states


//start CommentPost states
class SocialCommentPostSuccessState extends SocialStates{}

class SocialCommentPostErrorState extends SocialStates{
  final String error;
  SocialCommentPostErrorState(this.error);
}
//end commentPost states

//Start Get ALL Users State
class SocialGetAllUserLoadingState extends SocialStates{}

class SocialGetAllUserSuccessState extends SocialStates{}

class SocialGetAllUserErrorState extends SocialStates{
  final String error;
  SocialGetAllUserErrorState(this.error);
}
//End Get ALL Users State
class SocialSendMessagesSuccessState extends SocialStates{}

class SocialSendMessagesErrorState extends SocialStates{}

class SocialGetMessagesSuccessState extends SocialStates{}

class SocialGetMessagesErrorState extends SocialStates{}
//Chat States
