class SocialUserModel
{
  String? name;
  String? email;
  String? phone;
  late final String uId;
  String? image;
  String? cover;
  String? bio;
  bool? isEmailVerified;

  SocialUserModel({
    this.email,
    this.name,
    this.phone,
    required this.uId,
    this.image,
    this.cover,
    this.bio,
    this.isEmailVerified,
});
  //named
  SocialUserModel.fromJson(Map<String, dynamic> json)
  {
    email = json['email'];
    name = json['name'];
    phone = json['phone'];
    uId = json['uId'];
    image = json['image'];
    cover = json['cover'];
    bio = json['bio'];
    isEmailVerified = json['isEmailVerified'];
  }

  // Function return map
  Map<String, dynamic>? toMap()
  {
    return {
      'name':name,
      'email':email,
      'phone':phone,
      'uId':uId,
      'image':image,
      'cover':cover,
      'bio':bio,
      'isEmailVerified':isEmailVerified,
    };
  }
}