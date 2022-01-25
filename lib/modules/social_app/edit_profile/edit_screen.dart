import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:udemy_flutter/models/user/user.dart';
import 'package:udemy_flutter/modules/social_app/cubit/cubit.dart';
import 'package:udemy_flutter/modules/social_app/cubit/states.dart';
import 'package:udemy_flutter/shared/components/components.dart';
import 'package:udemy_flutter/shared/styles/icon_broken.dart';

class EditProfileScreen extends StatelessWidget {
    //const EditProfileScreen({Key? key}) : super(key: key);

  var nameController = TextEditingController();
  var bioController = TextEditingController();
  var phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state)
      {

      },
      builder: (context, state)
      {
         var userModel = SocialCubit.get(context).userModel;
         var profileImage = SocialCubit.get(context).profileImage;
         var coverImage = SocialCubit.get(context).coverImage;

         nameController.text = userModel!.name!;
         bioController.text = userModel.bio!;
         phoneController.text = userModel.phone!;
        return Scaffold(
            appBar:AppBar(
              titleSpacing: 5.0,
              title:const Text(
                'Edit Profile',
              ),
              leading: IconButton(
                icon:const Icon(
                  IconBroken.Arrow___Left_2,
                ),
                onPressed: (){
                  Navigator.pop(context);
                },
              ),
              actions:[
                TextButton(
                  onPressed: ()
                  {
                    SocialCubit.get(context).updateUser(
                      name: nameController.text,
                      phone: phoneController.text,
                      bio: bioController.text,
                    );
                  },
                  child:Text(
                    'UPDATE',
                    style: Theme.of(context).textTheme.bodyText2!.copyWith(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 15.0,
                ),

              ],
            ),
          body:SingleChildScrollView(
            physics:const BouncingScrollPhysics(),
            child: Column(
              children:[
                Container(
                  height: 215,
                  child: Stack(
                    alignment: AlignmentDirectional.bottomCenter,
                    children:
                    [
                      Align(
                        child: Stack(
                          alignment: AlignmentDirectional.topEnd,
                          children:
                          [
                            Container(
                              height: 165.0,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius:const BorderRadius.only(
                                  topLeft: Radius.circular(5.0),
                                  topRight: Radius.circular(5.0),
                                ),
                                image: DecorationImage(
                                  image: coverImage == null ? NetworkImage(
                                    '${userModel .cover}',
                                  ) : FileImage(coverImage) as ImageProvider,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            IconButton(
                                onPressed: ()
                                {
                                  SocialCubit.get(context).getCoverImage();                                },
                                icon:const CircleAvatar(
                                  radius: 15.0,
                                  backgroundColor:Colors.grey,
                                  child: Icon(
                                    Icons.camera_alt,
                                    size: 16.0,
                                    color: Colors.black,
                                  ),
                                ),
                            ),
                          ],
                        ),
                        alignment: AlignmentDirectional.topCenter,
                      ),
                      Stack(
                        alignment: AlignmentDirectional.bottomEnd,
                        children: [
                          CircleAvatar(
                            radius: 64,
                            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                            child: CircleAvatar(
                              radius: 60.0,
                              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                              backgroundImage: profileImage == null ? NetworkImage(
                                '${userModel.image}',
                              ) : FileImage(profileImage) as ImageProvider,),
                          ),
                          IconButton(
                            onPressed: ()
                            {
                              SocialCubit.get(context).getProfileImage();
                            },
                            icon:const CircleAvatar(
                              radius: 15.0,
                              backgroundColor:Colors.grey,
                              child: Icon(
                                Icons.camera_alt,
                                size: 16.0,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),

                    ],
                  ),
                ),
                const SizedBox(height: 20.0,),
                if(SocialCubit.get(context).profileImage !=null || SocialCubit.get(context).coverImage !=null)
                Row(
                  children: [
                    if(SocialCubit.get(context).profileImage !=null)
                    Expanded(
                      child: Column(
                        children: [
                          OutlinedButton(
                              onPressed: ()
                              {
                                SocialCubit.get(context).uploadProfileImage(name: nameController.text, phone: phoneController.text, bio: bioController.text);
                              },
                              child:const Text(
                                'Save Update',
                                style: TextStyle(
                                  color: Colors.black54,
                                ),
                              ),
                          ),
                          //const LinearProgressIndicator(),
                        ],
                      ),
                    ),
                    const SizedBox(width: 10,),
                    if(SocialCubit.get(context).coverImage !=null)
                    Expanded(
                      child: Column(
                        children: [
                          OutlinedButton(
                              onPressed: ()
                              {
                                SocialCubit.get(context).uploadCoverImage(name: nameController.text, phone: phoneController.text, bio: bioController.text);
                              },
                              child:const Text(
                                'Save Update',
                                style: TextStyle(
                                  color: Colors.black54,
                                ),
                              ),
                          ),
                          //const LinearProgressIndicator(),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20.0,),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: defaultFormField(
                      controller: nameController,
                      type: TextInputType.name,
                      validate:(value)
                      {
                        if(value!.isEmpty)
                          {
                            return 'name must not be empty';
                          }
                        return null;
                      },
                      label: 'Name',
                      prefix: IconBroken.User,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: defaultFormField(
                      controller: bioController,
                      type: TextInputType.name,
                      validate:(value)
                      {
                        if(value!.isEmpty)
                          {
                            return 'bio must not be empty';
                          }
                        return null;
                      },
                      label: 'Bio',
                      prefix: IconBroken.Info_Circle,
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                defaultFormField(
                  controller: phoneController,
                  type: TextInputType.phone,
                  validate:(value)
                  {
                    if(value!.isEmpty)
                    {
                      return 'phone must not be empty';
                    }
                    return null;
                  },
                  label: 'Phone',
                  prefix: IconBroken.Call,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
